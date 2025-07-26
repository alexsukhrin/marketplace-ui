import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../localization/app_localizations.dart';
import '../../../providers/language_provider.dart';

class LocalizationDebug extends ConsumerWidget {
  const LocalizationDebug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLanguage = ref.watch(languageProvider);
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Colors.yellow.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🐛 DEBUG LOCALIZATION',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text('Current Language: ${currentLanguage.displayCode}'),
          Text('Locale: ${currentLanguage.languageCode}'),
          const SizedBox(height: 8),
          Text('Translations Test:'),
          Text('- signUp: "${l10n.signUp}"'),
          Text('- signIn: "${l10n.signIn}"'),
          Text('- home: "${l10n.home}"'),
          Text('- welcomeTitle: "${l10n.welcomeTitle}"'),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => ref.read(languageProvider.notifier).changeLanguage(AppLanguage.ukrainian),
                child: const Text('Force UA'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => ref.read(languageProvider.notifier).changeLanguage(AppLanguage.english),
                child: const Text('Force EN'),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 