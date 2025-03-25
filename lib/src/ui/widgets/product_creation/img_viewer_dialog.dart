import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageViewerDialog extends StatelessWidget {
  final List<Uint8List> images;
  final int initialIndex;

  const ImageViewerDialog({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: initialIndex);
    int currentIndex = initialIndex;

    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.grey,
          insetPadding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 800,
                height: 500,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 5,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 30),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 250,
          top: MediaQuery.of(context).size.height / 2 - 24,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.orange, size: 50),
            onPressed: () {
              int previousIndex =
                  (currentIndex > 0) ? currentIndex - 1 : images.length - 1;
              controller.animateToPage(
                previousIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Positioned(
          right: 250,
          top: MediaQuery.of(context).size.height / 2 - 24,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios,
                color: Colors.orange, size: 50),
            onPressed: () {
              int nextIndex = (currentIndex + 1) % images.length;
              controller.animateToPage(
                nextIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }
}
