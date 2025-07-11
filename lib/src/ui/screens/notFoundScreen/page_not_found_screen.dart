import 'dart:async';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatefulWidget {
  const PageNotFoundScreen({super.key});

  @override
  _PageNotFoundScreenState createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        scale = (scale == 1.0) ? 1.05 : 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: MediaQuery.of(context).size.width / 2 - 10,
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(seconds: 2),
              child: Text(
                "0",
                style: TextStyle(
                  fontSize: 600,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: -100,
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(seconds: 2),
              child: Text(
                "4",
                style: TextStyle(
                  fontSize: 600,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -250,
            right: 50,
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(seconds: 2),
              child: Text(
                "4",
                style: TextStyle(
                  fontSize: 600,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Уппсс!",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Схоже, що сторінку не знайдено.\nМи активно працюємо, щоб усе налагодити.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    fixedSize: const Size(339, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: const Text("На головну сторінку",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
