import 'package:flutter/material.dart';
import 'package:unidoc/models/agreement_models.dart';
import 'package:unidoc/widgets/agreement/agreement_form.dart';

class AgreementCreateDialog extends StatelessWidget {
  final String customerId;
  final String customerName;
  final Agreement? existingAgreement;
  final Function(Agreement) onSave;

  const AgreementCreateDialog({
    Key? key,
    required this.customerId,
    required this.customerName,
    this.existingAgreement,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        width: 900,
        height: 700,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AgreementForm(
          customerId: customerId,
          customerName: customerName,
          existingAgreement: existingAgreement,
          onSave: (agreement) {
            onSave(agreement);
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  // Static method to show the dialog
  static Future<void> show({
    required BuildContext context,
    required String customerId,
    required String customerName,
    Agreement? existingAgreement,
    required Function(Agreement) onSave,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AgreementCreateDialog(
        customerId: customerId,
        customerName: customerName,
        existingAgreement: existingAgreement,
        onSave: onSave,
      ),
    );
  }
} 