import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/services/delivery_payment_service.dart'
    show DeliveryOptionService, OptionItem, PaymentOptionService;
import 'package:flutter_application_1/src/services/additional_fields_service.dart'
    show
        AdditionalFieldsOptionItem,
        ClothSizeService,
        ColorsService,
        GenderService,
        MaterialService,
        ShoeSizeOption;

import '../../../services/categories_service.dart';

import '../../../services/listing_page_service.dart';

import '../../themes/app_theme.dart';
import '../auth_widgets/auth_field.dart';
import 'category_dropdown.dart';
import 'character_counter.dart';
import '../../../utils/listing_page_validator.dart';
import 'description_field.dart';
import 'image_up_loader.dart';
import 'option_field.dart';
import '../shared_widgets/custom_button.dart';
import '../welcome_page_widgets/custom_outlined_button.dart';
import 'dart:typed_data';

class ListingForm extends StatefulWidget {
  const ListingForm({super.key});

  @override
  _ListingFormState createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ImageUploaderState> _imageUploaderKey =
      GlobalKey<ImageUploaderState>();
  bool _isButtonDisabled = true;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productBrandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final paymentController = TextEditingController();
  final deliveryController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];
  List<AdditionalFieldsOptionItem> shoeSizeOptions = [];
  List<AdditionalFieldsOptionItem> clothingSizeOptions = [];
  List<AdditionalFieldsOptionItem> colorsOptions = [];
  List<AdditionalFieldsOptionItem> materialOptions = [];
  List<AdditionalFieldsOptionItem> genderOptions = [];

  String? selectedCategory;
  String? _selectedCondition;
  String? selectedDelivery;
  String? selectedShoeSize;
  String? selectedClothingSize;
  String? selectedColor;
  String? selectedMaterial;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchShoSizes();
    _fetchClothingSizes();
    _fetchColor();
    _fetchMaterial();
    _fetchGender();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _fetchShoSizes() async {
    try {
      final options = await ShoeSizeOption.getOptions();
      setState(() {
        shoeSizeOptions = options;
      });
    } catch (e) {
      print('Error loading shoe sizes: $e');
    }
  }

  Future<void> _fetchClothingSizes() async {
    try {
      final options = await ClothSizeService.getOptions();
      setState(() {
        clothingSizeOptions = options;
      });
    } catch (e) {
      print('Error loading clothing sizes: $e');
    }
  }

  Future<void> _fetchColor() async {
    try {
      final options = await ColorsService.getOptions();
      setState(() {
        colorsOptions = options;
      });
    } catch (e) {
      print('Error loading clothing sizes: $e');
    }
  }

  Future<void> _fetchMaterial() async {
    try {
      final options = await MaterialService.getOptions();
      setState(() {
        materialOptions = options;
      });
    } catch (e) {
      print('Error loading clothing sizes: $e');
    }
  }

  Future<void> _fetchGender() async {
    try {
      final options = await GenderService.getOptions();
      setState(() {
        genderOptions = options;
      });
    } catch (e) {
      print('Error loading clothing sizes: $e');
    }
  }

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  void _onConditionSelected(String condition) {
    setState(() {
      _selectedCondition = condition;
    });
  }

  Future<void> _onSubmit() async {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      print("Категорія не вибрана");
      return;
    }
    print("Selected Category before submit: $selectedCategory");

    final List<Uint8List> images = _imageUploaderKey.currentState?.images ?? [];

    if ((_formKey.currentState?.validate() ?? false) && images.isNotEmpty) {
      try {
        print("Sending product with category: $selectedCategory");

        final Map<String, dynamic> productData = {
          'title': productNameController.text,
          'description': productDescriptionController.text,
          'brand': productBrandController.text,
          'price': priceController.text,
          'phoneNumber': phoneController.text,
          'paymentOption': paymentController.text,
          'category': selectedCategory ?? '',
          'condition': _selectedCondition ?? '',
          'deliveryOption': deliveryController.text,
          'imagesCount': images.length,
        };

        if (selectedColor != null && selectedColor!.isNotEmpty) {
          productData['color'] = selectedColor;
        }
        if (selectedMaterial != null && selectedMaterial!.isNotEmpty) {
          productData['material'] = selectedMaterial;
        }
        if (selectedGender != null && selectedGender!.isNotEmpty) {
          productData['gender'] = selectedGender;
        }
        if (selectedClothingSize != null && selectedClothingSize!.isNotEmpty) {
          productData['clothingSize'] = selectedClothingSize;
        }
        if (selectedShoeSize != null && selectedShoeSize!.isNotEmpty) {
          productData['shoeSize'] = selectedShoeSize;
        }

        print('Body we send: $productData');
        await ListingPageService.createProduct(
          title: productNameController.text,
          description: productDescriptionController.text,
          brand: productBrandController.text,
          price: double.parse(priceController.text),
          phoneNumber: phoneController.text,
          paymentOption: paymentController.text,
          category: selectedCategory ?? '',
          condition: _selectedCondition ?? '',
          deliveryOption: deliveryController.text,
          images: images,
          context: context,
          color: selectedColor,
          material: selectedMaterial,
          gender: selectedGender,
          clothingSize: selectedClothingSize,
          shoeSize: selectedShoeSize,
        );

        productNameController.clear();
        productDescriptionController.clear();
        productBrandController.clear();
        priceController.clear();
        phoneController.clear();
        paymentController.clear();
        deliveryController.clear();
        _imageUploaderKey.currentState?.clearImages();

        setState(() {
          selectedCategory = null;
          _selectedCondition = null;
          selectedColor = null;
          selectedMaterial = null;
          selectedGender = null;
          selectedClothingSize = null;
          selectedShoeSize = null;
        });

        Navigator.pushReplacementNamed(context, '/main');
      } catch (e) {
        print('Failed to create product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 781),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            onChanged: _validateForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //photo
                const Text('Фото товару *'),
                const SizedBox(height: 8),
                ImageUploader(key: _imageUploaderKey),
                const SizedBox(height: 20),

                //product name
                AuthField(
                  labelText: 'Назва товару *',
                  controller: productNameController,
                  hintText: 'Наприклад, мікрофон професійний',
                  validator: validateProductName,
                  showSuffixIcon: (_) => false,
                  showCounter: false,
                  maxWidth: 781,
                ),
                const SizedBox(height: 4),
                CharacterCounter(
                  controller: productNameController,
                  maxLength: 30,
                ),

                //category dropdown
                const Text('Оберіть категорію товару *'),
                const SizedBox(height: 8),
                CategoryDropdown(
                  categories: _categories,
                  onCategorySelected: (value) {
                    setState(() {
                      selectedCategory = value;

                      selectedColor = null;
                      selectedClothingSize = null;
                      selectedShoeSize = null;
                    });
                    print('selectedCategory: $selectedCategory');
                  },
                  hintText: 'Усі категорії тут',
                ),
                const SizedBox(height: 20),

                //product description
                ProductDescriptionField(
                  labelText: 'Опис товару *',
                  hintText:
                      'Наприклад, товар використовувався за призначенням кілька разів.',
                  controller: productDescriptionController,
                  validator: validateProductDescription,
                ),
                const SizedBox(height: 4),
                CharacterCounter(
                  controller: productDescriptionController,
                  minLength: 30,
                  showMinLength: true,
                ),

                //gender
                if (selectedCategory == '2' || selectedCategory == '14') ...[
                  const Text('Оберіть стать *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: genderOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedGender,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    hintText: 'Оберіть стать',
                  ),
                  const SizedBox(height: 16),
                ],

                //shoe size
                if (selectedCategory == '14') ...[
                  const Text('Оберіть розмір взуття *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: shoeSizeOptions
                        .map((item) =>
                            {'category_id': item.name, 'name': item.name})
                        .toList(),
                    value: selectedShoeSize,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedShoeSize = value;
                      });
                    },
                    hintText: 'Оберіть розмір',
                  ),
                  const SizedBox(height: 16),
                ],

                //clothes size
                if (selectedCategory == '2') ...[
                  const Text('Оберіть розмір одягу *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: clothingSizeOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedClothingSize,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedClothingSize = value;
                      });
                    },
                    hintText: 'Оберіть розмір',
                  ),
                  const SizedBox(height: 16),
                ],

                //color
                if (selectedCategory == '2' || selectedCategory == '14') ...[
                  const Text('Оберіть колір *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: colorsOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedColor,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedColor = value;
                      });
                    },
                    hintText: 'Оберіть колір',
                  ),
                  const SizedBox(height: 16),
                ],

                //materal
                if (selectedCategory == '2' || selectedCategory == '14') ...[
                  const Text('Оберіть матеріал *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: materialOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedMaterial,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedMaterial = value;
                      });
                    },
                    hintText: 'Оберіть матеріал',
                  ),
                  const SizedBox(height: 16),
                ],

                //brand
                AuthField(
                  labelText: 'Бренд',
                  controller: productBrandController,
                  hintText: 'Наприклад, Nike Air.',
                  showSuffixIcon: (_) => false,
                  showCounter: false,
                  maxWidth: 781,
                ),
                const SizedBox(height: 20),

                //condition
                const Text('Стан товару *'),
                const SizedBox(height: 8),

                FormField<String>(
                  validator: (value) => validateCondition(_selectedCondition),
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomOutlinedButton(
                              text: "Новий",
                              onPressed: () {
                                _onConditionSelected('NEW');
                                formFieldState.didChange('NEW');
                              },
                              isSelected: _selectedCondition == 'NEW',
                            ),
                            const SizedBox(width: 20),
                            CustomOutlinedButton(
                              text: "Вживаний",
                              onPressed: () {
                                _onConditionSelected('USED');
                                formFieldState.didChange('USED');
                              },
                              isSelected: _selectedCondition == 'USED',
                            ),
                          ],
                        ),
                        if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              formFieldState.errorText!,
                              style: const TextStyle(
                                color: AppTheme.textError,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                //price
                Stack(
                  children: [
                    AuthField(
                      labelText: 'Ціна *',
                      controller: priceController,
                      hintText: '',
                      validator: validatePrice,
                      showCounter: false,
                      showSuffixIcon: (_) => false,
                      maxWidth: 781,
                    ),
                    const Positioned(
                      right: 16,
                      top: 43,
                      child: Text(
                        '₴',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.blackText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  'Введіть ціну за 1 шт.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                //delivery
                OptionField<OptionItem>(
                  labelText: 'Способи доставки *',
                  controller: deliveryController,
                  getOptions: DeliveryOptionService.getOptions,
                  getOptionName: (OptionItem option) => option.name,
                  getOptionId: (OptionItem option) => option.id,
                  validator: validateDeliveryOption,
                ),

                const SizedBox(height: 20),

                // //payment
                OptionField<OptionItem>(
                  labelText: 'Способи оплати *',
                  controller: paymentController,
                  getOptions: PaymentOptionService.getOptions,
                  getOptionName: (OptionItem option) => option.name,
                  getOptionId: (OptionItem option) => option.id,
                  validator: validatePaymentOption,
                ),

                const SizedBox(height: 20),

                //phone number
                AuthField(
                  labelText: 'Номер телефону *',
                  controller: phoneController,
                  hintText: '+38',
                  validator: validatePhoneNumber,
                  showCounter: false,
                  showSuffixIcon: (_) => false,
                  maxWidth: 781,
                ),
                const SizedBox(height: 4),
                CharacterCounter(
                  controller: phoneController,
                  maxLength: 10,
                ),

                const SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        text: 'Опублікувати оголошення',
                        onPressed: _isButtonDisabled ? null : _onSubmit,
                        isButtonDisabled: _isButtonDisabled,
                        buttonType: ButtonType.filled,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Перевірте усю інформацію, будь ласка.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
