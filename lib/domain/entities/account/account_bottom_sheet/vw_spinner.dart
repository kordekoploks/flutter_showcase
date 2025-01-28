import 'package:flutter/material.dart';

class VwSpinner extends StatefulWidget {
  final String text; // Current selected text
  final String placeholder; // Dynamic placeholder text when no item is chosen
  final String label; // Label for the spinner
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double width;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final Icon arrowIcon;
  final bool isValid; // Validation flag
  final String validationMessage; // Validation message

  const VwSpinner({
    Key? key,
    required this.text,
    this.placeholder = "Select an item", // Default placeholder
    this.label = "",
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 20.0,
    this.height = 60.0,
    this.width = double.infinity,
    this.textStyle = const TextStyle(color: Colors.grey, fontSize: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.arrowIcon = const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
    this.isValid = true,
    this.validationMessage = "Please select an item.",
  }) : super(key: key);

  @override
  _VwSpinnerState createState() => _VwSpinnerState();
}

class _VwSpinnerState extends State<VwSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Fade animation from 0.0 to 1.0
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Slide animation from below (Offset(0, 1)) to above (Offset(0, 0))
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isChosen = widget.text != widget.placeholder; // Check if the text is NOT the placeholder

    // Start the animation when the item is chosen
    if (isChosen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fade and Slide Animation for the label
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.isValid ? widget.borderColor : Colors.red, // Highlight border if invalid
            ),
          ),
          child: Padding(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: widget.textStyle.copyWith(
                    color: widget.isValid ? widget.textStyle.color : Colors.red, // Change text color if invalid
                  ),
                ),
                widget.arrowIcon,
              ],
            ),
          ),
        ),
        if (!widget.isValid) // Show validation message if not valid
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.validationMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
