import 'package:flutter/material.dart';

class PaymentAndDeliveryTab extends StatelessWidget {
  const PaymentAndDeliveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Оплата',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey[300],
              width: 326,
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: Colors.black),
                SizedBox(width: 8),
                Text('Безпечна оплата картою:', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  'assets/images/bank_img/banking_img.png',
                  width: 98,
                  height: 34,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: Colors.black),
                SizedBox(width: 8),
                Text('Післяплата (Пошта)', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Доставка',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey[300],
              width: 326,
            ),
            const SizedBox(height: 16),
            const Text(
              'Продавець обрав наступні способи доставки:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildDeliveryOption('Нова пошта (адресна доставка)'),
            _buildDeliveryOption('Нова пошта (відділення)'),
            _buildDeliveryOption('Нова пошта (поштомат)'),
            _buildDeliveryOption('Самовивіз (м. Київ)'),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const CircleAvatar(radius: 3, backgroundColor: Colors.black),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
