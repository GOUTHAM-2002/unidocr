import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/dummy/document_mock_data.dart';
import 'package:unidoc/models/document_models.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/documents/document_form.dart';
import 'package:unidoc/widgets/documents/document_preview.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Document form type - initially null (no form shown)
  DocumentType? _activeDocumentType;
  
  // Active document for preview
  Document? _selectedDocument;

  // Generated documents
  List<Document> _documents = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadDocuments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Load documents from the data provider
  void _loadDocuments() {
    setState(() {
      _documents = DocumentMockData.getDocuments();
    });
  }

  // Handle document type selection
  void _selectDocumentType(DocumentType type) {
    setState(() {
      _activeDocumentType = type;
      _selectedDocument = null; // Clear any selected document
    });
  }

  // Handle document selection for preview
  void _selectDocument(Document document) {
    setState(() {
      _selectedDocument = document;
      _activeDocumentType = null; // Clear any active document form
    });
  }

  // Clear form and preview
  void _clearAll() {
    setState(() {
      _activeDocumentType = null;
      _selectedDocument = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title
            _buildHeader(textTheme),
            const SizedBox(height: 24),
            
            // Document type tabs
            _buildDocumentTabs(),
            const SizedBox(height: 16),
            
            // Main content area with form and preview
            Expanded(
              child: _buildContentArea(),
            ),
          ],
        ),
      ),
    );
  }

  // Header with title and description
  Widget _buildHeader(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Generator',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Create, view, and manage your service documents and certificates.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.unidocMedium,
              ),
            ),
          ],
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
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                // Share functionality
              },
              icon: const Icon(LucideIcons.share2),
              tooltip: 'Share',
            ),
          ],
        ),
      ],
    );
  }

  // Build document type tabs
  Widget _buildDocumentTabs() {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: _tabController,
              tabs: [
                _buildTab(LucideIcons.fileText, 'Service Call'),
                _buildTab(LucideIcons.fileCheck, 'Delivery Certificate'),
                _buildTab(LucideIcons.fileBarChart, 'Report'),
              ],
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: AppColors.unidocMedium,
              indicatorColor: Theme.of(context).colorScheme.primary,
              onTap: (index) {
                // Clear any active forms or previews when switching tabs
                _clearAll();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build individual tab
  Widget _buildTab(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  // Build main content area with form and preview
  Widget _buildContentArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Form area
        Expanded(
          flex: 3,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadii.mdRadius,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                // Service Call form or document list
                _buildTabContent(
                  activeType: _activeDocumentType,
                  expectedType: DocumentType.serviceCall,
                  documents: _documents.where((doc) => doc.type == DocumentType.serviceCall).toList(),
                  onDocumentSelect: _selectDocument,
                  onCreateNew: () => _selectDocumentType(DocumentType.serviceCall),
                ),
                
                // Delivery Certificate form or document list
                _buildTabContent(
                  activeType: _activeDocumentType,
                  expectedType: DocumentType.deliveryCertificate,
                  documents: _documents.where((doc) => doc.type == DocumentType.deliveryCertificate).toList(),
                  onDocumentSelect: _selectDocument,
                  onCreateNew: () => _selectDocumentType(DocumentType.deliveryCertificate),
                ),
                
                // Report form or document list
                _buildTabContent(
                  activeType: _activeDocumentType,
                  expectedType: DocumentType.report,
                  documents: _documents.where((doc) => doc.type == DocumentType.report).toList(),
                  onDocumentSelect: _selectDocument,
                  onCreateNew: () => _selectDocumentType(DocumentType.report),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Right side - Preview area
        Expanded(
          flex: 2,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadii.mdRadius,
            ),
            child: DocumentPreview(
              document: _selectedDocument,
              documentType: _activeDocumentType,
            ),
          ),
        ),
      ],
    );
  }

  // Build tab content (either form or document list)
  Widget _buildTabContent({
    required DocumentType? activeType,
    required DocumentType expectedType,
    required List<Document> documents,
    required Function(Document) onDocumentSelect,
    required VoidCallback onCreateNew,
  }) {
    // If there's an active document type and it matches this tab, show the form
    if (activeType != null && activeType == expectedType) {
      return DocumentForm(
        documentType: expectedType,
        onCancel: _clearAll,
        onSave: (formData) {
          // In a real app, this would save the document to a backend
          // For now, just clear the form and reload documents
          _clearAll();
          _loadDocuments();
        },
      );
    }
    
    // Otherwise show the document list
    return _buildDocumentList(
      documents: documents,
      onDocumentSelect: onDocumentSelect,
      onCreateNew: onCreateNew,
    );
  }

  // Build document list
  Widget _buildDocumentList({
    required List<Document> documents,
    required Function(Document) onDocumentSelect,
    required VoidCallback onCreateNew,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action bar with search and create button
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search documents...',
                    prefixIcon: const Icon(LucideIcons.search, size: 18),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: AppRadii.mdRadius,
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadii.mdRadius,
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: onCreateNew,
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text('New Document'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Document list
          Expanded(
            child: documents.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: documents.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      return _buildDocumentListItem(document, onDocumentSelect);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Build empty state when no documents are available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.fileX,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No documents found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new document to get started',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Build document list item
  Widget _buildDocumentListItem(Document document, Function(Document) onSelect) {
    return InkWell(
      onTap: () => onSelect(document),
      borderRadius: AppRadii.mdRadius,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: AppRadii.mdRadius,
        ),
        child: Row(
          children: [
            // Document icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: document.statusColor.withOpacity(0.5),
                borderRadius: AppRadii.smRadius,
              ),
              child: Icon(
                document.typeIcon,
                color: document.statusTextColor,
              ),
            ),
            const SizedBox(width: 12),
            
            // Document details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          document.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        document.formattedCreatedAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          document.customerName ?? 'No customer',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: document.statusColor,
                          borderRadius: AppRadii.smRadius,
                        ),
                        child: Text(
                          document.statusDisplayName,
                          style: TextStyle(
                            fontSize: 12,
                            color: document.statusTextColor,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
} 