import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to provide access to the delegate
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Hardcoded translations for now - normally these would be loaded from the ARB files
  // but since we're creating a temporary fix, we'll hardcode the most essential strings
  String get language => 'Language';
  String get english => 'English';
  String get arabic => 'Arabic';
  String get hebrew => 'Hebrew';
  String get settings => 'Settings';
  String get customers => 'Customers';
  String get scheduled => 'Scheduled';
  String get inProgress => 'In Progress';
  String get incomplete => 'Incomplete';
  String get awaitingSignature => 'Awaiting Signature';
  String get completed => 'Completed';
  String get pending => 'Pending';
  String get details => 'Details';
  String get contacts => 'Contacts';
  String get chat => 'Chat';
  String get documents => 'Documents';
  String get history => 'History';
}

// LocalizationsDelegate is a factory for a set of localized resources
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'he'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 