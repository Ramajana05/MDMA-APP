import 'package:flutter/material.dart';

class ScannerHelpDialog extends StatefulWidget {
  @override
  _ScannerHelpDialog createState() => _ScannerHelpDialog();
}

class _ScannerHelpDialog extends State<ScannerHelpDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hilfe'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bedeutung der Symbole:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Sensor ID ist bereit zum hinzufügen',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Sensor ID existiert bereits und ist schon aktiv',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(
                  Icons.question_mark_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Sensor ID existiert nicht',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Schließen'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
