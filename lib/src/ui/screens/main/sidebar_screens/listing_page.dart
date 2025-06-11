import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/listing_form.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/recommendation_window.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/title_text.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 1150;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableTextWidget(
              mainText: "Нове оголошення",
              secondaryText: "Обов’язкові поля позначені *",
            ),
            const SizedBox(height: 20),
            isNarrow
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecommendationWindow(),
                      SizedBox(height: 24),
                      ListingForm(),
                    ],
                  )
                : const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListingForm(),
                      SizedBox(width: 24),
                      Expanded(child: RecommendationWindow()),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
