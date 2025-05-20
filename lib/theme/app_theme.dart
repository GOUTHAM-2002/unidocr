import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Helper function to convert HSL to Color
// Formula from https://www.w3.org/TR/css-color-3/#hsl-color
// For simplicity, this helper might not handle all edge cases perfectly (e.g. full saturation/lightness extremes)
// but should be good for typical HSL values found in CSS.
Color hslToColor(double h, double s, double l, [double opacity = 1.0]) {
  s /= 100;
  l /= 100;

  if (s == 0) {
    final int gray = (l * 255).round();
    return Color.fromRGBO(gray, gray, gray, opacity);
  }

  double hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  final double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
  final double p = 2 * l - q;
  final double r = hueToRgb(p, q, h / 360 + 1 / 3);
  final double g = hueToRgb(p, q, h / 360);
  final double b = hueToRgb(p, q, h / 360 - 1 / 3);

  return Color.fromRGBO(
    (r * 255).round(),
    (g * 255).round(),
    (b * 255).round(),
    opacity,
  );
}

class AppColors {
  AppColors._(); // This class is not meant to be instantiated.

  // Unidoc custom colors from tailwind.config.ts
  static const Color unidocPrimaryBlue = Color(0xFF0EA5E9); // #0EA5E9
  static const Color unidocDeepBlue = Color(0xFF0C4A6E);    // #0C4A6E
  static const Color unidocLightBlue = Color(0xFF7DD3FC);   // #7DD3FC
  static const Color unidocCyanBlue = Color(0xFF22D3EE);    // #22D3EE
  static const Color unidocTealBlue = Color(0xFF0891B2);    // #0891B2
  static const Color unidocSecondaryOrange = Color(0xFFFB923C); // #FB923C
  static const Color unidocBlue = Color(0xFF3B82F6); // Added for splash screen logo, common blue
  
  static const Color unidocDark = Color(0xFF1A1F36);       // #1A1F36
  static const Color unidocMedium = Color(0xFF6E7891);     // #6E7891
  static const Color unidocLightGray = Color(0xFFE9ECF2);   // #E9ECF2
  static const Color unidocExtraLight = Color(0xFFF7F9FC); // #F7F9FC

  static const Color unidocSuccess = Color(0xFF10B981);     // #10B981
  static const Color unidocWarning = Color(0xFFFBBF24);     // #FBBF24
  static const Color unidocError = Color(0xFFF43F5E);       // #F43F5E
  static const Color unidocInfo = Color(0xFF0EA5E9);        // #0EA5E9 (matches primary-blue)

  // Semantic colors from :root in index.css (converted from HSL)
  // --background: 210 33% 98%;
  static final Color background = hslToColor(210, 33, 98);
  // --foreground: 226 39% 16%;
  static final Color foreground = hslToColor(226, 39, 16);

  // --card: 0 0% 100%;
  static final Color card = hslToColor(0, 0, 100); // White
  // --card-foreground: 226 39% 16%;
  static final Color cardForeground = hslToColor(226, 39, 16);

  // --popover: 0 0% 100%;
  static final Color popover = hslToColor(0, 0, 100); // White
  // --popover-foreground: 226 39% 16%;
  static final Color popoverForeground = hslToColor(226, 39, 16);
  
  // --primary: 198 90% 48%;
  static final Color primary = hslToColor(198, 90, 48);
  // --primary-foreground: 210 40% 98%;
  static final Color primaryForeground = hslToColor(210, 40, 98);

  // --secondary: 32 95% 62%;
  static final Color secondary = hslToColor(32, 95, 62);
  // --secondary-foreground: 226 39% 16%;
  static final Color secondaryForeground = hslToColor(226, 39, 16);

  // --muted: 210 40% 96.1%;
  static final Color muted = hslToColor(210, 40, 96.1);
  // --muted-foreground: 226 15% 50%;
  static final Color mutedForeground = hslToColor(226, 15, 50);

  // --accent: 210 40% 96.1%;
  static final Color accent = hslToColor(210, 40, 96.1);
  // --accent-foreground: 222.2 47.4% 11.2%;
  static final Color accentForeground = hslToColor(222.2, 47.4, 11.2);

  // --destructive: 346 87% 60%;
  static final Color destructive = hslToColor(346, 87, 60);
  // --destructive-foreground: 210 40% 98%;
  static final Color destructiveForeground = hslToColor(210, 40, 98);

