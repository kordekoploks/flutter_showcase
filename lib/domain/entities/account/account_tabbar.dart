import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

class AccountTabBar extends StatefulWidget {
  final List<AccountTabItem> tabs;

  const AccountTabBar({Key? key, required this.tabs}) : super(key: key);

  @override
  State<AccountTabBar> createState() => _AccountTabBarState();
}

class _AccountTabBarState extends State<AccountTabBar> with SingleTickerProviderStateMixin {
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
    return Row( mainAxisAlignment: MainAxisAlignment.center,
      children: widget.tabs
          .map(
            (tab) => GestureDetector(
          onTap: () {
            // Switch tabs when a card is tapped
            _tabController.index = widget.tabs.indexOf(tab);
            setState(() {}); // Rebuild to reflect changes
          },
          child: Container(
            height: 60,
            width: 170,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      tab.name,
                      style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold,
                        color: _tabController.index == widget.tabs.indexOf(tab)
                            ? Colors.white // Active text color
                            : Colors.black26,
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
    );
  }
}

class AccountTabItem {
  final String name;
  // final Widget content;

  AccountTabItem({required this.name});
}