import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/services/delivery_payment_service.dart';
import 'package:flutter_application_1/src/services/additional_fields_service.dart';

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
  List<AdditionalFieldsOptionItem> genderOptions = [];
  List<AdditionalFieldsOptionItem> shoeMaterials = [];
  List<AdditionalFieldsOptionItem> clothingMaterials = [];
  List<AdditionalFieldsOptionItem> homeMaterials = [];
  List<AdditionalFieldsOptionItem> homeTypes = [];
  List<AdditionalFieldsOptionItem> electronisTypes = [];
  List<AdditionalFieldsOptionItem> autoTypes = [];
  List<AdditionalFieldsOptionItem> stationeryTypes = [];
  List<AdditionalFieldsOptionItem> activityTypes = [];
  List<AdditionalFieldsOptionItem> waterSportsTypes = [];
  List<AdditionalFieldsOptionItem> cyclingTypes = [];
  List<AdditionalFieldsOptionItem> childrenTypes = [];
  List<AdditionalFieldsOptionItem> gardenTypes = [];
  List<AdditionalFieldsOptionItem> bookGenre = [];
  List<AdditionalFieldsOptionItem> bookBinding = [];
  List<AdditionalFieldsOptionItem> bookLanguages = [];

  String? selectedCategory;
  String? _selectedCondition;
  String? selectedDelivery;
  String? selectedShoeSize;
  String? selectedClothingSize;
  String? selectedColor;
  String? selectedGender;
  String? selectedActivityValue;
  String? selectedbookBinding;
  String? selectedbookLanguages;
  String? selectedbookGenre;
  String? selectedShoeMaterials;
  String? selectedClothingMaterials;
  String? selectedHomeMaterials;
  String? selectedHomeTypes;
  String? selectedElectronisTypes;
  String? selectedAutoTypes;
  String? selectedStationeryTypes;
  String? selectedActivityTypes;
  String? selectedWaterSportsTypes;
  String? selectedCyclingTypes;
  String? selectedChildrenTypes;
  String? selectedGardenTypes;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchShoSizes();
    _fetchClothingSizes();
    _fetchColor();
    _fetchGender();
    _fetchAdditionalFields();
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

  Future<void> _fetchAdditionalFields() async {
    try {
      final options = await RestOptionsService.getAllOptions();
      setState(() {
        shoeMaterials = options['shoe_materials'] ?? [];
        clothingMaterials = options['clothing_materials'] ?? [];
        homeMaterials = options['home_materials'] ?? [];
        homeTypes = options['home_types'] ?? [];
        electronisTypes = options['electronics_types'] ?? [];
        autoTypes = options['auto_types'] ?? [];
        stationeryTypes = options['stationery_types'] ?? [];
        activityTypes = options['activity_types'] ?? [];
        waterSportsTypes = options['water_sports_types'] ?? [];
        cyclingTypes = options['cycling_types'] ?? [];
        childrenTypes = options['children_types'] ?? [];
        gardenTypes = options['garden_types'] ?? [];
        bookGenre = options['book_genres'] ?? [];
        bookBinding = options['book_binding'] ?? [];
        bookLanguages = options['book_languages'] ?? [];
      });
    } catch (e) {
      print('Error loading additional fields: $e');
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
        if (selectedbookBinding != null && selectedbookBinding!.isNotEmpty) {
          productData['bookBinding'] = selectedbookBinding;
        }
        if (selectedbookBinding != null && selectedbookBinding!.isNotEmpty) {
          productData['bookLanguages'] = selectedbookLanguages;
        }
        if (selectedbookBinding != null && selectedbookBinding!.isNotEmpty) {
          productData['bookGenre'] = selectedbookGenre;
        }
        if (selectedGender != null && selectedGender!.isNotEmpty) {
          productData['gender'] = selectedGender;
        }
        if (selectedClothingSize != null && selectedClothingSize!.isNotEmpty) {
          productData['clothingSize'] = selectedClothingSize;
        }
        if (selectedClothingMaterials != null &&
            selectedClothingMaterials!.isNotEmpty) {
          productData['clothingMaterials'] = selectedClothingMaterials;
        }
        if (selectedShoeMaterials != null &&
            selectedShoeMaterials!.isNotEmpty) {
          productData['shoeMaterials'] = selectedShoeMaterials;
        }
        if (selectedHomeMaterials != null &&
            selectedHomeMaterials!.isNotEmpty) {
          productData['homeMaterials'] = selectedHomeMaterials;
        }
        if (selectedHomeTypes != null && selectedHomeTypes!.isNotEmpty) {
          productData['homeTypes'] = selectedHomeTypes;
        }
        if (selectedElectronisTypes != null &&
            selectedElectronisTypes!.isNotEmpty) {
          productData['electronisTypes'] = selectedElectronisTypes;
        }
        if (selectedAutoTypes != null && selectedAutoTypes!.isNotEmpty) {
          productData['autoTypes'] = selectedAutoTypes;
        }
        if (selectedStationeryTypes != null &&
            selectedStationeryTypes!.isNotEmpty) {
          productData['stationeryTypes'] = selectedStationeryTypes;
        }
        if (selectedActivityTypes != null &&
            selectedActivityTypes!.isNotEmpty) {
          productData['activityTypes'] = selectedActivityTypes;
        }
        if (selectedWaterSportsTypes != null &&
            selectedWaterSportsTypes!.isNotEmpty) {
          productData['waterSportsTypes'] = selectedWaterSportsTypes;
        }
        if (selectedCyclingTypes != null && selectedCyclingTypes!.isNotEmpty) {
          productData['cyclingTypes'] = selectedCyclingTypes;
        }
        if (selectedChildrenTypes != null &&
            selectedChildrenTypes!.isNotEmpty) {
          productData['childrenTypes'] = selectedChildrenTypes;
        }
        if (selectedGardenTypes != null && selectedGardenTypes!.isNotEmpty) {
          productData['gardenTypes'] = selectedGardenTypes;
        }
        // if (selectedActivityValue != null && selectedActivityValue!.isNotEmpty)
        //   productData['activityValue'] = selectedActivityValue;

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
          bookBinding: selectedbookBinding,
          bookGenre: selectedbookGenre,
          bookLanguages: selectedbookLanguages,
          gender: selectedGender,
          clothingSize: selectedClothingSize,
          shoeSize: selectedShoeSize,
          clothingMaterials: selectedClothingMaterials,
          shoeMaterials: selectedShoeMaterials,
          homeMaterials: selectedHomeMaterials,
          homeTypes: selectedHomeTypes,
          electronisTypes: selectedElectronisTypes,
          autoTypes: selectedAutoTypes,
          stationeryTypes: selectedStationeryTypes,
          activityTypes: selectedActivityTypes,
          waterSportsTypes: selectedWaterSportsTypes,
          cyclingTypes: selectedCyclingTypes,
          childrenTypes: selectedChildrenTypes,
          gardenTypes: selectedGardenTypes,
          // activityValue: selectedActivityValue,
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
          selectedbookBinding = null;
          selectedGender = null;
          selectedClothingSize = null;
          selectedShoeSize = null;
          selectedbookGenre = null;
          selectedbookLanguages = null;
          selectedGender = null;
          selectedClothingSize = null;
          selectedShoeSize = null;
          selectedClothingMaterials = null;
          selectedShoeMaterials = null;
          selectedHomeMaterials = null;
          selectedHomeTypes = null;
          selectedElectronisTypes = null;
          selectedAutoTypes = null;
          selectedStationeryTypes = null;
          selectedActivityTypes = null;
          selectedWaterSportsTypes = null;
          selectedCyclingTypes = null;
          selectedChildrenTypes = null;
          selectedGardenTypes = null;
        });

        Navigator.pushReplacementNamed(context, '/main');
      } catch (e) {
        print('Failed to create product: $e');
      }
    }
  }

  List<AdditionalFieldsOptionItem> get currentMaterialOptions {
    switch (selectedCategory) {
      case '14':
        return shoeMaterials;
      case '2':
        return clothingMaterials;
      case '9':
        return homeMaterials;
      default:
        return [];
    }
  }

  String? get selectedMaterial {
    switch (selectedCategory) {
      case '2':
        return selectedClothingMaterials;
      case '14':
        return selectedShoeMaterials;
      case '9':
        return selectedHomeMaterials;
      default:
        return null;
    }
  }

  void setSelectedMaterial(String? value) {
    setState(() {
      switch (selectedCategory) {
        case '2':
          selectedClothingMaterials = value;
          break;
        case '14':
          selectedShoeMaterials = value;
          break;
        case '9':
          selectedHomeMaterials = value;
          break;
      }
    });
  }

  List<AdditionalFieldsOptionItem> get currentTypeOptions {
    switch (selectedCategory) {
      case '9':
        return homeTypes;
      case '1':
        return electronisTypes;
      case '7':
        return autoTypes;
      case '6':
        return stationeryTypes;
      case '4':
        return childrenTypes;
      case '12':
        return gardenTypes;
      default:
        return [];
    }
  }

  String? get selectedType {
    switch (selectedCategory) {
      case '9':
        return selectedHomeTypes;
      case '1':
        return selectedElectronisTypes;
      case '7':
        return selectedAutoTypes;
      case '6':
        return selectedStationeryTypes;
      case '4':
        return selectedChildrenTypes;
      case '12':
        return selectedGardenTypes;
      default:
        return null;
    }
  }

  void setSelectedType(String? value) {
    setState(() {
      switch (selectedCategory) {
        case '9':
          selectedHomeTypes = value;
          break;
        case '1':
          selectedElectronisTypes = value;
          break;
        case '7':
          selectedAutoTypes = value;
          break;
        case '6':
          selectedStationeryTypes = value;
          break;
        case '4':
          selectedChildrenTypes = value;
          break;
        case '12':
          selectedGardenTypes = value;
          break;
      }
    });
  }

  List<AdditionalFieldsOptionItem> get currentActivityTypeOptions {
    switch (selectedActivityValue) {
      case 'water_sports':
        return waterSportsTypes;
      case 'cycling':
        return cyclingTypes;
      default:
        return [];
    }
  }

  String? get selectedActivityTypeValue {
    switch (selectedActivityValue) {
      case 'water_sports':
        return selectedWaterSportsTypes;
      case 'cycling':
        return selectedCyclingTypes;
      default:
        return null;
    }
  }

  void setSelectedActivityTypeValue(String? value) {
    setState(() {
      switch (selectedActivityValue) {
        case 'water_sports':
          selectedWaterSportsTypes = value;
          break;
        case 'cycling':
          selectedCyclingTypes = value;
          break;
      }
    });
  }

  void resetActivityTypeSelection() {
    selectedWaterSportsTypes = null;
    selectedCyclingTypes = null;
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
                    hintText: 'Оберіть тут',
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
                    hintText: 'Оберіть тут',
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
                    hintText: 'Оберіть тут',
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
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //product type
                if (selectedCategory == '1' ||
                    selectedCategory == '7' ||
                    selectedCategory == '9' ||
                    selectedCategory == '6' ||
                    selectedCategory == '4' ||
                    selectedCategory == '12') ...[
                  const Text('Виберіть тип товару *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: currentTypeOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedType,
                    onCategorySelected: (value) {
                      setSelectedType(value);
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //activity type
                if (selectedCategory == '10') ...[
                  const Text('Виберіть тип активності *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: activityTypes
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedActivityTypes,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedActivityValue = value;
                        selectedActivityTypes = null;
                        resetActivityTypeSelection();
                      });
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //activity product type
                if (selectedActivityValue != null &&
                    currentActivityTypeOptions.isNotEmpty) ...[
                  const Text('Виберіть тип товару *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: currentActivityTypeOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedActivityTypeValue,
                    onCategorySelected: (value) {
                      setSelectedActivityTypeValue(value);
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                // materials
                if (selectedCategory == '2' ||
                    selectedCategory == '14' ||
                    selectedCategory == '9') ...[
                  const Text('Оберіть матеріал *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: currentMaterialOptions
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedMaterial,
                    onCategorySelected: (value) {
                      setSelectedMaterial(value);
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //book genres
                if (selectedCategory == '11') ...[
                  const Text('Оберіть жанр книги *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: bookGenre
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedbookGenre,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedbookGenre = value;
                      });
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //book language
                if (selectedCategory == '11') ...[
                  const Text('Оберіть мову книги *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: bookLanguages
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedbookLanguages,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedbookLanguages = value;
                      });
                    },
                    hintText: 'Оберіть тут',
                  ),
                  const SizedBox(height: 16),
                ],

                //book binding
                if (selectedCategory == '11') ...[
                  const Text('Оберіть палітурку книги *'),
                  const SizedBox(height: 8),
                  CategoryDropdown(
                    categories: bookBinding
                        .map((item) =>
                            {'category_id': item.value, 'name': item.name})
                        .toList(),
                    value: selectedbookBinding,
                    onCategorySelected: (value) {
                      setState(() {
                        selectedbookBinding = value;
                      });
                    },
                    hintText: 'Оберіть тут',
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
