import 'package:flutter/material.dart';
import 'package:unidoc/models/agreement_models.dart';
import 'package:unidoc/dummy/agreement_mock_data.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AgreementForm extends StatefulWidget {
  final String customerId;
  final String customerName;
  final Agreement? existingAgreement;
  final Function(Agreement) onSave;
  final VoidCallback? onCancel;

  const AgreementForm({
    Key? key,
    required this.customerId,
    required this.customerName,
    this.existingAgreement,
    required this.onSave,
    this.onCancel,
  }) : super(key: key);

  @override
  State<AgreementForm> createState() => _AgreementFormState();
}

class _AgreementFormState extends State<AgreementForm> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  
  // Form fields
  String _agreementType = 'standard';
  DateTime _effectiveDate = DateTime.now();
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 365));
  List<AgreementItem> _items = [];
  double _totalValue = 0.0;
  
  // Selected template
  AgreementTemplate? _selectedTemplate;
  final List<AgreementTemplate> _templates = [];
  
  // UI states
  int _currentStep = 0;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    // Load templates and initialize form
    _loadData();
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }
  
  // Load templates and existing agreement data if editing
  void _loadData() {
    setState(() => _isLoading = true);
    
    // Load templates (in a real app, this would be an API call)
    _templates.addAll(AgreementMockData.getTemplates());
    
    // If editing an existing agreement, populate form fields
    if (widget.existingAgreement != null) {
      final agreement = widget.existingAgreement!;
      
      _titleController.text = agreement.title;
      _notesController.text = agreement.notes ?? '';
      _agreementType = agreement.type;
      _effectiveDate = agreement.effectiveDate;
      _expirationDate = agreement.expirationDate;
      
      if (agreement.items != null) {
        _items = List.from(agreement.items!);
        _calculateTotal();
      }
    } else {
      // For new agreements, use the first template as default
      if (_templates.isNotEmpty) {
        _selectedTemplate = _templates.first;
        _titleController.text = '${widget.customerName} - ${_selectedTemplate!.name}';
      }
    }
    
    setState(() => _isLoading = false);
  }
  
  // Apply template
  void _applyTemplate(AgreementTemplate template) {
    setState(() {
      _selectedTemplate = template;
      _titleController.text = '${widget.customerName} - ${template.name}';
      
      // Create items from template
      _items = template.items.map((itemTemplate) => AgreementItem(
        id: 'new-${DateTime.now().millisecondsSinceEpoch}-${_items.length}',
        description: itemTemplate.description,
        productCode: itemTemplate.productCode,
        unitPrice: itemTemplate.defaultUnitPrice,
        quantity: 1.0,
        unit: itemTemplate.unit,
        tax: itemTemplate.defaultTax,
      )).toList();
      
      _calculateTotal();
    });
  }
  
  // Add new item
  void _addItem() {
    setState(() {
      _items.add(AgreementItem(
        id: 'new-${DateTime.now().millisecondsSinceEpoch}',
        description: 'New Item',
        unitPrice: 0.0,
        quantity: 1.0,
      ));
      _calculateTotal();
    });
  }
  
  // Update item
  void _updateItem(int index, AgreementItem updatedItem) {
    setState(() {
      _items[index] = updatedItem;
      _calculateTotal();
    });
  }
  
  // Remove item
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      _calculateTotal();
    });
  }
  
  // Calculate total value
  void _calculateTotal() {
    double total = 0.0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    setState(() => _totalValue = total);
  }
  
  // Save form
  void _saveAgreement() {
    if (_formKey.currentState!.validate()) {
      // Create new agreement object
      final agreement = Agreement(
        id: widget.existingAgreement?.id ?? 'agr-${DateTime.now().millisecondsSinceEpoch}',
        customerId: widget.customerId,
        customerName: widget.customerName,
        title: _titleController.text,
        status: widget.existingAgreement?.status ?? 'draft',
        type: _agreementType,
        createdAt: widget.existingAgreement?.createdAt ?? DateTime.now(),
        effectiveDate: _effectiveDate,
        expirationDate: _expirationDate,
        value: _totalValue,
        items: _items,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        createdBy: widget.existingAgreement?.createdBy ?? 'current-user',
      );
      
      // Call the save callback
      widget.onSave(agreement);
    }
  }
  
  // Continue to next step
  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }
  
  // Go back to previous step
  void _prevStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: _buildStepper(),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }
  
  // Form header
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.clipboardList, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Text(
            widget.existingAgreement == null ? 'New Agreement' : 'Edit Agreement',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.onCancel,
            tooltip: 'Cancel',
          ),
        ],
      ),
    );
  }
  
  // Stepper for multi-step form
  Widget _buildStepper() {
    return Stepper(
      currentStep: _currentStep,
      onStepTapped: (step) => setState(() => _currentStep = step),
      controlsBuilder: (context, details) => const SizedBox.shrink(),
      steps: [
        // Step 1: Basic Information
        Step(
          title: const Text('Basic Information'),
          subtitle: const Text('Agreement details and dates'),
          content: _buildBasicInfoForm(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        // Step 2: Items and Pricing
        Step(
          title: const Text('Items and Pricing'),
          subtitle: const Text('Add products and services'),
          content: _buildItemsForm(),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        // Step 3: Review
        Step(
          title: const Text('Review and Save'),
          subtitle: const Text('Finalize the agreement'),
          content: _buildReviewForm(),
          isActive: _currentStep >= 2,
          state: StepState.indexed,
        ),
      ],
    );
  }
  
  // Footer with navigation buttons
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentStep > 0)
            OutlinedButton(
              onPressed: _prevStep,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Previous'),
            ),
          const SizedBox(width: 12),
          _currentStep < 2
              ? FilledButton(
                  onPressed: _nextStep,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Next'),
                )
              : FilledButton(
                  onPressed: _saveAgreement,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Save Agreement'),
                ),
        ],
      ),
    );
  }
  
  // Basic information form
  Widget _buildBasicInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Agreement Title
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Agreement Title*',
            hintText: 'Enter a title for this agreement',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an agreement title';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        
        // Agreement Type
        DropdownButtonFormField<String>(
          value: _agreementType,
          decoration: const InputDecoration(
            labelText: 'Agreement Type*',
          ),
          items: const [
            DropdownMenuItem(value: 'standard', child: Text('Standard')),
            DropdownMenuItem(value: 'premium', child: Text('Premium')),
            DropdownMenuItem(value: 'custom', child: Text('Custom')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _agreementType = value);
            }
          },
        ),
        const SizedBox(height: 24),
        
        // Effective Date
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _effectiveDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (date != null) {
                    setState(() => _effectiveDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Effective Date*',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('MM/dd/yyyy').format(_effectiveDate)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _expirationDate,
                    firstDate: _effectiveDate,
                    lastDate: _effectiveDate.add(const Duration(days: 365 * 10)),
                  );
                  if (date != null) {
                    setState(() => _expirationDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Expiration Date*',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('MM/dd/yyyy').format(_expirationDate)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Agreement Duration
        Text(
          'Duration: ${(_expirationDate.difference(_effectiveDate).inDays / 30).round()} months',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        
        // Notes
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Optional notes about this agreement',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  // Items and pricing form
  Widget _buildItemsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Template selection
        if (_templates.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a Template',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<AgreementTemplate>(
                value: _selectedTemplate,
                decoration: const InputDecoration(
                  labelText: 'Agreement Template',
                ),
                items: _templates.map((template) => DropdownMenuItem<AgreementTemplate>(
                  value: template,
                  child: Text(template.name),
                )).toList(),
                onChanged: (template) {
                  if (template != null) {
                    _applyTemplate(template);
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        
        // Items header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Agreement Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Items list
        if (_items.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(LucideIcons.shoppingCart, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'No items added yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items or select a template to get started',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => _buildItemTile(index, _items[index]),
          ),
        
        const SizedBox(height: 16),
        
        // Total value
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Agreement Value:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$${_totalValue.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Individual item editor
  Widget _buildItemTile(int index, AgreementItem item) {
    final descController = TextEditingController(text: item.description);
    final priceController = TextEditingController(text: item.unitPrice.toString());
    final qtyController = TextEditingController(text: item.quantity.toString());
    
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red.shade400, size: 20),
                  onPressed: () => _removeItem(index),
                  tooltip: 'Remove Item',
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Description*',
                isDense: true,
              ),
              onChanged: (value) {
                _updateItem(index, item.copyWith(description: value, unitPrice:  item.unitPrice, quantity: item.quantity));
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Unit Price*',
                      prefixText: '\$',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final price = double.tryParse(value) ?? 0.0;
                      _updateItem(index, item.copyWith(unitPrice: price, quantity: item.unitPrice, description: ''));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: qtyController,
                    decoration: InputDecoration(
                      labelText: 'Quantity*',
                      suffixText: item.unit ?? 'unit',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final qty = double.tryParse(value) ?? 0.0;
                      _updateItem(index, item.copyWith(quantity: qty, unitPrice: item.unitPrice, description: ''));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
  
  // Review form
  Widget _buildReviewForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Agreement Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        
        // Basic information summary
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.info, size: 18, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Agreement Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() => _currentStep = 0),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const Divider(),
                _buildReviewRow('Customer', widget.customerName),
                _buildReviewRow('Agreement Title', _titleController.text),
                _buildReviewRow('Agreement Type', _agreementType.toUpperCase()),
                _buildReviewRow('Effective Date', DateFormat('MM/dd/yyyy').format(_effectiveDate)),
                _buildReviewRow('Expiration Date', DateFormat('MM/dd/yyyy').format(_expirationDate)),
                _buildReviewRow('Duration', '${(_expirationDate.difference(_effectiveDate).inDays / 30).round()} months'),
                if (_notesController.text.isNotEmpty)
                  _buildReviewRow('Notes', _notesController.text),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Items summary
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.shoppingCart, size: 18, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Agreement Items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() => _currentStep = 1),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const Divider(),
                for (int i = 0; i < _items.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(_items[i].description),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${_items[i].quantity} ${_items[i].unit ?? 'unit'}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '\$${_items[i].unitPrice.toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '\$${_items[i].totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Agreement Value:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '\$${_totalValue.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Legal disclaimer
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.fileText, size: 18, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Legal Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'By saving this agreement, you confirm that all information is accurate and complete. '
                'This agreement will be sent to the customer for review and signature.',
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Helper to create review rows
  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: value.length > 50 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
} 