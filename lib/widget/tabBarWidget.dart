import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class TabBarWidget extends StatefulWidget {
  final List<String> tabTexts;
  final Color labelColor;
  final Color indicatorColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final Function(int) onTabSelected; // Add this line

  const TabBarWidget({
    Key? key,
    required this.tabTexts,
    this.labelColor = primaryAppLightGreen,
    this.unselectedLabelColor = primaryUnselectedLabelColor,
    this.indicatorColor = primaryAppLightGreen,
    this.labelStyle = const TextStyle(fontWeight: FontWeight.bold),
    required this.onTabSelected, // Add this line
  }) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabTexts.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        widget
            .onTabSelected(_tabController.index); // Call the callback function
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showTabMessage(int tabIndex) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tab ${tabIndex + 1} pressed'),
      duration: Duration(seconds: 2),
    ));
    //refreshMarkers
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      // Wrap TabBar with Material
      elevation: 2, // Apply desired elevation for shadow effect
      child: Container(
        decoration: BoxDecoration(
          color: background,
        ),
        child: TabBar(
          controller: _tabController,
          isScrollable: false,
          labelColor: widget.labelColor,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.indicatorColor, // Use desired indicator color
                width: 2.0, // Use desired indicator thickness
              ),
            ),
          ),
          unselectedLabelColor: widget.unselectedLabelColor,
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth / (6 * widget.tabTexts.length),
          ),
          tabs: List.generate(
            widget.tabTexts.length,
            (index) => GestureDetector(
              onTap: () {
                widget.onTabSelected(index); // Call the callback function
                _tabController.index = index;
              },
              child: Tab(
                child: Text(
                  widget.tabTexts[index],
                  style: TextStyle(
                    fontSize: 19,
                  ), // Increase the font size as desired
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
