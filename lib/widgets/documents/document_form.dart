import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/document_models.dart';
import 'package:unidoc/theme/app_theme.dart';

class DocumentForm extends StatefulWidget {
  final DocumentType documentType;
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSave;
  final VoidCallback onCancel;

  const DocumentForm({
    super.key,
    required this.documentType,
    this.initialData,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DocumentForm> createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Company information controllers
  final _companyNameController = TextEditingController(text: 'UNIDOC Solutions');
  final _companyAddressController = TextEditingController(text: '123 Business Avenue, Suite 100, Enterprise City');
  final _companyPhoneController = TextEditingController(text: '+1 (555) 123-4567');
  final _companyEmailController = TextEditingController(text: 'service@unidoc.com');
  
  // Customer information controllers
  final _customerNameController = TextEditingController();
  final _customerAddressController = TextEditingController();
  final _customerContactPersonController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerProjectSiteController = TextEditingController();
  
  // Service information controllers
  final _serviceDateController = TextEditingController();
  final _serviceTimeController = TextEditingController();
  final _serviceTypeController = TextEditingController(text: 'Concrete Pumping');
  final _operatorNameController = TextEditingController(text: 'john doe');
  final _serviceHoursController = TextEditingController(text: '4');
  final _notesController = TextEditingController();
  
  // Report specific controllers
  final _reportTitleController = TextEditingController(text: 'Service Activity Report');
  final _reportPeriodController = TextEditingController(text: 'May 2025');
  final _totalServicesController = TextEditingController(text: '15');
  final _completedServicesController = TextEditingController(text: '12');
  final _pendingServicesController = TextEditingController(text: '3');
  final _totalHoursController = TextEditingController(text: '45');
  final _totalAmountController = TextEditingController(text: '5250');
  
  // Material items for Delivery Certificate
  final List<MaterialItem> _materials = [
    MaterialItem(name: 'Concrete Mix', quantity: 5.0, unit: 'tons'),
    MaterialItem(name: 'Reinforcement Steel', quantity: 2.0, unit: 'tons'),
  ];
  
  DateTime _selectedDate = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    
    // Format today's date
    _serviceDateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
    _serviceTimeController.text = '9:00 AM';
    
    // If there is initial data, load it
    if (widget.initialData != null) {
      _loadInitialData();
    }
  }
  
  @override
  void dispose() {
    // Dispose all controllers
    _companyNameController.dispose();
    _companyAddressController.dispose();
    _companyPhoneController.dispose();
    _companyEmailController.dispose();
    
    _customerNameController.dispose();
    _customerAddressController.dispose();
    _customerContactPersonController.dispose();
    _customerPhoneController.dispose();
    _customerEmailController.dispose();
    _customerProjectSiteController.dispose();
    
    _serviceDateController.dispose();
    _serviceTimeController.dispose();
    _serviceTypeController.dispose();
    _operatorNameController.dispose();
    _serviceHoursController.dispose();
    _notesController.dispose();
    
    _reportTitleController.dispose();
    _reportPeriodController.dispose();
    _totalServicesController.dispose();
    _completedServicesController.dispose();
    _pendingServicesController.dispose();
    _totalHoursController.dispose();
    _totalAmountController.dispose();
    
    super.dispose();
  }
  
  // Load initial data if provided
  void _loadInitialData() {
    final data = widget.initialData!;
    
    // TODO: Load data from initialData map into controllers
  }
  
  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2026),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _serviceDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }
  
  // Add a new material item
  void _addMaterialItem() {
    setState(() {
      _materials.add(MaterialItem(name: '', quantity: 0.0));
    });
  }
  
  // Remove a material item
  void _removeMaterialItem(int index) {
    if (_materials.length > 1) {
      setState(() {
        _materials.removeAt(index);
      });
    }
  }
  
  // Update a material item
  void _updateMaterialItem(int index, {String? name, double? quantity, String? unit}) {
    setState(() {
      final item = _materials[index];
      _materials[index] = MaterialItem(
        name: name ?? item.name,
        quantity: quantity ?? item.quantity,
        unit: unit ?? item.unit,
      );
    });
  }
  
  // Save form data
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Create a data map based on document type
      Map<String, dynamic> formData = {};
      
      // Common data for all document types
      formData['companyName'] = _companyNameController.text;
      formData['companyAddress'] = _companyAddressController.text;
      formData['companyPhone'] = _companyPhoneController.text;
      formData['companyEmail'] = _companyEmailController.text;
      
      switch (widget.documentType) {
        case DocumentType.serviceCall:
          formData['documentType'] = 'serviceCall';
          formData['customerName'] = _customerNameController.text;
          formData['customerAddress'] = _customerAddressController.text;
          formData['customerContactPerson'] = _customerContactPersonController.text;
          formData['customerPhone'] = _customerPhoneController.text;
          formData['customerEmail'] = _customerEmailController.text;
          formData['customerProjectSite'] = _customerProjectSiteController.text;
          formData['serviceDate'] = _serviceDateController.text;
          formData['serviceTime'] = _serviceTimeController.text;
          formData['serviceType'] = _serviceTypeController.text;
          formData['operatorName'] = _operatorNameController.text;
          formData['serviceHours'] = int.tryParse(_serviceHoursController.text) ?? 0;
          formData['notes'] = _notesController.text;
          break;
          
        case DocumentType.deliveryCertificate:
          formData['documentType'] = 'deliveryCertificate';
          formData['customerName'] = _customerNameController.text;
          formData['customerAddress'] = _customerAddressController.text;
          formData['customerContactPerson'] = _customerContactPersonController.text;
          formData['customerProjectSite'] = _customerProjectSiteController.text;
          formData['serviceDate'] = _serviceDateController.text;
          formData['serviceType'] = _serviceTypeController.text;
          formData['operatorName'] = _operatorNameController.text;
          formData['serviceHours'] = int.tryParse(_serviceHoursController.text) ?? 0;
          formData['materials'] = _materials.map((item) => {
            'name': item.name,
            'quantity': item.quantity,
            'unit': item.unit,
          }).toList();
          formData['notes'] = _notesController.text;
          break;
          
        case DocumentType.report:
          formData['documentType'] = 'report';
          formData['title'] = _reportTitleController.text;
          formData['reportPeriod'] = _reportPeriodController.text;
          formData['reportDate'] = _serviceDateController.text;
          formData['customerName'] = _customerNameController.text;
          formData['totalServices'] = int.tryParse(_totalServicesController.text) ?? 0;
          formData['completedServices'] = int.tryParse(_completedServicesController.text) ?? 0;
          formData['pendingServices'] = int.tryParse(_pendingServicesController.text) ?? 0;
          formData['totalHours'] = int.tryParse(_totalHoursController.text) ?? 0;
          formData['totalAmount'] = double.tryParse(_totalAmountController.text) ?? 0.0;
          formData['additionalNotes'] = _notesController.text;
          break;
          
        default:
          break;
      }
      
      // Call the onSave callback with the form data
      widget.onSave(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form title and actions
            _buildFormHeader(),
            const SizedBox(height: 16),
            
            // Scrollable form fields
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form fields based on document type
                    _buildFormFields(),
                  ],
                ),
              ),
            ),
            
            // Form actions
            _buildFormActions(),
          ],
        ),
      ),
    );
  }

  // Build form header with title
  Widget _buildFormHeader() {
    String title;
    
    switch (widget.documentType) {
      case DocumentType.serviceCall:
        title = 'Service Call Information';
        break;
      case DocumentType.deliveryCertificate:
        title = 'Delivery Certificate Information';
        break;
      case DocumentType.report:
        title = 'Report Information';
        break;
      default:
        title = 'Document Information';
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: widget.onCancel,
          tooltip: 'Cancel',
        ),
      ],
    );
  }

  // Build form fields based on document type
  Widget _buildFormFields() {
    switch (widget.documentType) {
      case DocumentType.serviceCall:
        return _buildServiceCallForm();
      case DocumentType.deliveryCertificate:
        return _buildDeliveryCertificateForm();
      case DocumentType.report:
        return _buildReportForm();
      default:
        return const SizedBox.shrink();
    }
  }

  // Build service call form fields
  Widget _buildServiceCallForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Company Information'),
        _buildCompanyInformationSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Customer Information'),
        _buildCustomerInformationSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Service Information'),
        _buildServiceInformationSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Notes'),
        _buildNotesSection(),
      ],
    );
  }

  // Build delivery certificate form fields
  Widget _buildDeliveryCertificateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Company Information'),
        _buildCompanyInformationSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Customer Information'),
        _buildCustomerInformationSection(isDelivery: true),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Service Information'),
        _buildServiceInformationSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Materials'),
        _buildMaterialsSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Notes'),
        _buildNotesSection(),
      ],
    );
  }

  // Build report form fields
  Widget _buildReportForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Report Details'),
        _buildReportDetailsSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Report Statistics'),
        _buildReportStatisticsSection(),
        const SizedBox(height: 24),
        
        _buildSectionTitle('Additional Notes'),
        _buildNotesSection(),
      ],
    );
  }

  // Build company information section
  Widget _buildCompanyInformationSection() {
    return Column(
      children: [
        TextFormField(
          controller: _companyNameController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter company name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _companyAddressController,
          decoration: const InputDecoration(
            labelText: 'Company Address',
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _companyPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Company Phone',
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _companyEmailController,
                decoration: const InputDecoration(
                  labelText: 'Company Email',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build customer information section
  Widget _buildCustomerInformationSection({bool isDelivery = false}) {
    return Column(
      children: [
        TextFormField(
          controller: _customerNameController,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
          ),
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _customerAddressController,
          decoration: const InputDecoration(
            labelText: 'Address',
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _customerContactPersonController,
                decoration: const InputDecoration(
                  labelText: 'Contact Person',
                ),
              ),
            ),
            if (!isDelivery) ...[
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _customerPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telephone',
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            if (!isDelivery)
              Expanded(
                child: TextFormField(
                  controller: _customerEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
            if (!isDelivery)
              const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _customerProjectSiteController,
                decoration: const InputDecoration(
                  labelText: 'Project Site',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build service information section
  Widget _buildServiceInformationSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _serviceDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: const Icon(LucideIcons.calendar),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _serviceTimeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g. 9:00 AM',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _serviceTypeController,
                decoration: const InputDecoration(
                  labelText: 'Service Type',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter service type';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _operatorNameController,
                decoration: const InputDecoration(
                  labelText: 'Assigned Operator',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter operator name';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _serviceHoursController,
                decoration: const InputDecoration(
                  labelText: 'Service Hours',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter service hours';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  // Build materials section for delivery certificate
  Widget _buildMaterialsSection() {
    return Column(
      children: [
        // Materials list
        for (int i = 0; i < _materials.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    initialValue: _materials[i].name,
                    decoration: const InputDecoration(
                      labelText: 'Material Name',
                    ),
                    onChanged: (value) => _updateMaterialItem(i, name: value),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter material name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: _materials[i].quantity.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _updateMaterialItem(
                      i,
                      quantity: double.tryParse(value) ?? 0.0,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Required';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _materials[i].unit,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                    ),
                    onChanged: (value) => _updateMaterialItem(i, unit: value),
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.trash2),
                  onPressed: () => _removeMaterialItem(i),
                  tooltip: 'Remove item',
                ),
              ],
            ),
          ),
        
        // Add material button
        OutlinedButton.icon(
          onPressed: _addMaterialItem,
          icon: const Icon(LucideIcons.plus, size: 16),
          label: const Text('Add Material'),
        ),
      ],
    );
  }

  // Build report details section
  Widget _buildReportDetailsSection() {
    return Column(
      children: [
        TextFormField(
          controller: _reportTitleController,
          decoration: const InputDecoration(
            labelText: 'Report Title',
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter report title';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _reportPeriodController,
                decoration: const InputDecoration(
                  labelText: 'Report Period',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter report period';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _serviceDateController,
                decoration: InputDecoration(
                  labelText: 'Report Date',
                  suffixIcon: IconButton(
                    icon: const Icon(LucideIcons.calendar),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _customerNameController,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
            hintText: 'Leave blank for "All Customers"',
          ),
        ),
      ],
    );
  }

  // Build report statistics section
  Widget _buildReportStatisticsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _totalServicesController,
                decoration: const InputDecoration(
                  labelText: 'Total Services',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Required';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _completedServicesController,
                decoration: const InputDecoration(
                  labelText: 'Completed',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Required';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _pendingServicesController,
                decoration: const InputDecoration(
                  labelText: 'Pending',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Required';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _totalHoursController,
                decoration: const InputDecoration(
                  labelText: 'Total Hours',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Required';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _totalAmountController,
                decoration: const InputDecoration(
                  labelText: 'Total Amount (\$)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Required';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build notes section
  Widget _buildNotesSection() {
    return TextFormField(
      controller: _notesController,
      decoration: const InputDecoration(
        labelText: 'Notes',
        hintText: 'Enter any additional information here...',
      ),
      maxLines: 4,
    );
  }

  // Build form actions (save and cancel buttons)
  Widget _buildFormActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: widget.onCancel,
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 16),
        FilledButton(
          onPressed: _saveForm,
          child: const Text('Save'),
        ),
      ],
    );
  }

  // Build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
} 