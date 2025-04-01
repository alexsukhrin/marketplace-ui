import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/about_seller_tab.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/payment_and_delivery_tab.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/review_widget.dart';

class AboutSeller extends StatefulWidget {
  const AboutSeller({super.key});

  @override
  AboutSellerState createState() => AboutSellerState();
}

class AboutSellerState extends State<AboutSeller>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _sliderPosition = 0;
  late List<GlobalKey> _tabKeys;
  double _currentHeight = 220;
  final GlobalKey _tabRowKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabKeys = List.generate(3, (_) => GlobalKey());

    _tabController.addListener(() {
      setState(() {
        _updateSliderPosition();
        switch (_tabController.index) {
          case 0:
            _currentHeight = 200;
            break;
          case 1:
            _currentHeight = 140;
            break;
          case 2:
            _currentHeight = 400;
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateSliderPosition() {
    final rowRenderBox =
        _tabRowKey.currentContext?.findRenderObject() as RenderBox?;
    final tabRenderBox = _tabKeys[_tabController.index]
        .currentContext
        ?.findRenderObject() as RenderBox?;

    if (rowRenderBox != null && tabRenderBox != null) {
      final rowOffset = rowRenderBox.localToGlobal(Offset.zero).dx;
      final tabOffset = tabRenderBox.localToGlobal(Offset.zero).dx;

      setState(() {
        _sliderPosition = tabOffset - rowOffset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: _tabRowKey,
          children: [
            const SizedBox(width: 10),
            TextButton(
              key: _tabKeys[0],
              onPressed: () {
                _tabController.animateTo(0);
              },
              child: const Text('Про продавця',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            const SizedBox(width: 12),
            TextButton(
              key: _tabKeys[1],
              onPressed: () {
                _tabController.animateTo(1);
              },
              child: const Text('Відгуки продавця',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            const SizedBox(width: 12),
            TextButton(
              key: _tabKeys[2],
              onPressed: () {
                _tabController.animateTo(2);
              },
              child: const Text('Оплата та доставка',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 2,
              color: Colors.grey[300],
            ),
            AnimatedPositioned(
              left: _sliderPosition,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                width: 100,
                height: 2,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _currentHeight,
          child: TabBarView(
            controller: _tabController,
            children: const [
              AboutSellerTab(),
              ReviewWidget(
                reviews: [
                  {
                    'name': 'Олександр',
                    'rating': 5,
                    'text':
                        'Чудовий продавець! Все прийшло швидко.іоталопвіаропдоадпловідлптвідлтпдт',
                  },
                  {
                    'name': 'Марія',
                    'rating': 4,
                    'text': 'Товар відповідає опису, рекомендую.',
                  },
                  {
                    'name': 'Іван',
                    'rating': 3,
                    'text': 'Є деякі недоліки, але загалом нормально.',
                  },
                  {
                    'name': 'Анна',
                    'rating': 5,
                    'text': 'Дуже задоволена покупкою! Дякую!',
                  },
                ],
              ),
              PaymentAndDeliveryTab()
            ],
          ),
        ),
      ],
    );
  }
}
