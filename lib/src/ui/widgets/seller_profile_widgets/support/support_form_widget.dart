import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/support/support_description_field.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/support/support_field.dart';

class SupportFormWidget extends StatefulWidget {
  const SupportFormWidget({super.key});

  @override
  State<SupportFormWidget> createState() => _SupportFormWidgetState();
}

class _SupportFormWidgetState extends State<SupportFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _enteredName = TextEditingController();
  final _enteredContact = TextEditingController();
  final _enteredText = TextEditingController();

  @override
  void dispose() {
    _enteredName.dispose();
    _enteredContact.dispose();
    _enteredText.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _enteredName.text.trim();
      final contact = _enteredContact.text.trim();
      final message = _enteredText.text.trim();

      print('🔸 Name: $name');
      print('🔸 Contact: $contact');
      print('🔸 Message: $message');

      _enteredName.clear();
      _enteredContact.clear();
      _enteredText.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Повідомлення надіслано')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Підтримка',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text('Заповніть форму та ми з вами сконтактуємось'),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SupportField(
                      labelText: 'Ваше ім\'я',
                      enteredText: _enteredName,
                    )),
                    const SizedBox(width: 21),
                    Expanded(
                        child: SupportField(
                      labelText: 'Контактні дані',
                      enteredText: _enteredContact,
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                SupportDescriptionField(
                  labelText: 'Повідомлення',
                  enteredText: _enteredText,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(213, 40),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Надіслати'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
