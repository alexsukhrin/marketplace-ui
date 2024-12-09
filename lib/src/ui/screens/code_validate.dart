import 'package:flutter/material.dart';

import 'password_recovery.dart';

import '../themes/app_theme.dart';

class CodeValidate extends StatefulWidget {
  const CodeValidate({super.key});

  @override
  CodeValidateState createState() => CodeValidateState();
}

class CodeValidateState extends State<CodeValidate> {
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _field4Controller = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  String _errorMessage = '';

  bool get _isButtonEnabled {
    return _field1Controller.text.isNotEmpty &&
        _field2Controller.text.isNotEmpty &&
        _field3Controller.text.isNotEmpty &&
        _field4Controller.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
  }

  void _onFieldChanged(String value, FocusNode nextFocusNode) {
    if (value.length == 1) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/images/logIn_icons/mail_icon.png',
                width: 50, height: 50),
            Text(
              'Код надіслано',
              style: textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Перевірте смс за вказаним номером",
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOtpField(_field1Controller, _focusNode1, _focusNode2),
                const SizedBox(width: 10),
                _buildOtpField(_field2Controller, _focusNode2, _focusNode3),
                const SizedBox(width: 10),
                _buildOtpField(_field3Controller, _focusNode3, _focusNode4),
                const SizedBox(width: 10),
                _buildOtpField(_field4Controller, _focusNode4, _focusNode4),
              ],
            ),
            const SizedBox(height: 20),
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
                  SizedBox(
                    width: 352,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                              String code = _field1Controller.text +
                                  _field2Controller.text +
                                  _field3Controller.text +
                                  _field4Controller.text;

                              if (code == '3333') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordRecovery(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _errorMessage = 'Неправильний код';
                                });
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.buttonColor,
                        foregroundColor: AppTheme.witeText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Підтвердити'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    child: Text(
                      'Надіслати код знову',
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
    );
  }

  Widget _buildOtpField(TextEditingController controller,
      FocusNode currentFocusNode, FocusNode nextFocusNode) {
    return SizedBox(
      width: 79,
      height: 79,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
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
          if (value.length == 1) {
            _onFieldChanged(value, nextFocusNode);
            setState(() {});
          }
        },
      ),
    );
  }
}
