import 'package:flutter/material.dart';
import 'package:unidoc/l10n/app_localizations.dart';
import 'package:unidoc/services/settings_service.dart';

class LanguageSelector extends StatelessWidget {
  final Function onLanguageChanged;
  
  const LanguageSelector({
    super.key,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsService = SettingsService();
    final currentLanguage = settingsService.currentLanguage;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Text(
                  l10n!.language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildLanguageOption(
                  context: context,
                  language: AppLanguage.english,
                  label: l10n.english,
                  isSelected: currentLanguage == AppLanguage.english,
                  icon: const Icon(Icons.language, color: Colors.blue, size: 24),
                ),
                _buildLanguageOption(
                  context: context,
                  language: AppLanguage.arabic,
                  label: l10n.arabic,
                  isSelected: currentLanguage == AppLanguage.arabic,
                  icon: const Icon(Icons.language, color: Colors.green, size: 24),
                ),
                _buildLanguageOption(
                  context: context,
                  language: AppLanguage.hebrew,
                  label: l10n.hebrew,
                  isSelected: currentLanguage == AppLanguage.hebrew,
                  icon: const Icon(Icons.language, color: Colors.orange, size: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLanguageOption({
    required BuildContext context,
    required AppLanguage language,
    required String label,
    required bool isSelected,
    required Widget icon,
  }) {
    return InkWell(
      onTap: () async {
        final settingsService = SettingsService();
        if (settingsService.currentLanguage != language) {
          await settingsService.setLanguage(language);
          onLanguageChanged();
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
} 