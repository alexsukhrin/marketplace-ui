import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/support/faqs_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/support/support_form_widget.dart';

class SupportWidget extends StatelessWidget {
  const SupportWidget({super.key});

  @override
  Widget build(context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaqsWidget(),
          SizedBox(height: 34),
          SupportFormWidget(),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
