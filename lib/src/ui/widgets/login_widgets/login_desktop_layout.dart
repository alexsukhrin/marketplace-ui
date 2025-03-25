import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/login_widgets/login_mobile_layout.dart';

class LoginDesktopLayout extends StatelessWidget {
  final TextTheme textTheme;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isButtonDisabled;
  final Future<void> Function() onLogin;

  const LoginDesktopLayout({
    super.key,
    required this.textTheme,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isButtonDisabled,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 33.0, horizontal: 0),
            child: Center(
              child: Container(
                width: 651,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color(0xFFF7F5F2),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Image.asset(
                        'assets/images/logo_desktop.png',
                        width: 48,
                        height: 69,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/logIn_icons/Log_in_img.png',
                        width: 651,
                        height: 630,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 50.0, top: 33.0, bottom: 33.0),
            child: LoginMobileLayout(
              textTheme: textTheme,
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              isButtonDisabled: isButtonDisabled,
              onLogin: onLogin,
            ),
          ),
        ),
      ],
    );
  }
}
