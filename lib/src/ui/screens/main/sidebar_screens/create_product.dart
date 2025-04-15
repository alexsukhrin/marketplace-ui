import 'package:flutter/material.dart';

import '../../../../services/categories_service.dart';
import '../../../../services/listing_page_service.dart';
import '../../../themes/app_theme.dart';
import '../../../widgets/auth_widgets/auth_field.dart';
import '../../../widgets/product_creation/category_dropdown.dart';
import '../../../widgets/product_creation/character_counter.dart';
import '../../../widgets/product_creation/create_product_validator.dart';
import '../../../widgets/product_creation/description_field.dart';
import '../../../widgets/product_creation/image_up_loader.dart';
import '../../../widgets/product_creation/payment_option.dart';
import '../../../widgets/shared_widgets/custom_button.dart';
import '../../../widgets/shared_widgets/title_text.dart';
import '../../../widgets/welcome_page_widgets/custom_outlined_button.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productBrandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final paymentController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];

  String? selectedCategory;
  String? _selectedCondition;
  String? selectedDelivery;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Fetch product categories
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

  final List<Map<String, dynamic>> deliveryOptions = [
    {'name': 'Нова Пошта', 'category_id': 'nova'},
    {'name': 'Укрпошта', 'category_id': 'ukr'},
    {'name': 'Міст Експрес', 'category_id': 'mist'},
  ];

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Створюємо обʼєкт з даними форми
      Map<String, dynamic> productData = {
        'name': productNameController.text,
        'description': productDescriptionController.text,
        'brand': productBrandController.text,
        'price': priceController.text,
        'phone': phoneController.text,
        'payment_option': paymentController.text,
        'category': selectedCategory,
        'condition': _selectedCondition,
        'delivery': selectedDelivery,
      };

      // Викликаємо метод сервісу для відправки даних
      ProductService.createProduct(productData, context);

      // Очищаємо форму
      productNameController.clear();
      productDescriptionController.clear();
      productBrandController.clear();
      priceController.clear();
      phoneController.clear();
      paymentController.clear();
      setState(() {
        selectedCategory = null;
        _selectedCondition = null;
        selectedDelivery = null;
      });

      // Переходимо на головну сторінку
      Navigator.pushReplacementNamed(context, '/home');
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
                    const ImageUploader(),
                    const SizedBox(height: 20),

                    //product name
                    AuthField(
                      labelText: 'Назва товару *',
                      controller: productNameController,
                      hintText: 'Наприклад, мікрофон професійний',
                      validator: validateProductName,
                      showSuffixIcon: (_) => false,
                      showCounter: false,
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

                    //brand
                    AuthField(
                      labelText: 'Бренд',
                      controller: productBrandController,
                      hintText: 'Наприклад, Nike Air.',
                      showSuffixIcon: (_) => false,
                      showCounter: false,
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
                                    _onConditionSelected('new');
                                    formFieldState.didChange('new');
                                  },
                                  isSelected: _selectedCondition == 'new',
                                ),
                                const SizedBox(width: 20),
                                CustomOutlinedButton(
                                  text: "Вживаний",
                                  onPressed: () {
                                    _onConditionSelected('used');
                                    formFieldState.didChange('used');
                                  },
                                  isSelected: _selectedCondition == 'used',
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
                    const Text('Варіанти доставки *'),
                    const SizedBox(height: 8),
                    CategoryDropdown(
                      categories: deliveryOptions,
                      onCategorySelected: (value) {
                        selectedDelivery = value;
                      },
                      hintText: 'Оберіть тут',
                    ),
                    const SizedBox(height: 20),

                    // //payment
                    PaymentOptionField(
                      labelText: 'Спосіб оплати *',
                      controller: paymentController,
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
                    ),
                    const SizedBox(height: 4),
                    CharacterCounter(
                      controller: productNameController,
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
