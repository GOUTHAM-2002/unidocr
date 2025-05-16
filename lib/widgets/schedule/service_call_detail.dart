import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/service_call.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';

class ServiceCallDetail extends StatelessWidget {
  final ServiceCall serviceCall;
  final VoidCallback onClose;
  
  const ServiceCallDetail({
    super.key, 
    required this.serviceCall,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    
    final Color statusColor = ServiceCall.getStatusColor(serviceCall.status);
    final String statusText = ServiceCall.getStatusText(serviceCall.status);
    
    // Calculate the width - either 600px or 80% of screen width, whichever is smaller
    final detailWidth = size.width > 750 ? 600.0 : size.width * 0.8;
    
    // Create a container with limited width that takes full height
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Material(
        elevation: 8,
        child: Container(
          width: detailWidth,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20), // Increased padding
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade50],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Added close button and title row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Service Call Details',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: onClose,
                          icon: const Icon(LucideIcons.x),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            foregroundColor: Colors.grey.shade700,
                            padding: const EdgeInsets.all(12),
                          ),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Add a divider to separate the close button from the content
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 16),
                    // The existing header content
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company initials in circle
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: serviceCall.initialsColor.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 22, // Larger radius
                            backgroundColor: serviceCall.initialsColor,
                            child: Text(
                              serviceCall.initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), // Increased spacing
                        
                        // Company name and ID
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceCall.companyName,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Increased font size
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: statusColor.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      statusText,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LucideIcons.tag, size: 12, color: Colors.grey.shade600),
                                        const SizedBox(width: 4),
                                        Text(
                                          serviceCall.id,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Main content area - scrollable content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24), // Increased padding
                    child: detailWidth > 500 
                        ? _buildWideLayout(context, statusColor)
                        : _buildNarrowLayout(context, statusColor),
                  ),
                ),
              ),
              
              // Footer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade50, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, -3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(LucideIcons.x),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.grey.shade700,
                      ),
                      tooltip: 'Close',
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Action will depend on service call status
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: statusColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(_getActionText()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // New method for wide screen layout with two columns
  Widget _buildWideLayout(BuildContext context, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row with basic details and operator info
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column with basic details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(
                    context,
                    leftIcon: LucideIcons.calendar,
                    leftLabel: 'Date',
                    leftValue: DateFormat('MMM d, yyyy').format(serviceCall.date),
                    rightIcon: LucideIcons.clock,
                    rightLabel: 'Time',
                    rightValue: serviceCall.time,
                  ),
                  
                  _buildDetailSection(
                    context,
                    leftIcon: LucideIcons.wrench,
                    leftLabel: 'Service Type',
                    leftValue: 'site-prep',
                    rightIcon: LucideIcons.mapPin, 
                    rightLabel: 'Project Site',
                    rightValue: serviceCall.siteNumber,
                  ),
                  
                  _buildDetailSection(
                    context,
                    leftIcon: LucideIcons.box,
                    leftLabel: 'Quantity',
                    leftValue: '19 m³',
                    rightIcon: LucideIcons.gauge,
                    rightLabel: 'Pump Type',
                    rightValue: 'Boom Pump',
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 24),
            
            // Right column with operator info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Operator section
                  _buildOperatorSection(context),
                  
                  // Notes section
                  _buildNotesSection(context),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 30),
        
        // Second row with progress and action buttons (full width)
        _buildProgressSection(context, statusColor),
        
        const SizedBox(height: 30),
        
        // Action buttons
        _buildActionButtons(context, statusColor),
      ],
    );
  }
  
  // New method for narrow screen layout (single column)
  Widget _buildNarrowLayout(BuildContext context, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailSection(
          context,
          leftIcon: LucideIcons.calendar,
          leftLabel: 'Date',
          leftValue: DateFormat('MMM d, yyyy').format(serviceCall.date),
          rightIcon: LucideIcons.clock,
          rightLabel: 'Time',
          rightValue: serviceCall.time,
        ),
        
        _buildDetailSection(
          context,
          leftIcon: LucideIcons.wrench,
          leftLabel: 'Service Type',
          leftValue: 'site-prep',
          rightIcon: LucideIcons.mapPin, 
          rightLabel: 'Project Site',
          rightValue: serviceCall.siteNumber,
        ),
        
        _buildDetailSection(
          context,
          leftIcon: LucideIcons.box,
          leftLabel: 'Quantity',
          leftValue: '19 m³',
          rightIcon: LucideIcons.gauge,
          rightLabel: 'Pump Type',
          rightValue: 'Boom Pump',
        ),
        
        // Operator section
        _buildOperatorSection(context),
        
        // Notes section
        _buildNotesSection(context),
        
        // Service progress
        _buildProgressSection(context, statusColor),
        
        // Action buttons
        _buildActionButtons(context, statusColor),
      ],
    );
  }
  
  // Helper methods for different sections
  Widget _buildOperatorSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.user, size: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Operator',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  'JD',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Senior Pump Operator',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotesSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.clipboardList, size: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Notes',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            serviceCall.notes,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressSection(BuildContext context, Color statusColor) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Progress',
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: serviceCall.progressValue,
              backgroundColor: Colors.grey.shade200,
              color: statusColor,
              minHeight: 10, // Increased height
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons(BuildContext context, Color statusColor) {
    return Container(
      height: 56, // Increased height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(_getActionIcon(), size: 24), // Larger icon
        label: Text(
          _getActionText(),
          style: const TextStyle(
            fontSize: 18, // Larger font
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: statusColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          elevation: 0, // Removing default elevation since we're using custom shadow
        ),
      ),
    );
  }
  
  Widget _buildTab({
    required IconData icon, 
    required String label, 
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isActive 
              ? LinearGradient(
                  colors: [Colors.white, Colors.blue.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ) 
              : null,
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.blue : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18, // Increased size
              color: isActive ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14, // Increased size
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailSection(
    BuildContext context, {
    required IconData leftIcon,
    required String leftLabel,
    required String leftValue,
    required IconData rightIcon,
    required String rightLabel,
    required String rightValue,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 500;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: isNarrow 
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Icon(leftIcon, size: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            leftLabel, 
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            leftValue,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Right column
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Icon(rightIcon, size: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rightLabel, 
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rightValue,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(leftIcon, size: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              leftLabel, 
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              leftValue,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Right column
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(rightIcon, size: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rightLabel, 
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              rightValue,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  
  IconData _getActionIcon() {
    switch (serviceCall.status) {
      case ServiceCallStatus.scheduled:
        return LucideIcons.play;
      case ServiceCallStatus.inProgress:
        return LucideIcons.checkCircle;
      case ServiceCallStatus.incomplete:
        return LucideIcons.checkCircle;
      case ServiceCallStatus.awaitingSignature:
        return LucideIcons.fileSignature;
      case ServiceCallStatus.completed:
        return LucideIcons.fileText;
      case ServiceCallStatus.pending:
        return LucideIcons.play;
    }
  }
  
  String _getActionText() {
    switch (serviceCall.status) {
      case ServiceCallStatus.scheduled:
        return 'Start Service';
      case ServiceCallStatus.inProgress:
        return 'Mark Complete';
      case ServiceCallStatus.incomplete:
        return 'Mark Complete';
      case ServiceCallStatus.awaitingSignature:
        return 'Get Signature';
      case ServiceCallStatus.completed:
        return 'View Doc';
      case ServiceCallStatus.pending:
        return 'Start Service';
    }
  }
} 