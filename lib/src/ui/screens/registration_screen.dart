import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  // Email validation
  String? _validateEmail(String? value) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть електронну пошту';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Невірний формат електронної пошти';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*])[A-Za-z0-9!@#\$%^&*]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть пароль';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Пароль повинен містити щонайменше 8 символів, одну велику літеру, одну цифру і один спеціальний символ';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Ім\'я',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть ім\'я';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Прізвище',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть прізвище';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Електронна пошта',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 32),

              // Use custom button here
              CustomButton(
                text: 'Зареєструватися',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Реєстрація успішна!')),
                    );
                    // Do something (e.g., register user)
                  }
                },
              ),
              const SizedBox(height: 16),

              // Login Button (redirect to login screen)
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login screen
                },
                child: const Text('Вже маєте акаунт? Увійти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