  // --border: 220 14% 90%;
  static final Color border = hslToColor(220, 14, 90);
  // --input: 220 14% 90%; (same as border)
  static final Color input = hslToColor(220, 14, 90);
  // --ring: 198 90% 48%; (same as primary)
  static final Color ring = hslToColor(198, 90, 48);
  
  // Sidebar specific colors (from :root in index.css)
  // --sidebar-background: 0 0% 100%;
  static final Color sidebarBackground = hslToColor(0, 0, 100);
  // --sidebar-foreground: 226 39% 16%;
  static final Color sidebarForeground = hslToColor(226, 39, 16);
  // --sidebar-primary: 198 90% 48%;
  static final Color sidebarPrimary = hslToColor(198, 90, 48);
  // --sidebar-primary-foreground: 0 0% 100%;
  static final Color sidebarPrimaryForeground = hslToColor(0, 0, 100);
  // --sidebar-accent: 220 14% 95%;
  static final Color sidebarAccent = hslToColor(220, 14, 95);
  // --sidebar-accent-foreground: 226 39% 16%;
  static final Color sidebarAccentForeground = hslToColor(226, 39, 16);
  // --sidebar-border: 220 14% 90%;
  static final Color sidebarBorder = hslToColor(220, 14, 90);
  // --sidebar-ring: 198 90% 48%;
  static final Color sidebarRing = hslToColor(198, 90, 48);

