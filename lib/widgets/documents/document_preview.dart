import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/dummy/document_mock_data.dart';
import 'package:unidoc/models/document_models.dart';
import 'package:unidoc/theme/app_theme.dart';

class DocumentPreview extends StatelessWidget {
  final Document? document;
  final DocumentType? documentType;

  const DocumentPreview({
    super.key,
    this.document,
    this.documentType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPreviewHeader(context),
          const SizedBox(height: 16),
          Expanded(
            child: _buildPreviewContent(context),
          ),
        ],
      ),
    );
  }

  // Build preview header
  Widget _buildPreviewHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Preview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Print functionality
              },
              icon: const Icon(LucideIcons.printer),
              tooltip: 'Print',
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                // Download functionality
              },
              icon: const Icon(LucideIcons.download),
              tooltip: 'Download',
            ),
          ],
        ),
      ],
    );
  }

  // Build preview content based on active preview type
  Widget _buildPreviewContent(BuildContext context) {
    // Display message when no document is selected
    if (document == null && documentType == null) {
      return _buildEmptyPreview(context);
    }

    // Display a preview based on document or form type
    if (document != null) {
      return _buildDocumentPreview(context, document!);
    } else if (documentType != null) {
      return _buildNewDocumentPreview(context, documentType!);
    }

    return _buildEmptyPreview(context);
  }

  // Build empty preview state
  Widget _buildEmptyPreview(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This is how your document will look when printed or downloaded.',
            style: TextStyle(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Icon(
            LucideIcons.fileText,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Select a document or create a new one',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build preview for an existing document
  Widget _buildDocumentPreview(BuildContext context, Document document) {
    switch (document.type) {
      case DocumentType.serviceCall:
        return _buildServiceCallPreview(context, document);
      case DocumentType.deliveryCertificate:
        return _buildDeliveryCertificatePreview(context, document);
      case DocumentType.report:
        return _buildReportPreview(context, document);
      default:
        return _buildEmptyPreview(context);
    }
  }

  // Build preview for a new document being created
  Widget _buildNewDocumentPreview(BuildContext context, DocumentType type) {
    switch (type) {
      case DocumentType.serviceCall:
        return _buildServiceCallFormPreview(context);
      case DocumentType.deliveryCertificate:
        return _buildDeliveryCertificateFormPreview(context);
      case DocumentType.report:
        return _buildReportFormPreview(context);
      default:
        return _buildEmptyPreview(context);
    }
  }

  // Service Call preview
  Widget _buildServiceCallPreview(BuildContext context, Document document) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header message
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: AppRadii.smRadius,
            ),
            child: Row(
              children: [
                Icon(LucideIcons.info, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This is how your document will look when printed or downloaded.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Document preview content
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: AppRadii.mdRadius,
            ),
            child: ClipRRect(
              borderRadius: AppRadii.mdRadius,
              child: Column(
                children: [
                  // Company header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppRadii.smRadius,
                          ),
                          child: Icon(
                            LucideIcons.fileText,
                            color: Colors.blue[700],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.metadata?['companyName'] ?? 'UNIDOC Solutions', 
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'SERVICE CALL',
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                document.metadata?['companyAddress'] ?? 
                                    '123 Business Avenue, Suite 100, Enterprise City',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Row(
                                children: [
                                  Icon(LucideIcons.phone, size: 12, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    document.metadata?['companyPhone'] ?? '+1 (555) 123-4567',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(LucideIcons.mail, size: 12, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    document.metadata?['companyEmail'] ?? 'service@unidoc.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
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
                  
                  // Main content
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add more document preview content here
                        // This will be expanded in the next edit
                        Text('Document content will be displayed here'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Delivery Certificate preview
  Widget _buildDeliveryCertificatePreview(BuildContext context, Document document) {
    // For now, use the same preview as service call with different header
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header message
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: AppRadii.smRadius,
            ),
            child: Row(
              children: [
                Icon(LucideIcons.info, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This is how your document will look when printed or downloaded.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Simple placeholder for delivery certificate
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: AppRadii.mdRadius,
            ),
            child: const Center(
              child: Text('Delivery Certificate Preview'),
            ),
          ),
        ],
      ),
    );
  }

  // Report preview
  Widget _buildReportPreview(BuildContext context, Document document) {
    // For now, use a simple placeholder
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header message
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: AppRadii.smRadius,
            ),
            child: Row(
              children: [
                Icon(LucideIcons.info, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This is how your document will look when printed or downloaded.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Simple placeholder for report
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: AppRadii.mdRadius,
            ),
            child: const Center(
              child: Text('Report Preview'),
            ),
          ),
        ],
      ),
    );
  }

  // Service Call form preview
  Widget _buildServiceCallFormPreview(BuildContext context) {
    // For now, return a placeholder
    return Center(
      child: Text(
        'Service Call Preview\nForm data will be reflected here.',
        style: TextStyle(color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Delivery Certificate form preview
  Widget _buildDeliveryCertificateFormPreview(BuildContext context) {
    // For now, return a placeholder
    return Center(
      child: Text(
        'Delivery Certificate Preview\nForm data will be reflected here.',
        style: TextStyle(color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Report form preview
  Widget _buildReportFormPreview(BuildContext context) {
    // For now, return a placeholder
    return Center(
      child: Text(
        'Report Preview\nForm data will be reflected here.',
        style: TextStyle(color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
    );
  }
} 