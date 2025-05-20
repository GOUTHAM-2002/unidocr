import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/theme/app_theme.dart';

class GlobalSettings extends StatefulWidget {
  const GlobalSettings({super.key});

  @override
  State<GlobalSettings> createState() => _GlobalSettingsState();
}

class _GlobalSettingsState extends State<GlobalSettings> {
  // Settings values
  String platformName = 'Unidoc Service Platform';
  String description = 'A comprehensive service management platform for delivery certificates.';
  String logoUrl = 'https://example.com/logo.png';
  String supportEmail = 'support@example.com';
  String termsUrl = 'https://example.com/terms';
  String privacyUrl = 'https://example.com/privacy';
  bool emailNotifications = true;
  bool pushNotifications = false;
  String passwordResetFrequency = '90 days';
  bool twoFactorAuth = false;
  bool maintenanceMode = false;
  String defaultLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            theme, 
            icon: LucideIcons.globe, 
            iconColor: Colors.blue,
            title: 'Platform Identity',
            subtitle: 'Configure your platform branding and identity',
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            theme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  theme,
                  label: 'Platform Name',
                  hint: 'The name of your service platform.',
                  value: platformName,
                  onChanged: (value) {
                    setState(() {
                      platformName = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  theme,
                  label: 'Default Language',
                  hint: 'The default language for the platform.',
                  value: defaultLanguage,
                  isDropdown: true,
                  onChanged: (value) {
                    setState(() {
                      defaultLanguage = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  theme,
                  label: 'Description',
                  hint: 'Briefly describe the purpose of this platform.',
                  value: description,
                  isMultiline: true,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  theme,
                  label: 'Logo URL',
                  hint: 'URL to your platform logo image.',
                  value: logoUrl,
                  onChanged: (value) {
                    setState(() {
                      logoUrl = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(
            theme, 
            icon: LucideIcons.fileText, 
            iconColor: Colors.green,
            title: 'Support & Documentation',
            subtitle: 'Configure support and legal documentation',
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            theme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  theme,
                  label: 'Support Email',
                  hint: 'Email address where users can get support.',
                  value: supportEmail,
                  onChanged: (value) {
                    setState(() {
                      supportEmail = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  theme,
                  label: 'Terms of Service URL',
                  hint: 'Link to your Terms of Service page.',
                  value: termsUrl,
                  onChanged: (value) {
                    setState(() {
                      termsUrl = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  theme,
                  label: 'Privacy Policy URL',
                  hint: 'Link to your Privacy Policy page.',
                  value: privacyUrl,
                  onChanged: (value) {
                    setState(() {
                      privacyUrl = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(
            theme, 
            icon: LucideIcons.bell, 
            iconColor: Colors.orange,
            title: 'Notification Settings',
            subtitle: 'Manage email and push notifications',
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            theme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSwitchSetting(
                  theme,
                  label: 'Email Notifications',
                  description: 'Send updates and alerts via email.',
                  value: emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      emailNotifications = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildSwitchSetting(
                  theme,
                  label: 'Push Notifications',
                  description: 'Send real-time alerts to mobile devices.',
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      pushNotifications = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(
            theme, 
            icon: LucideIcons.shield, 
            iconColor: Colors.teal,
            title: 'Security Settings',
            subtitle: 'Configure password and authentication settings',
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            theme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  theme,
                  label: 'Password Reset Frequency',
                  hint: 'How often users should reset their passwords.',
                  value: passwordResetFrequency,
                  isDropdown: true,
                  onChanged: (value) {
                    setState(() {
                      passwordResetFrequency = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _buildSwitchSetting(
                  theme,
                  label: 'Two-Factor Authentication',
                  description: 'Enable two-factor authentication for enhanced security.',
                  value: twoFactorAuth,
                  onChanged: (value) {
                    setState(() {
                      twoFactorAuth = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(
            theme, 
            icon: LucideIcons.alertTriangle, 
            iconColor: Colors.amber,
            title: 'System Settings',
            subtitle: 'Configure critical system settings',
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            theme,
            color: maintenanceMode ? Colors.amber.withOpacity(0.1) : null,
            child: _buildSwitchSetting(
              theme,
              label: 'Maintenance Mode',
              description: 'When enabled, the system will be unavailable to regular users. Only administrators will be able to access the platform.',
              value: maintenanceMode,
              onChanged: (value) {
                // Show confirmation dialog before enabling
                if (value) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Enable Maintenance Mode?'),
                      content: const Text('This will disconnect all regular users from the platform. Only administrators will be able to access it.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              maintenanceMode = true;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Enable'),
                        ),
                      ],
                    ),
                  );
                } else {
                  setState(() {
                    maintenanceMode = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Save settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings saved successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(LucideIcons.save),
              label: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(
    ThemeData theme, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingsCard(
    ThemeData theme, {
    required Widget child,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: child,
    );
  }
  
  Widget _buildTextField(
    ThemeData theme, {
    required String label,
    required String hint,
    required String value,
    bool isMultiline = false,
    bool isDropdown = false,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        if (isDropdown)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                const Icon(LucideIcons.chevronDown, size: 16),
              ],
            ),
          )
        else
          TextField(
            controller: TextEditingController(text: value),
            onChanged: onChanged,
            maxLines: isMultiline ? 3 : 1,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          hint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSwitchSetting(
    ThemeData theme, {
    required String label,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: theme.colorScheme.primary,
        ),
      ],
    );
  }
} 