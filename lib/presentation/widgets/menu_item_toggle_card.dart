import 'package:flutter/material.dart';

class MenuItemSlideCard extends StatefulWidget {
  final String title;
  final Function(bool)? onToggle;
  final Icon? icon;
  final bool isToggled;

  const MenuItemSlideCard({
    Key? key,
    required this.title,
    this.onToggle,
    this.icon,
    required this.isToggled,
  }) : super(key: key);

  @override
  _MenuItemSlideCardState createState() => _MenuItemSlideCardState();
}

class _MenuItemSlideCardState extends State<MenuItemSlideCard> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.isToggled;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Row(
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: widget.icon,
                ),
              Expanded(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isToggled = !_isToggled;
                  });
                  if (widget.onToggle != null) {
                    widget.onToggle!(_isToggled);
                  }
                },
                child: Icon(
                  _isToggled ? Icons.toggle_on : Icons.toggle_off,
                  color: _isToggled ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
