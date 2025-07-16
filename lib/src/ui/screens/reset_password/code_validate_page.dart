import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../exceptions/invalid_opt_exception.dart';
import '../../../services/password_reset_service.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import 'reset_password_page.dart';

import '../../themes/app_theme.dart';

class CodeValidatePage extends StatefulWidget {
  final String email;

  const CodeValidatePage({super.key, required this.email});

  @override
  CodeValidatePageState createState() => CodeValidatePageState();
}

class CodeValidatePageState extends State<CodeValidatePage> {
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _field4Controller = TextEditingController();
  final TextEditingController _field5Controller = TextEditingController();
  final TextEditingController _field6Controller = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  String _errorMessage = '';
  String _timerText = 'Надіслати код знову';
  bool _isResendDisabled = false;
  Timer? _timer;

  bool get _isButtonEnabled {
    return _field1Controller.text.isNotEmpty &&
        _field2Controller.text.isNotEmpty &&
        _field3Controller.text.isNotEmpty &&
        _field4Controller.text.isNotEmpty &&
        _field5Controller.text.isNotEmpty &&
        _field6Controller.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendCodeToServer(String code) async {
    try {
      await PasswordResetService.validateRecoveryCode(widget.email, code);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPasswordPage(),
        ),
      );
    } catch (e) {
      setState(() {
        if (e is InvalidOtpException) {
          _errorMessage = e.message;
        } else {
          _errorMessage = 'Помилка при відправці коду: $e';
        }
      });
    }
  }

  Future<void> _resendCode() async {
    if (_isResendDisabled) return;

    setState(() {
      _isResendDisabled = true;
      _timerText = 'Надіслати код знову';
    });

    try {
      await PasswordResetService.sendRecoveryEmail(widget.email);
    } catch (e) {
      setState(() {
        _errorMessage = 'Помилка при відправці коду: $e';
      });
    }

    int counter = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
        _timerText = 'Надіслати код знову через ($counter сек)';
      });

      if (counter == 0) {
        setState(() {
          _isResendDisabled = false;
          _timerText = 'Надіслати код знову';
        });
        _timer?.cancel();
      }
    });
  }

  void _handlePaste(String value) {
    if (value.length == 6) {
      _field1Controller.text = value[0];
      _field2Controller.text = value[1];
      _field3Controller.text = value[2];
      _field4Controller.text = value[3];
      _field5Controller.text = value[4];
      _field6Controller.text = value[5];

      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: isDesktop ? 624 : double.infinity,
                height: isDesktop ? 460 : double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: isDesktop
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 200,
                            spreadRadius: 20,
                            offset: const Offset(0, -10),
                          ),
                        ],
                      )
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: isDesktop ? 0 : 100),
                    Image.asset(
                      'assets/images/logIn_icons/mail_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Код надіслано',
                      style: textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Перевірте лист за вказаною поштою",
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: widget.email.isNotEmpty
                            ? widget.email.replaceRange(
                                3, widget.email.indexOf('@'), '***')
                            : 'Невідомо',
                        style: textTheme.bodyLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isDesktop ? 44 : 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOtpField(
                            _field1Controller, _focusNode1, _focusNode2),
                        const SizedBox(width: 10),
                        _buildOtpField(
                            _field2Controller, _focusNode2, _focusNode3),
                        const SizedBox(width: 10),
                        _buildOtpField(
                            _field3Controller, _focusNode3, _focusNode4),
                        const SizedBox(width: 10),
                        _buildOtpField(
                            _field4Controller, _focusNode4, _focusNode5),
                        const SizedBox(width: 10),
                        _buildOtpField(
                            _field5Controller, _focusNode5, _focusNode6),
                        const SizedBox(width: 10),
                        _buildOtpField(
                            _field6Controller, _focusNode6, _focusNode6),
                      ],
                    ),
                    SizedBox(height: isDesktop ? 44 : 20),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        children: [
                          AuthButton(
                            text: 'Підтвердити',
                            onPressed: _isButtonEnabled
                                ? () {
                                    String code = _field1Controller.text +
                                        _field2Controller.text +
                                        _field3Controller.text +
                                        _field4Controller.text +
                                        _field5Controller.text +
                                        _field6Controller.text;

                                    _sendCodeToServer(code);
                                  }
                                : null,
                            isButtonDisabled: !_isButtonEnabled,
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: _resendCode,
                            child: Text(
                              _timerText,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppTheme.linkTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtpField(TextEditingController controller,
      FocusNode currentFocusNode, FocusNode nextFocusNode) {
    currentFocusNode.addListener(() {
      setState(() {});
    });

    return SizedBox(
      width: 52,
      height: 52,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          filled: true,
          fillColor: currentFocusNode.hasFocus
              ? AppTheme.activeFieldBackgroundColor
              : AppTheme.codeFieldBackgroundColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFF6EADA), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 24.0),
        ),
        style: const TextStyle(fontSize: 24),
        onChanged: (value) {
          if (value.length > 1) {
            _handlePaste(value);
          } else if (value.isNotEmpty) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}
