import 'package:eshop/core/constant/colors.dart';
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
      height: 280,
      width: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Choose Group",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
          SizedBox(height: 10,),
          Divider(
            height: 10,
            thickness: 1,
            color: Colors.black12,
          ),
          SizedBox(height: 20),
          ...groups.map((group) {
            bool isSelected = group == widget.selectedGroup; // Use widget.selectedGroup
            return GestureDetector(
              onTap: () {
                widget.onClickGroup(group); // Notify the parent about the selection
              },
              child: Container(padding: EdgeInsets.all(10),
                child: Text(
                  group,
                  style: TextStyle(
                    color: isSelected ? vWPrimaryColor : Colors.black26, // Change text color
                    fontWeight: FontWeight.bold,fontSize: 16
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
