import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/colors/appColors.dart';

class HelpListItemWidget extends StatefulWidget {
  final String title;
  final bool expanded;
  final VoidCallback onTap;
  final bool alignLeft;
  final String description;
  final String section;
  final IconData icon;
  final Color iconColor;

  HelpListItemWidget({
    required this.title,
    required this.expanded,
    required this.onTap,
    required this.alignLeft,
    required this.description,
    required this.section,
    required this.icon,
    required this.iconColor,
  });

  @override
  _HelpListItemWidgetState createState() => _HelpListItemWidgetState();
}

class _HelpListItemWidgetState extends State<HelpListItemWidget> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: background,
      elevation: 6,
      shadowColor: Colors.black54,
      child: InkWell(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
          widget.onTap(); // Call the onTap callback provided by the parent
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
                widget
                    .onTap(); // Call the onTap callback provided by the parent
              },
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
                                color: widget.iconColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: black),
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
                          _expanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 36,
                          color: black,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 21, color: black),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
