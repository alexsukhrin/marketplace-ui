import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/services/product_options_service.dart'
    show DeliveryOptionService, OptionItem, PaymentOptionService;
import 'package:flutter_application_1/src/services/shoe_size_option_service.dart'
    show ShoeSizeOption, ShoeSizeService;

import '../../../../services/categories_service.dart';

import '../../../../services/listing_page_service.dart';

import '../../../themes/app_theme.dart';
import '../../../widgets/auth_widgets/auth_field.dart';
import '../../../widgets/product_creation/category_dropdown.dart';
import '../../../widgets/product_creation/character_counter.dart';
import '../../../../utils/listing_page_validator.dart';
import '../../../widgets/product_creation/description_field.dart';
import '../../../widgets/product_creation/image_up_loader.dart';
import '../../../widgets/product_creation/option_field.dart';
import '../../../widgets/shared_widgets/custom_button.dart';
import '../../../widgets/shared_widgets/title_text.dart';
import '../../../widgets/welcome_page_widgets/custom_outlined_button.dart';
import 'dart:typed_data';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
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
  List<ShoeSizeOption> shoeSizeOptions = [];

  String? selectedCategory;
  String? _selectedCondition;
  String? selectedDelivery;
  String? selectedShoeSize;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchShoSizes();
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
      final options = await ShoeSizeService.getShoeSizes();
      setState(() {
        shoeSizeOptions = options;
      });
    } catch (e) {
      print('Error loading shoe sizes: $e');
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
        });

        Navigator.pushReplacementNamed(context, '/main');
      } catch (e) {
        print('Failed to create product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(
          mainText: "Нове оголошення",
          secondaryText: "Обов’язкові поля позначені *",
        ),
        const SizedBox(height: 20),
        Container(
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
                      maxLength: 20,
                    ),

                    //category dropdown
                    const Text('Оберіть категорію товару *'),
                    const SizedBox(height: 8),
                    CategoryDropdown(
                      categories: _categories,
                      onCategorySelected: (value) {
                        setState(() {
                          selectedCategory = value;
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

                    //shoe size
                    if (selectedCategory == '14') ...[
                      const Text('Оберіть розмір взуття *'),
                      const SizedBox(height: 8),
                      CategoryDropdown(
                        categories: shoeSizeOptions
                            .map((item) =>
                                {'id': item.id, 'name': item.sizeLabel})
                            .toList(),
                        onCategorySelected: (value) {
                          setState(() {
                            selectedShoeSize = value;
                          });
                        },
                        hintText: 'Оберіть розмір',
                      ),
                    ],
                    const SizedBox(height: 16),

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
                      validator: (value) =>
                          validateCondition(_selectedCondition),
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
        ),
      ],
    );
  }
}
