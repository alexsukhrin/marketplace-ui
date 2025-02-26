import 'package:flutter/material.dart';
import '../../../themes/app_theme.dart';

class FAQSection extends StatefulWidget {
  FAQSection({super.key});

  @override
  _FAQSectionState createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  final List<String> questions = [
    "Як обрати продавця?",
    "Як перевірити чи товар відповідає опису?",
    "Я не отримав/ла відповідь на питання, яке цікавило. Що робити?",
    "Що робити, якщо я не отримав товар?",
    "Хто оплачує доставку?",
    "Як верифікувати свій акаунт?"
  ];

  // To track which question is hovered
  Map<int, bool> hoverStates = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Часті питання",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Отримай відповідь на своє запитання",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 15,
                runSpacing: 15,
                children: questions
                    .asMap()
                    .map((index, question) {
                      return MapEntry(
                        index,
                        SizedBox(
                          width: (constraints.maxWidth - 15) / 2,
                          child: MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                hoverStates[index] = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                hoverStates[index] = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: hoverStates[index] == true
                                    ? const Color.fromARGB(255, 235, 233, 233)
                                    : AppTheme.greyBoxColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                  expansionTileTheme: ExpansionTileThemeData(
                                    collapsedIconColor: AppTheme.linkTextColor,
                                    iconColor: AppTheme.linkTextColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                child: ExpansionTile(
                                  title: Text(question),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Тут буде відповідь на запитання."),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
