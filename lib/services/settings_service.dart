import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, arabic, hebrew }

class SettingsService extends ChangeNotifier {
  static const String _languageKey = 'app_language';
  
  // Singleton pattern
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();
  
  late SharedPreferences _prefs;
  Locale _locale = const Locale('en');
  
  // Current language
  AppLanguage _currentLanguage = AppLanguage.english;
  
  // Initialize the service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load saved language or use system default
    final String? savedLanguage = _prefs.getString(_languageKey);
    if (savedLanguage != null) {
      _locale = _getLocaleFromString(savedLanguage);
    } else {
      // Use system language or default to English if not supported
      final String systemLanguage = PlatformDispatcher.instance.locale.languageCode;
      if (systemLanguage == 'ar' || systemLanguage == 'he') {
        _locale = Locale(systemLanguage);
      }
    }
  }
  
  // Get current locale
  Locale get locale => _locale;
  
  // Get current language
  AppLanguage get currentLanguage => _currentLanguage;
  
  // Get if the current language is RTL
  bool get isRtl => _locale.languageCode == 'ar' || _locale.languageCode == 'he';
  
  // Set language and save preference
  Future<void> setLanguage(AppLanguage language) async {
    _currentLanguage = language;
    Locale oldLocale = _locale;
    
    switch (language) {
      case AppLanguage.english:
        _locale = const Locale('en');
        break;
      case AppLanguage.arabic:
        _locale = const Locale('ar');
        break;
      case AppLanguage.hebrew:
        _locale = const Locale('he');
        break;
    }
    
    // Only notify listeners if the locale actually changed
    if (oldLocale.languageCode != _locale.languageCode) {
      await _prefs.setString(_languageKey, _locale.languageCode);
      notifyListeners();
    }
  }
  
  // Get locale based on current language
  Locale get localeBasedOnCurrentLanguage {
    switch (_currentLanguage) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.arabic:
        return const Locale('ar');
      case AppLanguage.hebrew:
        return const Locale('he');
    }
  }
  
  // Get a localized version of company name based on current language
  String getLocalizedCompanyName(String originalName) {
    final localizedNames = {
      'en': {
        'ABC Construction': 'ABC Construction',
        'City Developers': 'City Developers',
        'FastBuild Inc.': 'FastBuild Inc.',
        'XYZ Builders': 'XYZ Builders',
        'Foundation Experts': 'Foundation Experts',
        'Premium Pumping': 'Premium Pumping'
      },
      'ar': {
        'ABC Construction': 'شركة إيه بي سي للإنشاءات',
        'City Developers': 'مطوري المدينة',
        'FastBuild Inc.': 'شركة فاست بيلد',
        'XYZ Builders': 'شركة إكس واي زد للبناء',
        'Foundation Experts': 'خبراء الأساسات',
        'Premium Pumping': 'بريميوم للضخ'
      },
      'he': {
        'ABC Construction': 'אי בי סי בנייה',
        'City Developers': 'מפתחי העיר',
        'FastBuild Inc.': 'פאסטבילד בע״מ',
        'XYZ Builders': 'בוני אקס וואי זד',
        'Foundation Experts': 'מומחי יסודות',
        'Premium Pumping': 'שאיבה פרימיום'
      }
    };
    
    return localizedNames[_locale.languageCode]?[originalName] ?? originalName;
  }
  
  // Get localized name based on language
  String getLocalizedName(String originalName) {
    final localizedNames = {
      'en': {
        'John Smith': 'John Smith',
        'Sarah Johnson': 'Sarah Johnson',
        'Michael Brown': 'Michael Brown',
        'Emily Davis': 'Emily Davis',
        'Amanda Miller': 'Amanda Miller',
        'Robert Jones': 'Robert Jones',
        'Alex Rodriguez': 'Alex Rodriguez'
      },
      'ar': {
        'John Smith': 'جون سميث',
        'Sarah Johnson': 'سارة جونسون',
        'Michael Brown': 'مايكل براون',
        'Emily Davis': 'إيميلي ديفيس',
        'Amanda Miller': 'أماندا ميلر',
        'Robert Jones': 'روبرت جونز',
        'Alex Rodriguez': 'أليكس رودريغيز'
      },
      'he': {
        'John Smith': 'ג׳ון סמית׳',
        'Sarah Johnson': 'שרה ג׳ונסון',
        'Michael Brown': 'מייקל בראון',
        'Emily Davis': 'אמילי דייוויס',
        'Amanda Miller': 'אמנדה מילר',
        'Robert Jones': 'רוברט ג׳ונס',
        'Alex Rodriguez': 'אלכס רודריגז'
      }
    };
    
    return localizedNames[_locale.languageCode]?[originalName] ?? originalName;
  }
  
  // Get a localized version of notes
  String getLocalizedNotes(String originalNotes) {
    if (_locale.languageCode == 'en') {
      return originalNotes;
    }
    
    final Map<String, Map<String, String>> localizedNotes = {
      'ar': {
        'Service call notes for ABC Construction': 'ملاحظات طلب الخدمة لشركة إيه بي سي للإنشاءات',
        'Service call notes for City Developers': 'ملاحظات طلب الخدمة لمطوري المدينة',
        'Service call notes for FastBuild Inc.': 'ملاحظات طلب الخدمة لشركة فاست بيلد',
        'Service call notes for XYZ Builders': 'ملاحظات طلب الخدمة لشركة إكس واي زد للبناء',
        'Special service call for Foundation Experts on March 27': 'طلب خدمة خاص لخبراء الأساسات في 27 مارس',
        'Special service call for Premium Pumping on March 27': 'طلب خدمة خاص لبريميوم للضخ في 27 مارس'
      },
      'he': {
        'Service call notes for ABC Construction': 'הערות קריאת שירות עבור אי בי סי בנייה',
        'Service call notes for City Developers': 'הערות קריאת שירות עבור מפתחי העיר',
        'Service call notes for FastBuild Inc.': 'הערות קריאת שירות עבור פאסטבילד בע״מ',
        'Service call notes for XYZ Builders': 'הערות קריאת שירות עבור בוני אקס וואי זד',
        'Special service call for Foundation Experts on March 27': 'קריאת שירות מיוחדת עבור מומחי יסודות ב-27 במרץ',
        'Special service call for Premium Pumping on March 27': 'קריאת שירות מיוחדת עבור שאיבה פרימיום ב-27 במרץ'
      }
    };
    
    return localizedNotes[_locale.languageCode]?[originalNotes] ?? originalNotes;
  }
  
  // Get locale from string
  Locale _getLocaleFromString(String localeString) {
    switch (localeString) {
      case 'ar': return const Locale('ar');
      case 'he': return const Locale('he');
      default: return const Locale('en');
    }
  }
} 