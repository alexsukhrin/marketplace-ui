import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/login_widgets/login_desktop_layout.dart';

import 'package:flutter_application_1/src/ui/widgets/login_widgets/login_mobile_layout.dart';

import '../../../services/auth_service.dart';
import '../../../services/auth_storage.dart';

import '../../widgets/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_checkFormFilled);
    _passwordController.addListener(_checkFormFilled);
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkFormFilled);
    _passwordController.removeListener(_checkFormFilled);
    super.dispose();
  }

  void _checkFormFilled() {
    final isFormFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    setState(() {
      _isButtonDisabled = !isFormFilled;
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;
    LoadingDialog.show(context);

    try {
      final response = await AuthService.loginUser(email, password);
      LoadingDialog.hide(context);

      if (response.containsKey('access-token')) {
        final accessToken = response['access-token'];
        final refreshToken = response['refresh-token'];

        print('TOKEN!! $accessToken');
        await AuthStorage.saveAccessToken(accessToken);
        await AuthStorage.saveRefreshToken(refreshToken);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      } else {
        final errorMessage =
            response['message'] ?? 'Невірна електронна пошта або пароль';
        if (mounted) {
          _showErrorDialog(context, errorMessage);
        }
      }
    } catch (e) {
      LoadingDialog.hide(context);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/notFoundScreen');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Помилка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1440,
            maxHeight: 1024,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return LoginMobileLayout(
                    textTheme: textTheme,
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isButtonDisabled: _isButtonDisabled,
                    onLogin: _handleLogin);
              } else {
                return _buildDesktopLayout(textTheme);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(TextTheme textTheme) {
    return LoginDesktopLayout(
      textTheme: textTheme,
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      isButtonDisabled: _isButtonDisabled,
      onLogin: _handleLogin,
    );
  }
}
