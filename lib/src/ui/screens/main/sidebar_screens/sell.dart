import 'package:flutter/material.dart';

import '../../../widgets/product_creation/image_up_loader.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Sell Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const ImageUploader(),
        ],
      ),
    );
  }
}
