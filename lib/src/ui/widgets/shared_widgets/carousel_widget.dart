import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class CustomCarousel extends StatelessWidget {
  final List<Map<String, String>> slides;

  const CustomCarousel({super.key, required this.slides});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: slides.length,
        itemBuilder: (context, index) {
          final slide = slides[index];
          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slide['title']!,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(slide['subtitle']!),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Add action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme
                                  .activeButtonColor, // Set active button color here
                            ),
                            child: Text(
                              'Детальніше',
                              style: TextStyle(
                                  color: Colors
                                      .white), // Adjust text color if needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      slide['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    // Implement next slide navigation
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
