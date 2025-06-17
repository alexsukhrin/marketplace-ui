import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/faqs_data.dart';

class FaqsWidget extends StatefulWidget {
  const FaqsWidget({super.key});

  @override
  State<FaqsWidget> createState() => _FaqsWidgetState();
}

class _FaqsWidgetState extends State<FaqsWidget> with TickerProviderStateMixin {
  final Set<int> expandedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Часті питання',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Отримай відповідь на своє запитання'),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(faqsData.length, (index) {
            final faq = faqsData[index];
            final isExpanded = expandedIndices.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    expandedIndices.remove(index);
                  } else {
                    expandedIndices.add(index);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 320,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(faq.id),
                        AnimatedRotation(
                          turns: isExpanded ? 0.50 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            Icons.arrow_outward,
                            size: 20,
                            color: isExpanded
                                ? const Color(0xFFFFD78D)
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(faq.title, style: const TextStyle(fontSize: 16)),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.antiAlias,
                      child: isExpanded
                          ? Column(
                              children: [
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  faq.text,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
