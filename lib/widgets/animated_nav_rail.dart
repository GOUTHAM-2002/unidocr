import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/glass_card.dart';

class AnimatedNavRail extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationRailDestination> destinations;

  const AnimatedNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  State<AnimatedNavRail> createState() => _AnimatedNavRailState();
}

class _AnimatedNavRailState extends State<AnimatedNavRail> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: _isExpanded ? 280 : 80,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: NavigationRail(
              extended: _isExpanded,
              backgroundColor: Colors.transparent,
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              destinations: widget.destinations,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideX(
        begin: -0.2,
        end: 0,
        duration: 600.ms,
        curve: Curves.easeOutBack,
      );
  }
} 