import 'package:flutter/material.dart';
import 'package:unidoc/l10n/app_localizations.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/widgets/language_selector.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.settings ?? 'Settings'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  l10n?.language ?? 'Language',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              LanguageSelector(
                onLanguageChanged: () {
                  // Instead of popping back, we'll rebuild the app in place
                  // The state change will be handled by the SettingsService
                  setState(() {
                    // Just trigger a rebuild
                  });
                },
              ),
              const SizedBox(height: 24),
              
              // Add more settings sections here as needed
            ],
          ),
        ),
      ),
    );
  }
} 