  // Gradients from tailwind.config.ts
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF0891B2)], // Sky-500 to Teal-600
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient primaryHoverGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF0891B2)], 
    stops: [0.2, 1.0], 
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)], // Indigo-500 to Violet-500
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)], // Emerald-500 to Emerald-600
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)], // Amber-400 to Amber-500
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFE11D48)], // Rose-500 to Rose-600
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient infoGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF38BDF8)], // Sky-500 to Sky-400
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient blueCyanGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF22D3EE)], // unidoc-primary-blue to unidoc-cyan-blue
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cyanSkyGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF38BDF8)], // Cyan-500 to Sky-400
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient deepOceanGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF0284C7)], // Blue-800 to Sky-600
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient aiAgentGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF818CF8)], // Sky-400 to Indigo-400
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient aiAutomateGradient = LinearGradient(
    colors: [Color(0xFF818CF8), Color(0xFFD946EF)], // Indigo-400 to Fuchsia-500
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient aiAskGradient = LinearGradient(
    colors: [Color(0xFFD946EF), Color(0xFFEC4899)], // Fuchsia-500 to Pink-500
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Primary brand colors
  static const Color unidocPrimary = Color(0xFF0093E9);
  static const Color unidocSecondary = Color(0xFF80D0C7);
  static const Color unidocAccent = Color(0xFFF5576C);
  
  // UI element colors
  static const Color unidocLightBg = Color(0xFFF5F7FA);
  static const Color unidocMediumGray = Color(0xFF8A94A6);
  static const Color unidocDarkGray = Color(0xFF364156);
  
  // Status colors
  static const Color statusSuccess = Color(0xFF34D399);
  static const Color statusWarning = Color(0xFFF59E0B);
  static const Color statusDanger = Color(0xFFEF4444);
  static const Color statusInfo = Color(0xFF3B82F6);
  static const Color statusPending = Color(0xFF8B5CF6);
  
  // Background gradients - modern 3D-ish gradients
  static const Gradient modernPrimaryGradient = LinearGradient(
    colors: [Color(0xFF0093E9), Color(0xFF80D0C7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient silverGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F2F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const Gradient shinyGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F7FA), Color(0xFFE4E8F0)],
    stops: [0.0, 0.3, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  AppTheme._();

  static const double _baseRadiusValue = 12.0; // from --radius: 0.75rem; (0.75 * 16px = 12px)

  static const Color unidocPrimary = Color(0xff1376f8);
  static const Color unidocSecondary = Color(0xFFF56565);
  static const Color unidocDark = Color(0xFF2D3748);
  static const Color unidocMedium = Color(0xFF718096);
  static const Color unidocLight = Color(0xFFF7FAFC);
  static const Color unidocBgLight = Color(0xFFF9FAFB);
  
  // Enhanced with more vibrant colors
  static const Color primaryGradientStart = Color(0xff1e88e5);
  static const Color primaryGradientEnd = Color(0xff0d47a1);
  static const Color successColor = Color(0xff2ecc71);
  static const Color warningColor = Color(0xfff39c12);
  static const Color errorColor = Color(0xffe74c3c);
  static const Color infoColor = Color(0xff3498db);

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    
    // Enhanced shadow for cards
    final cardTheme = CardTheme(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
    
    // Enhanced button styles
    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shadowColor: unidocPrimary.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: unidocPrimary,
        foregroundColor: Colors.white,
      ),
    );
    
    final outlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        side: BorderSide(color: unidocPrimary, width: 1.5),
        foregroundColor: unidocPrimary,
      ),
    );
    
    // Enhanced text button style
    final textButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: unidocPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    
    // Enhanced input decoration
    final inputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: unidocPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.grey.shade400),
      labelStyle: TextStyle(color: unidocMedium, fontWeight: FontWeight.w500),
      floatingLabelStyle: TextStyle(color: unidocPrimary, fontWeight: FontWeight.w600),
      // Add subtle shadow to inputs
      isDense: true,
      errorStyle: TextStyle(color: errorColor),
    );
    
    // Enhanced appbar
    final appBarTheme = AppBarTheme(
      elevation: 2, // Light shadow
      shadowColor: Colors.black.withOpacity(0.1),
      backgroundColor: Colors.white,
      foregroundColor: unidocDark,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: unidocDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: unidocDark,
      ),
    );
    
    // Add more depth to dividers
    final dividerTheme = DividerThemeData(
      space: 24,
      thickness: 1,
      color: Colors.grey.shade200,
    );
    
    // Enhanced dialog theme
    final dialogTheme = DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 24,
      titleTextStyle: TextStyle(
        color: unidocDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: unidocMedium,
        fontSize: 16,
      ),
    );
    
    // Tooltip with shadow
    final tooltipTheme = TooltipThemeData(
      decoration: BoxDecoration(
        color: unidocDark.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
    
    // Chip theme
    final chipTheme = ChipThemeData(
      backgroundColor: Colors.grey.shade100,
      disabledColor: Colors.grey.shade200,
      selectedColor: unidocPrimary.withOpacity(0.1),
      secondarySelectedColor: unidocPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      labelStyle: TextStyle(
        color: unidocDark,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      brightness: Brightness.light,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
    );
    
    // Enhanced bottom navigation
    final bottomNavigationBarTheme = BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: unidocPrimary,
      unselectedItemColor: unidocMedium,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    );
    
    return baseTheme.copyWith(
      primaryColor: unidocPrimary,
      scaffoldBackgroundColor: unidocBgLight,
      colorScheme: ColorScheme.light(
        primary: unidocPrimary,
        secondary: unidocSecondary,
        surface: Colors.white,
        onSurface: unidocDark,
        error: errorColor,
      ),
      cardTheme: cardTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      inputDecorationTheme: inputDecorationTheme,
      appBarTheme: appBarTheme,
      dividerTheme: dividerTheme,
      dialogTheme: dialogTheme,
      tooltipTheme: tooltipTheme,
      chipTheme: chipTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      splashFactory: InkRipple.splashFactory,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Add shimmering highlight for better visual appeal
      highlightColor: unidocPrimary.withOpacity(0.1),
      splashColor: unidocPrimary.withOpacity(0.05),
    );
  }

  // TODO: Define darkTheme based on .dark CSS variables if/when they are found or needed.

  // Define shadows for 3D depth effect
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -2,
    ),
  ];
  
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: AppColors.unidocPrimary.withOpacity(0.3),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get containerShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
}

