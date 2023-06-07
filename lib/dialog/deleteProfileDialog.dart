import 'package:flutter/material.dart';

class DeleteProfileDialog extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onDeletePressed;

  DeleteProfileDialog({
    required this.onCancelPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account Löschen'),
      content: Text('Wollen Sie Ihren Account wirklich löschen?'),
      actions: [
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            'Abbrechen',
            style: TextStyle(
              color: const Color.fromARGB(255, 39, 39, 39),
            ),
          ),
        ),
        TextButton(
          onPressed: onDeletePressed,
          child: Text(
            'Bestätigen',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}