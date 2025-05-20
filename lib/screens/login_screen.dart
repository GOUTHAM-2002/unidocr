import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:unidoc/widgets/animated_gradient_background.dart'; // Assuming this is part of the old theme, remove for now
import 'package:unidoc/theme/app_theme.dart';
import 'package:go_router/go_router.dart'; // For navigation
import 'package:unidoc/router/app_router.dart'; // For RoutePaths
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/widgets/common/unidoc_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleLogin() {
    if (_loginFormKey.currentState?.validate() ?? false) {
      // Any input is fine for the demo
      context.go(RoutePaths.dashboard);
    }
  }

  void _handleCreateAccount() {
    // Navigate to registration page or show registration form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create account clicked (Not implemented)')),
    );
  }

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot password clicked (Not implemented)')),
    );
  }

  void _handleGoogleSignIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google sign in clicked (Not implemented)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 900;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: isSmallScreen 
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const UnidocLogo(
                size: 60, 
                lightColor: AppColors.unidocPrimaryBlue, 
                darkColor: AppColors.unidocDeepBlue
              ),
              const SizedBox(height: 24),
              Text(
                'Your office is in your pocket',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.unidocDeepBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Manage your business efficiently anytime, anywhere.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.unidocMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final appGradients = Theme.of(context).extension<AppGradients>();
    
    return Row(
      children: [
        // Left side - Blue gradient with content
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: appGradients?.deepOcean ?? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.unidocDeepBlue,
                  AppColors.unidocPrimaryBlue,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your office is in your pocket',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    'Manage your business efficiently anytime, anywhere.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white.withOpacity(0.85),
                      fontWeight: FontWeight.normal,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 60),
                  
                  // Phone mockup
                  Center(
                    child: _buildPhoneMockup(context),
                  ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                ],
              ),
            ),
          ),
        ),
        
        // Right side - Login form
        Expanded(
          flex: 4,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                constraints: const BoxConstraints(maxWidth: 450),
                child: _buildLoginForm(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneMockup(BuildContext context) {
    return Container(
      width: 380,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              margin: const EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                children: [
                  // Status bar
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('9:41', style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.search, size: 20, color: Colors.grey[800]),
                            const SizedBox(width: 20),
                            Icon(Icons.fullscreen, size: 20, color: Colors.grey[800]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // App UI mockup
                  Expanded(
                    child: Stack(
                      children: [
                        // App content
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              // Unidoc logo and header
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const UnidocLogo(
                                      size: 32,
                                      lightColor: AppColors.unidocPrimaryBlue,
                                      darkColor: AppColors.unidocDeepBlue,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Unidoc',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // New Service Call card
                              Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[200]!),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(LucideIcons.clock, size: 16, color: AppColors.unidocPrimaryBlue),
                                        const SizedBox(width: 8),
                                        Text(
                                          'New Service Call',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    
                                    // Customer selection
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey[200]!),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: AppColors.unidocPrimaryBlue.withOpacity(0.2),
                                                child: const Text('1', style: TextStyle(fontSize: 12, color: AppColors.unidocPrimaryBlue)),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Select',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Customer',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.unidocPrimaryBlue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                                        ],
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 12),
                                    
                                    // Service details
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.grey[200],
                                          child: Text('2', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Service Details',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Customer chat example
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: AppColors.unidocLightBlue,
                                      radius: 20,
                                      child: Text('JD', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'John Doe',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                'Now',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Online',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Message box
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'When will you arrive on-site?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Response box
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.unidocPrimaryBlue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "We'll be there in about 30 minutes.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Feature icons on sides
                        Positioned(
                          right: -20,
                          top: 100,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.fileText, color: AppColors.unidocSecondaryOrange, size: 20),
                          ),
                        ),
                        
                        Positioned(
                          left: -10,
                          top: 180,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.clipboardCheck, color: AppColors.unidocSuccess, size: 20),
                          ),
                        ),
                        
                        Positioned(
                          right: -15,
                          top: 250,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.mapPin, color: Colors.redAccent, size: 20),
                          ),
                        ),
                        
                        Positioned(
                          left: -20,
                          top: 320,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.calendarClock, color: AppColors.unidocLightBlue, size: 20),
                          ),
                        ),
                        
                        Positioned(
                          right: -10,
                          top: 380,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.messageSquare, color: AppColors.unidocCyanBlue, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom navigation
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.home, size: 20, color: AppColors.unidocPrimaryBlue),
                            Text('Home', style: TextStyle(fontSize: 10, color: AppColors.unidocPrimaryBlue)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.calendar, size: 20, color: Colors.grey[500]),
                            Text('Schedule', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.fileText, size: 20, color: Colors.grey[500]),
                            Text('Documents', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.messageSquare, size: 20, color: Colors.grey[500]),
                            Text('Chat', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Notch
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: 150,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        
        // Logo on mobile, hidden on desktop
        MediaQuery.of(context).size.width < 900
            ? const SizedBox.shrink()
            : const UnidocLogo(
                size: 60,
                lightColor: AppColors.unidocPrimaryBlue,
                darkColor: AppColors.unidocDeepBlue,
              ),
        
        const SizedBox(height: 24),
        
        // Sign in text
        Text(
          'Sign in',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.unidocDark,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Don't have an account text
        RichText(
          text: TextSpan(
            style: textTheme.bodyLarge?.copyWith(color: AppColors.unidocMedium),
            children: [
              const TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: "Create one",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()..onTap = _handleCreateAccount,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Google Sign in button
        OutlinedButton.icon(
          icon: const Icon(LucideIcons.globe, size: 20),
          label: const Text('Sign in with Google'),
          onPressed: _handleGoogleSignIn,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(color: AppColors.border),
            foregroundColor: AppColors.unidocDark,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // OR divider
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('OR', style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
            ),
            Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Login form
        Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email field
              Text(
                'Email',
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.unidocDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'name@example.com',
                  prefixIcon: const Icon(LucideIcons.mail, size: 20, color: AppColors.unidocMedium),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Password field
              Text(
                'Password',
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.unidocDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: const Icon(LucideIcons.lock, size: 20, color: AppColors.unidocMedium),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                      size: 20,
                      color: AppColors.unidocMedium,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 12),
              
              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _handleForgotPassword,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Sign in button
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sign in',
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Bottom text to match image
        MediaQuery.of(context).size.width >= 900
            ? Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Streamline your workflow with our comprehensive office management solution.',
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.unidocMedium),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
} 