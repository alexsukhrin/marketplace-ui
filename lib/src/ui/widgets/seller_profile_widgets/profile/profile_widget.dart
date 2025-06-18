import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/profile/profile_field_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Базова інформація',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.orange,
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(
                          Icons.person,
                          size: 86,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(
                            alpha: 102,
                            red: 0,
                            green: 0,
                            blue: 0,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(side: BorderSide.none),
              child: const Text('Змінити фото'),
            ),
          ],
        ),
        const SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                ProfileField(
                  labelText: 'Ваше ім\'я',
                ),
                SizedBox(
                  width: 24,
                ),
                ProfileField(
                  labelText: 'Ваше прізвище',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const ProfileField(
              labelText: 'Ваша пошта',
            ),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(213, 40),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Зберегти зміни'),
              ),
            )
          ],
        ),
        const SizedBox(height: 36),
        const ProfileField(
          labelText: 'Пароль',
        ),
        const SizedBox(height: 28),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(213, 40),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Зберегти зміни'),
          ),
        )
      ],
    );
  }
}
