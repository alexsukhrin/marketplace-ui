import 'package:flutter/material.dart';

class ImageInfoText extends StatelessWidget {
  final int imageCount;
  final String? errorText;
  const ImageInfoText({
    super.key,
    required this.imageCount,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              errorText != null
                  ? errorText!
                  : imageCount == 0
                      ? ""
                      : "Оберіть фото, яке буде першим у оголошенні, перетягнувши його на перше місце.",
              style: TextStyle(
                color: errorText != null ? Colors.red : Colors.grey,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$imageCount/5",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
