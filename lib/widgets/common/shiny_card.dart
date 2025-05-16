import 'package:flutter/material.dart';

class ShinyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final bool isActive;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const ShinyCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.borderRadius = 12,
    this.isActive = false,
    this.onTap,
    this.borderColor,
    this.backgroundColor,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        offset: const Offset(0, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        offset: const Offset(0, 8),
        blurRadius: 16,
        spreadRadius: -2,
      ),
    ];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isActive
                ? [Colors.white, const Color(0xFFF5F7FA)]
                : [Colors.white, const Color(0xFFF0F2F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? Colors.grey.shade200,
            width: isActive ? 1.5 : 1.0,
          ),
          boxShadow: boxShadow ?? defaultBoxShadow,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class ShinyActionCard extends StatelessWidget {
  final Widget child;
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final bool isActive;
  final Color? accentColor;

  const ShinyActionCard({
    Key? key,
    required this.child,
    this.icon,
    this.title,
    this.subtitle,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.borderRadius = 12,
    this.isActive = false,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = accentColor ?? theme.colorScheme.primary;

    return ShinyCard(
      onTap: onTap,
      isActive: isActive,
      borderRadius: borderRadius,
      margin: margin,
      padding: EdgeInsets.zero,
      borderColor: isActive ? color.withOpacity(0.5) : null,
      boxShadow: [
        BoxShadow(
          color: isActive ? color.withOpacity(0.1) : Colors.black.withOpacity(0.04),
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: isActive ? color.withOpacity(0.15) : Colors.black.withOpacity(0.06),
          offset: const Offset(0, 8),
          blurRadius: 16,
          spreadRadius: -2,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || title != null)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade100,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                      color: isActive ? color : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isActive ? color : Colors.grey.shade800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Padding(
            padding: title != null ? 
              const EdgeInsets.fromLTRB(16, 8, 16, 16) : 
              padding,
            child: child,
          ),
        ],
      ),
    );
  }
} 