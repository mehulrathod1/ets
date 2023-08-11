import 'package:flutter/material.dart';

class DownloadConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  DownloadConfirmationPopup(
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
          child: Text('Download'),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
