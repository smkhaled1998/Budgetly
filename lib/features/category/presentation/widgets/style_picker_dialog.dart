import 'package:flutter/material.dart';

class StylePickerDialog extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback? onConfirm;

  const StylePickerDialog({
    Key? key,
    required this.child,
    required this.title,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            child,
            const SizedBox(height: 24),
            if (onConfirm != null)
              ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Confirm"),
              ),
          ],
        ),
      ),
    );
  }
}