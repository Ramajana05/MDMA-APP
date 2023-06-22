import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';

class WarningWidget extends StatelessWidget {
  final String message;
  final bool isWarnung;
  final Color iconColor;

  WarningWidget({
    required this.message,
    this.isWarnung = true,
    this.iconColor = yellow,
  });

  @override
  Widget build(BuildContext context) {
    Color titleColor = isWarnung ? orange : blue;

    IconData iconData =
        isWarnung ? Icons.warning : Icons.notifications_active_outlined;

    return Dismissible(
      key: Key(message),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(
          Icons.delete_outline,
          color: red,
          size: 32.0,
        ),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: background,
            content: Text(
              'Neuigkeit gelöscht',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: background, // Set the background color
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: warningGrey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 32.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isWarnung ? "Warnung" : "Neuigkeit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      message,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
