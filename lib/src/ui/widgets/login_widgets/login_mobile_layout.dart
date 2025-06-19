import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/src/ui/screens/registration/registration_page.dart';
import 'package:flutter_application_1/src/ui/widgets/login_widgets/forgot_password_button.dart';
import 'package:flutter_application_1/src/ui/widgets/login_widgets/login_header.dart';
import 'package:flutter_application_1/src/ui/widgets/auth_widgets/auth_field.dart';
import 'package:flutter_application_1/src/ui/widgets/auth_widgets/auth_button.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/language_selector.dart';
import 'package:flutter_application_1/src/ui/widgets/social_media/social_media.dart';
import 'package:flutter_application_1/src/utils/validators.dart';

class LoginMobileLayout extends StatelessWidget {
  final TextTheme textTheme;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isButtonDisabled;
  final Future<void> Function() onLogin;

  const LoginMobileLayout({
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          LanguageSelector(),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const LoginHeader(),
                      const SizedBox(height: 40),
                      AuthField(
                        labelText: 'Ваша пошта',
                        hintText: "Введіть пошту",
                        controller: emailController,
                        validator: validateEmail,
                        showSuffixIcon: (text) {
                          return validateEmail(text) == null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AuthField(
                        labelText: 'Пароль',
                        hintText: "Введіть пароль",
                        controller: passwordController,
                        validator: validatePassword,
                        isObscureText: true,
                      ),
                      ForgotPasswordButton(
                          email: emailController.text.isNotEmpty
                              ? emailController.text
                              : null),
                      const SizedBox(height: 40),
                      AuthButton(
                        text: 'Увійти в акаунт',
                        onPressed: onLogin,
                        isButtonDisabled: isButtonDisabled,
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: const [
                              TextSpan(text: 'Ще не маєте акаунт? '),
                              TextSpan(
                                text: ' Зареєструватись',
                                style: TextStyle(
                                  color: TColors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 155,
                              child: Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'Або',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: TColors.greyDarker,
                                      fontSize: 17,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 155,
                              child: Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(
                              icon:
                                  'assets/images/social_media/icon_google.png',
                              onTap: () {}),
                          const SizedBox(width: 16),
                          SocialButton(
                              icon:
                                  'assets/images/social_media/icon_facebook.png',
                              onTap: () {}),
                          const SizedBox(width: 16),
                          SocialButton(
                              icon: 'assets/images/social_media/icon_x.png',
                              onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
