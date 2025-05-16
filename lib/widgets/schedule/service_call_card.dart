import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/service_call.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:unidoc/widgets/common/shiny_card.dart';

class ServiceCallCard extends StatelessWidget {
  final ServiceCall serviceCall;
  final VoidCallback onMorePressed;
  final VoidCallback onActionPressed;
  final VoidCallback? onCardTap;
  
  const ServiceCallCard({
    super.key,
    required this.serviceCall,
    required this.onMorePressed,
    required this.onActionPressed,
    this.onCardTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    final Color statusColor = ServiceCall.getStatusColor(serviceCall.status);
    final String statusText = ServiceCall.getStatusText(serviceCall.status);
    
    // Style constants for 3D effect
    final borderWidth = 4.0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onCardTap,
        borderRadius: BorderRadius.circular(10),
        child: ShinyCard(
          borderRadius: 10,
          padding: EdgeInsets.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: statusColor.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: statusColor,
                  width: borderWidth,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company circle with initials
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: serviceCall.initialsColor.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: serviceCall.initialsColor,
                          child: Text(
                            serviceCall.initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Main content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Company name and status badge
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    serviceCall.companyName,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
                              ],
                            ),
                            const SizedBox(height: 4),
                            
                            // Row for date and time  
                            Row(
                              children: [
                                Icon(LucideIcons.calendar, size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat('MMM d, yyyy').format(serviceCall.date),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(LucideIcons.clock, size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Text(
                                  serviceCall.time,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            
                            // Row for site and operator
                            Row(
                              children: [
                                Icon(LucideIcons.mapPin, size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "Site ${serviceCall.siteNumber}",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(LucideIcons.user, size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    serviceCall.assignedTo,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // More options button
                      GestureDetector(
                        onTap: onMorePressed,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            LucideIcons.moreVertical,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Progress indicator and action button
                  Row(
                    children: [
                      // Progress indicator
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Progress',
                                  style: textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${(serviceCall.progressValue * 100).toInt()}%',
                                  style: textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: serviceCall.progressValue,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Action button
                      GestureDetector(
                        onTap: onActionPressed,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withOpacity(0.2),
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: onActionPressed,
                            icon: Icon(_getActionIcon(serviceCall.status), size: 16),
                            label: Text(_getActionText(serviceCall.status)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: statusColor,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              textStyle: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  IconData _getActionIcon(ServiceCallStatus status) {
    switch (status) {
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
  
  String _getActionText(ServiceCallStatus status) {
    switch (status) {
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