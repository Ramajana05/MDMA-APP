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
      title: const Text('Account Löschen'),
      content: const Text('Wollen Sie Ihren Account wirklich löschen?'),
      actions: [
        TextButton(
          onPressed: onCancelPressed,
          child: const Text(
            'Abbrechen',
            style: TextStyle(
              color: Color.fromARGB(255, 39, 39, 39),
            ),
          ),
        ),
        TextButton(
          onPressed: onDeletePressed,
          child: const Text(
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
