import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unidoc/generated/app_localizations.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/router/app_router.dart';
import 'package:unidoc/services/settings_service.dart';
// import 'screens/splash_screen.dart';
// import 'screens/dashboard_page.dart';
// import 'screens/customers_page.dart';

void main() async {
  // It's good practice to ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize settings service to load saved language preferences
  final settingsService = SettingsService();
  await settingsService.init();
  
  runApp(const UniDocApp());
}

class UniDocApp extends StatefulWidget {
  const UniDocApp({super.key});

  @override
  State<UniDocApp> createState() => _UniDocAppState();
}

class _UniDocAppState extends State<UniDocApp> {
  final SettingsService _settingsService = SettingsService();
  
  // Used to trigger a rebuild when language changes
  int _localeRebuildCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unidoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      
      // Localization support
      locale: _settingsService.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
        Locale('he'), // Hebrew
      ],
      
      // Configure text direction based on current locale
      builder: (context, child) {
        // We listen to the rebuild count variable to force rebuild when language changes
        // but it doesn't affect anything else
        _localeRebuildCount;
        
        // Add a listener to the settings service to rebuild when language changes
        _settingsService.addListener(() {
          setState(() {
            _localeRebuildCount++;
          });
        });
        
        return Directionality(
          textDirection: _settingsService.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
} 