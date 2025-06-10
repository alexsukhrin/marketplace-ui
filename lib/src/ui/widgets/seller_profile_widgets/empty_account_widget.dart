import 'package:flutter/material.dart';

class EmptyAccountWidget extends StatelessWidget {
  const EmptyAccountWidget({super.key, this.text, this.subtext});
  final String? text;
  final String? subtext;

  @override
  Widget build(context) {
    return SizedBox(
      width: 348,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty_screen_img/page_not_found.png",
            width: 329,
            height: 314,
          ),
          if (text != null)
            Text(
              text!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (text != null && subtext != null) const SizedBox(height: 8),
          if (subtext != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                subtext!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
