import 'package:flutter/material.dart';

class ImageInfoText extends StatelessWidget {
  final int imageCount;

  const ImageInfoText({super.key, required this.imageCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 409,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              imageCount == 0
                  ? "PNG, JPG, HEIC"
                  : "Оберіть фото, яке буде першим у оголошенні, перетягнувши його на перше місце.",
              style: const TextStyle(color: Colors.grey),
              softWrap: true,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$imageCount/3",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