// Custom Theme Extensions for easier access to gradients and radii

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({
    required this.primary,
    required this.primaryHover,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.blueCyan,
    required this.cyanSky,
    required this.deepOcean,
    required this.aiAgent,
    required this.aiAutomate,
    required this.aiAsk,
  });

  final Gradient primary;
  final Gradient primaryHover;
  final Gradient secondary;
  final Gradient success;
  final Gradient warning;
  final Gradient error;
  final Gradient info;
  final Gradient blueCyan;
  final Gradient cyanSky;
  final Gradient deepOcean;
  final Gradient aiAgent;
  final Gradient aiAutomate;
  final Gradient aiAsk;

  // Static factory using AppColors constants
  factory AppGradients.fromAppColors() {
    return const AppGradients(
      primary: AppColors.primaryGradient,
      primaryHover: AppColors.primaryHoverGradient,
      secondary: AppColors.secondaryGradient,
      success: AppColors.successGradient,
      warning: AppColors.warningGradient,
      error: AppColors.errorGradient,
      info: AppColors.infoGradient,
      blueCyan: AppColors.blueCyanGradient,
      cyanSky: AppColors.cyanSkyGradient,
      deepOcean: AppColors.deepOceanGradient,
      aiAgent: AppColors.aiAgentGradient,
      aiAutomate: AppColors.aiAutomateGradient,
      aiAsk: AppColors.aiAskGradient,
    );
  }
  
  // Static helper for splash screen.
  static LinearGradient primaryGradient(ColorScheme? scheme) {
    return AppColors.primaryGradient;
  }

  @override
  AppGradients copyWith({
    Gradient? primary,
    Gradient? primaryHover,
    Gradient? secondary,
    Gradient? success,
    Gradient? warning,
    Gradient? error,
    Gradient? info,
    Gradient? blueCyan,
    Gradient? cyanSky,
    Gradient? deepOcean,
    Gradient? aiAgent,
    Gradient? aiAutomate,
    Gradient? aiAsk,
  }) {
    return AppGradients(
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      blueCyan: blueCyan ?? this.blueCyan,
      cyanSky: cyanSky ?? this.cyanSky,
      deepOcean: deepOcean ?? this.deepOcean,
      aiAgent: aiAgent ?? this.aiAgent,
      aiAutomate: aiAutomate ?? this.aiAutomate,
      aiAsk: aiAsk ?? this.aiAsk,
    );
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) {
      return this;
    }
    return t < 0.5 ? this : other; // Simple lerp for gradients
  }
}

@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    required this.sm,
    required this.md,
    required this.lg,
  });

  final BorderRadius sm;
  final BorderRadius md;
  final BorderRadius lg;
  
  // Static getters for direct use of BorderRadius values if preferred
  // These assume _baseRadiusValue is accessible or values are hardcoded after calculation
  static final BorderRadius smRadius = BorderRadius.circular(AppTheme._baseRadiusValue - 6); // 8px if base is 12px
  static final BorderRadius mdRadius = BorderRadius.circular(AppTheme._baseRadiusValue - 4); // 10px if base is 12px
  static final BorderRadius lgRadius = BorderRadius.circular(AppTheme._baseRadiusValue);    // 12px


  @override
  AppRadii copyWith({BorderRadius? sm, BorderRadius? md, BorderRadius? lg}) {
    return AppRadii(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) {
      return this;
    }
    return AppRadii(
      sm: BorderRadius.lerp(sm, other.sm, t)!,
      md: BorderRadius.lerp(md, other.md, t)!,
      lg: BorderRadius.lerp(lg, other.lg, t)!,
    );
  }

  static AppRadii of(BuildContext context) {
    return Theme.of(context).extension<AppRadii>()!;
  }
}

// Helper for text styles based on index.css @layer base h1-h4 and others
// This can be expanded or integrated directly into TextTheme
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get h1 => GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.foreground, letterSpacing: -0.025 * 1.5, height: 1.2); // tracking-tight from Tailwind is often -0.025em or -0.05em
  static TextStyle get h2 => GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.foreground, letterSpacing: -0.025 * 1.5, height: 1.2);
  static TextStyle get h3 => GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.foreground, height: 1.2);
  static TextStyle get h4 => GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.foreground, height: 1.3); // Tailwind uses font-bold for h4, which is often 700, but 600 might fit better in Flutter scale
  
  static TextStyle get bodyLarge => GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.foreground, letterSpacing: 0.15, height: 1.5); // ~ text-base
  static TextStyle get bodyMedium => GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.foreground, letterSpacing: 0.25, height: 1.5); // ~ text-sm

  static TextStyle get sectionTitle => GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.unidocDark);
  static TextStyle get sectionSubtitle => GoogleFonts.inter(fontSize: 14, color: AppColors.unidocMedium, height: 1.5);

  static TextStyle get button => GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle get inputLabel => GoogleFonts.inter(fontSize: 14, color: AppColors.mutedForeground);
  static TextStyle get inputText => GoogleFonts.inter(fontSize: 14, color: AppColors.foreground);
}

// REMINDER: Add google_fonts to pubspec.yaml
// dependencies:
//   flutter:
//     sdk: flutter
//   google_fonts: ^6.1.0 # Or any latest compatible version 