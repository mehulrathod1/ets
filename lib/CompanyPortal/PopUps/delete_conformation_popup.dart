import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  ConfirmationPopup(
      {required this.title, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

// Example usage
void showConfirmationPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationPopup(
        title: 'Confirmation',
        message: 'Are you sure you want to delete?',
        onConfirm: () {
          // Perform delete operation here
          Navigator.of(context).pop(); // Close the dialog
        },
      );
    },
  );
}
