import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';

class HelpListItemWidget extends StatefulWidget {
  final String title;
  final bool expanded;
  final VoidCallback onTap;
  final bool alignLeft;
  final String description;
  final IconData icon;
  final Color iconColor; // New property for icon color

  HelpListItemWidget({
    required this.title,
    required this.expanded,
    required this.onTap,
    required this.alignLeft,
    required this.description,
    required this.icon,
    required this.iconColor, // Initialize icon color
  });

  @override
  _HelpListItemWidgetState createState() => _HelpListItemWidgetState();
}

class _HelpListItemWidgetState extends State<HelpListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: background,
      elevation: 6,
      shadowColor: black54,
      child: InkWell(
        onTap: widget.onTap, // Pass the onTap callback to the InkWell
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: widget.onTap,
              title: Row(
                children: [
                  Expanded(
                    flex: widget.alignLeft ? 5 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                widget.icon,
                                size: 30,
                                color: widget.iconColor, // Set icon color
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: widget.alignLeft ? 3 : 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          widget.expanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 36,
                          color: textInverted,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.expanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 22, color: textColor),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
