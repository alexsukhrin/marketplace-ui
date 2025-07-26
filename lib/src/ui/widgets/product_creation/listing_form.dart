import 'package:flutter/material.dart';

class ListingForm extends StatefulWidget {
  const ListingForm({super.key});

  @override
  State<ListingForm> createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            Text(
              'Форма створення товару',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'В процесі розробки...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
} 