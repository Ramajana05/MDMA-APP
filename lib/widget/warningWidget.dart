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
    Color backgroundColor = Color.fromARGB(255, 248, 250, 253);
    Color shadowColor = isWarnung
        ? Colors.orange.withOpacity(0.3)
        : Colors.blue.withOpacity(0.3);
    Color textColor = const Color.fromARGB(255, 0, 0, 0);
    Color titleColor = isWarnung ? Colors.orange : Colors.blue;

    IconData iconData =
        isWarnung ? Icons.warning : Icons.notifications_active_outlined;

    return Dismissible(
      key: Key(message),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 32.0,
        ),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Neuigkeit gelöscht")),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
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
              SizedBox(width: 16.0),
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
                    SizedBox(height: 8.0),
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
