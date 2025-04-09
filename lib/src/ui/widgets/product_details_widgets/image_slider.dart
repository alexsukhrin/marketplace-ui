import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/show_full_screen_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/product_details_moc_img/img_vans.png',
    'assets/images/product_details_moc_img/img_vans.png',
    'assets/images/product_details_moc_img/img_vans.png',
  ];

  PageController pageController = PageController();

  void _openFullScreenSlider() {
    showDialog(
      context: context,
      builder: (_) => FullScreenImageSlider(
        images: _images,
        initialIndex: _currentIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 509,
              child: PageView.builder(
                controller: pageController,
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _openFullScreenSlider,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _images[index],
                          width: double.infinity,
                          height: 509,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: 21,
              top: 21,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _openFullScreenSlider,
                  child: const SizedBox(
                    width: 14,
                    height: 14,
                    child: Icon(
                      Icons.open_in_full,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: MediaQuery.of(context).size.height * 0.3,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _currentIndex > 0
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _currentIndex > 0 ? Colors.white : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.navigate_before,
                      color: _currentIndex > 0 ? Colors.white : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height * 0.3,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _currentIndex < _images.length - 1
                      ? () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _currentIndex < _images.length - 1
                            ? Colors.white
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.navigate_next,
                      color: _currentIndex < _images.length - 1
                          ? Colors.white
                          : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _images.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: _currentIndex == index ? 20 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 68,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _currentIndex == index
                          ? Colors.orange
                          : Colors.transparent,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
