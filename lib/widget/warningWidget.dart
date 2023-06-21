import 'package:flutter/material.dart';

class WarningWidget extends StatelessWidget {
  final String message;
  final bool isWarnung;
  final Color iconColor;

  WarningWidget({
    required this.message,
    this.isWarnung = true,
    this.iconColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 248, 250, 253);

    Color textColor = const Color.fromARGB(255, 0, 0, 0);
    Color titleColor = isWarnung ? Colors.orange : Colors.blue;

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
          color: Colors.red,
          size: 32.0,
        ),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white, // Set the background color to white
            content: Text(
              'Neuigkeit gelöscht',
              style:
                  TextStyle(color: Colors.black), // Set the text color to black
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 170, 170, 170).withOpacity(0.5),
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
                // Wrap the message text in an Expanded widget
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
