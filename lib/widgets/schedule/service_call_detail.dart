import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/service_call.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:unidoc/l10n/app_localizations.dart';
import 'package:unidoc/services/settings_service.dart';

class ServiceCallDetail extends StatefulWidget {
  final ServiceCall serviceCall;
  final VoidCallback onClose;
  
  const ServiceCallDetail({
    super.key, 
    required this.serviceCall,
    required this.onClose,
  });

  @override
  State<ServiceCallDetail> createState() => _ServiceCallDetailState();
}

class _ServiceCallDetailState extends State<ServiceCallDetail> {
  int _selectedTabIndex = 0;
  late List<String> _tabs;
  final List<IconData> _tabIcons = [
    LucideIcons.info, 
    LucideIcons.users, 
    LucideIcons.messageSquare, 
    LucideIcons.fileText, 
    LucideIcons.history
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);
    final settingsService = SettingsService();
    
    final Color statusColor = ServiceCall.getStatusColor(widget.serviceCall.status);
    final String statusText = ServiceCall.getStatusText(widget.serviceCall.status, context: context) ?? '';
    
    // Calculate the width - either 600px or 80% of screen width, whichever is smaller
    final detailWidth = size.width > 750 ? 600.0 : size.width * 0.8;
    
    // Update tab labels with localized strings
    _tabs = [
      l10n?.details ?? 'Details',
      l10n?.contacts ?? 'Contacts',
      l10n?.chat ?? 'Chat', 
      l10n?.documents ?? 'Documents',
      l10n?.history ?? 'History'
    ];
    
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade50],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Column(
                  children: [
                    // Company name and close button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Company name and ID tag
                        Expanded(
                          child: Row(
                            children: [
                              // Initials circle
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: widget.serviceCall.initialsColor,
                                child: Text(
                                  widget.serviceCall.initials,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Company name
                              Expanded(
                                child: Text(
                                  widget.serviceCall.companyName,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Status badge with ID
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.tag, size: 12, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                widget.serviceCall.id,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Close button
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: widget.onClose,
                          icon: const Icon(LucideIcons.x),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            foregroundColor: Colors.grey.shade700,
                          ),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Tabs row
                    Row(
                      children: [
                        for (int i = 0; i < _tabs.length; i++)
                          Expanded(
                            child: _buildTab(
                              icon: _tabIcons[i],
                              label: _tabs[i],
                              isActive: _selectedTabIndex == i,
                              onTap: () {
                                setState(() {
                                  _selectedTabIndex = i;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                    
                    // Tab indicator
                    Container(
                      height: 2,
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          for (int i = 0; i < _tabs.length; i++)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: _selectedTabIndex == i ? Colors.blue : Colors.transparent,
                              ),
                            ),
                        ],
                      ),
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
                    padding: const EdgeInsets.all(24),
                    child: _buildTabContent(context, statusColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Method to return the appropriate content based on selected tab
  Widget _buildTabContent(BuildContext context, Color statusColor) {
    switch (_selectedTabIndex) {
      case 0: // Details tab
        return _buildDetailsTab(context, statusColor);
      case 1: // Contacts tab
        return _buildContactsTab(context);
      case 2: // Chat tab
        return _buildChatTab(context);
      case 3: // Documents tab
        return _buildDocumentsTab(context);
      case 4: // History tab
        return _buildHistoryTab(context);
      default:
        return _buildDetailsTab(context, statusColor);
    }
  }
  
  // DETAILS TAB
  Widget _buildDetailsTab(BuildContext context, Color statusColor) {
    final size = MediaQuery.of(context).size;
    
    return size.width > 500 
        ? _buildWideLayout(context, statusColor)
        : _buildNarrowLayout(context, statusColor);
  }
  
  // CONTACTS TAB
  Widget _buildContactsTab(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer Information section
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.building, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Customer Information',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.phone, size: 16),
                    label: const Text('Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Customer card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: widget.serviceCall.initialsColor.withOpacity(0.2),
                          child: Text(
                            widget.serviceCall.initials,
                            style: TextStyle(
                              color: widget.serviceCall.initialsColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.serviceCall.companyName,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Project Manager',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Contact details
                    Row(
                      children: [
                        Icon(LucideIcons.phone, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          '+1 (555) 123-4567',
                          style: textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          'contact@${widget.serviceCall.companyName.toLowerCase().replaceAll(' ', '')}',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          widget.serviceCall.siteNumber,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Service Personnel section
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.users, size: 16, color: Colors.green.shade600),
                  const SizedBox(width: 8),
                  Text(
                    'Service Personnel',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.phone, size: 16),
                    label: const Text('Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade50,
                      foregroundColor: Colors.green.shade600,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Operator card
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue.shade100,
                          child: const Text(
                            'JS',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.serviceCall.assignedTo,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Assigned',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Field Operator',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.phone, size: 20),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 52), // For alignment
                        Text(
                          'johnsmith@unidoc.com',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Supervisor card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green.shade100,
                          child: const Text(
                            'AR',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Alex Rodriguez',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Supervisor',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Operations Manager',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.phone, size: 20),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 52), // For alignment
                        Text(
                          'alex.rodriguez@unidoc.com',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // CHAT TAB
  Widget _buildChatTab(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chat header
        Row(
          children: [
            const Icon(LucideIcons.messageSquare, size: 16, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              'Service Call Chat',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.blue,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('View Full Chat'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Empty chat state
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.messageSquare,
                size: 64,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'No messages yet',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start a conversation about this service call to\ncoordinate with the customer and team.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.messageSquarePlus),
                label: const Text('Start Conversation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Chat input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.paperclip),
                color: Colors.grey.shade600,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.image),
                color: Colors.grey.shade600,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.send),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // DOCUMENTS TAB
  Widget _buildDocumentsTab(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Documents',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 24),
        
        // Service Call Document
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.fileText, size: 20, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service Call Document',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 00:00',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'S${widget.serviceCall.id.substring(1)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Document preview
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.fileText,
                        size: 40,
                        color: Colors.blue.shade300,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Service Call Document preview',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.messageSquare, size: 16),
                    label: const Text('Discuss'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.eye, size: 16),
                    label: const Text('View'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.download, size: 16),
                    label: const Text('Download'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green.shade600,
                      side: BorderSide(color: Colors.green.shade600),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Delivery Certificate 
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(LucideIcons.clipboardCheck, size: 20, color: Colors.green.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Certificate',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 02:00',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'C3476',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Service Report (not available yet)
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.fileBarChart, size: 20, color: Colors.purple),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service Report',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 03:00',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'R3476',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Document not available message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      LucideIcons.fileOutput,
                      size: 32,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Document not available',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This document will be generated as the service call\nprogresses',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // HISTORY TAB
  Widget _buildHistoryTab(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(LucideIcons.clock, size: 16, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              'Service Call Timeline',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Timeline events
        _buildTimelineEvent(
          context: context,
          icon: LucideIcons.clipboardList,
          title: 'Service Call Created',
          description: 'Created by ${widget.serviceCall.companyName}',
          date: '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 00:00',
          iconColor: Colors.blue,
          isFirst: true,
        ),
        
        _buildTimelineEvent(
          context: context,
          icon: LucideIcons.userCheck,
          title: 'Operator Assigned',
          description: '${widget.serviceCall.assignedTo} was assigned to this service call',
          date: '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 00:00',
          iconColor: Colors.green.shade600,
        ),
        
        _buildTimelineEvent(
          context: context,
          icon: LucideIcons.calendar,
          title: 'Scheduled',
          description: 'Service call scheduled for ${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} at ${widget.serviceCall.time}',
          date: '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 22:00',
          iconColor: Colors.orange,
        ),
        
        _buildTimelineEvent(
          context: context,
          icon: LucideIcons.play,
          title: 'In Progress',
          description: '${widget.serviceCall.assignedTo} started working on site',
          date: '${DateFormat('MMM d, yyyy').format(widget.serviceCall.date)} • 00:00',
          iconColor: Colors.purple,
          isLast: true,
        ),
        
        const SizedBox(height: 24),
        
        // Project site detail
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.mapPin, size: 20, color: Colors.grey.shade700),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Site:',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    widget.serviceCall.siteNumber,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Helper method to build timeline events
  Widget _buildTimelineEvent({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String date,
    required Color iconColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line and icon
        SizedBox(
          width: 40,
          child: Column(
            children: [
              // Top connector line (not for first item)
              if (!isFirst)
                Container(
                  width: 2,
                  height: 12,
                  color: Colors.grey.shade300,
                ),
              
              // Circle icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: iconColor, width: 2),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: iconColor,
                ),
              ),
              
              // Bottom connector line (not for last item)
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
        ),
        
        // Event content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
                    leftValue: DateFormat('MMM d, yyyy').format(widget.serviceCall.date),
                    rightIcon: LucideIcons.clock,
                    rightLabel: 'Time',
                    rightValue: widget.serviceCall.time,
                  ),
                  
                  _buildDetailSection(
                    context,
                    leftIcon: LucideIcons.wrench,
                    leftLabel: 'Service Type',
                    leftValue: 'demolition',
                    rightIcon: LucideIcons.mapPin, 
                    rightLabel: 'Project Site',
                    rightValue: widget.serviceCall.siteNumber,
                  ),
                  
                  _buildDetailSection(
                    context,
                    leftIcon: LucideIcons.box,
                    leftLabel: 'Quantity',
                    leftValue: '50 m²',
                    rightIcon: LucideIcons.gauge,
                    rightLabel: 'Pump Type',
                    rightValue: 'Trailer Pump',
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
          leftValue: DateFormat('MMM d, yyyy').format(widget.serviceCall.date),
          rightIcon: LucideIcons.clock,
          rightLabel: 'Time',
          rightValue: widget.serviceCall.time,
        ),
        
        _buildDetailSection(
          context,
          leftIcon: LucideIcons.wrench,
          leftLabel: 'Service Type',
          leftValue: 'demolition',
          rightIcon: LucideIcons.mapPin, 
          rightLabel: 'Project Site',
          rightValue: widget.serviceCall.siteNumber,
        ),
        
        _buildDetailSection(
          context,
          leftIcon: LucideIcons.box,
          leftLabel: 'Quantity',
          leftValue: '50 m²',
          rightIcon: LucideIcons.gauge,
          rightLabel: 'Pump Type',
          rightValue: 'Trailer Pump',
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
              // Operator initials
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pink.shade100,
                child: Text(
                  'SJ',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Johnson',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.serviceCall.assignedTo,
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
            widget.serviceCall.notes,
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
              value: widget.serviceCall.progressValue,
              backgroundColor: Colors.grey.shade200,
              color: statusColor,
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons(BuildContext context, Color statusColor) {
    // For "awaiting signature" we need two buttons
    if (widget.serviceCall.status == ServiceCallStatus.awaitingSignature) {
      return Row(
        children: [
          // Get Signature button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.fileSignature, size: 20),
                label: const Text(
                  'Get Signature',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  elevation: 0,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Without Signature button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.fileX, size: 20),
                label: const Text(
                  'Without Signature',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    // For "in progress" status, show two action buttons for mark complete/incomplete
    if (widget.serviceCall.status == ServiceCallStatus.inProgress) {
      return Row(
        children: [
          // Mark Complete button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.checkCircle, size: 20),
                label: const Text(
                  'Mark Complete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  elevation: 0,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Mark as Incomplete button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.alertTriangle, size: 20),
                label: const Text(
                  'Mark as Incomplete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    // For other statuses, single action button
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
        icon: Icon(_getActionIcon(), size: 20),
        label: Text(
          _getActionText(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: statusColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          elevation: 0,
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
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
    switch (widget.serviceCall.status) {
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
    switch (widget.serviceCall.status) {
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