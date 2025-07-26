import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../themes/app_theme.dart';
import '../../../providers/language_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _LanguageButton(
          language: AppLanguage.ukrainian,
          isSelected: currentLanguage == AppLanguage.ukrainian,
          onPressed: () => ref
              .read(languageProvider.notifier)
              .changeLanguage(AppLanguage.ukrainian),
        ),
        const SizedBox(width: 4),
        const Text(
          '|',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        _LanguageButton(
          language: AppLanguage.english,
          isSelected: currentLanguage == AppLanguage.english,
          onPressed: () => ref
              .read(languageProvider.notifier)
              .changeLanguage(AppLanguage.english),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onPressed;

  const _LanguageButton({
    required this.language,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        language.displayCode,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isSelected
              ? Colors.black // Активна мова
              : AppTheme.activeButtonColor, // Неактивна мова
        ),
      ),
    );
  }
}
