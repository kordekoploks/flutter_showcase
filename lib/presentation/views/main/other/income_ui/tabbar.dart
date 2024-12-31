import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

class CustomTabBar extends StatefulWidget {
  final List<TabItem> tabs;

  const CustomTabBar({Key? key, required this.tabs}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    _tabController.addListener(() {
      // Rebuild the widget when the active tab changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.tabs
                .map(
                  (tab) => GestureDetector(
                onTap: () {
                  // Switch tabs when a card is tapped
                  _tabController.index = widget.tabs.indexOf(tab);
                  setState(() {}); // Rebuild to reflect changes
                },
                child: Container(
                  height: 120,
                  width: 140,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: _tabController.index == widget.tabs.indexOf(tab)
                        ? vWPrimaryColor // Active card background
                        : Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            tab.icon,size: 40,
                            color: _tabController.index == widget.tabs.indexOf(tab)
                                ? Colors.white // Active icon color
                                : Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tab.name,
                            style: TextStyle(
                              color: _tabController.index == widget.tabs.indexOf(tab)
                                  ? Colors.white // Active text color
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
        // Expanded(
        //   child: TabBarView(
        //     controller: _tabController,
        //     children: widget.tabs.map((tab) => tab.content).toList(),
        //   ),

      ],
    );
  }
}

class TabItem {
  final IconData icon;
  final String name;


  TabItem({required this.icon, required this.name});
}
