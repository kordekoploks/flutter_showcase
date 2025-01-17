import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerChooseGroup extends StatelessWidget {
  final Function(String) onClickGroup;

  const SpinnerChooseGroup({super.key, required this.onClickGroup});

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
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cash',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
               onClickGroup("Cash");
              },
            ),
          ),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Account',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                onClickGroup("Account");
              },
            ),
          ),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Loan',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                onClickGroup("Loan");
              },
            ),
          ),
        ],
      ),
    );
  }
}
