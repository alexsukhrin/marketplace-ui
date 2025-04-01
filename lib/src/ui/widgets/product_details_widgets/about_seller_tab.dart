import 'package:flutter/material.dart';

class AboutSellerTab extends StatelessWidget {
  const AboutSellerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_circle, size: 52),
              SizedBox(width: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Іванна Жук',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Верифікований продавець',
                          style: TextStyle(fontSize: 16, color: Colors.orange)),
                    ],
                  ),
                  SizedBox(width: 112),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Середній час відповіді:',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('1 година',
                          style: TextStyle(fontSize: 16, color: Colors.orange)),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          const Text('Рейтинг продавця',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          const Row(
            children: [
              Icon(Icons.star, size: 20, color: Colors.yellow),
              SizedBox(width: 4),
              Text('4.5', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 170,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text('У додатку з 03.10.2024',
                      style: TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 170,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text('9 успішних продажів',
                      style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
