import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerChooseGroup extends StatefulWidget {
  final Function(String) onClickGroup;
  final String selectedGroup;

  const SpinnerChooseGroup({
    super.key,
    required this.onClickGroup,
    required this.selectedGroup,
  });

  @override
  _SpinnerChooseGroupState createState() => _SpinnerChooseGroupState();
}

class _SpinnerChooseGroupState extends State<SpinnerChooseGroup> {
  final List<String> groups = ["Cash", "Account", "Loan"]; // Group options

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Text(
            "Choose Group",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black12,
          ),
          SizedBox(height: 10),
          ...groups.map((group) {
            bool isSelected = group == widget.selectedGroup; // Use widget.selectedGroup
            return GestureDetector(
              onTap: () {
                widget.onClickGroup(group); // Notify the parent about the selection
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.white, // Change background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    group,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey, // Change text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
