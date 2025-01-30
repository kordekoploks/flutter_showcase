import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/blocs/account/account_bloc.dart';
import '../../account/account.dart';

class AccountSpinner extends StatefulWidget {
  final Function(String) onClickGroup;
  final String selectedGroup;

  const AccountSpinner({
    super.key,
    required this.onClickGroup,
    required this.selectedGroup,
  }
  );

  @override
  _AccountSpinnerState createState() => _AccountSpinnerState();
}

class _AccountSpinnerState extends State<AccountSpinner> {
  late List<Account> _data;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoaded) {
            setState(() {
              _data.clear();
              _data.addAll(state.data);
            });
          }
        },
        child: buildContent(
            context
        )
    );
  }


  Widget buildContent(BuildContext context) {
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
            "Category",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10,),
          Divider(
            height: 10,
            thickness: 1,
            color: Colors.black12,
          ),
          SizedBox(height: 20),
          ..._data.map((group) {
            bool isSelected = group ==
                widget.selectedGroup; // Use widget.selectedGroup
            return GestureDetector(
              onTap: () {
                widget.onClickGroup(
                    group.name); // Notify the parent about the selection
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  group.name,
                  style: TextStyle(
                      color: isSelected ? vWPrimaryColor : Colors.black26,
                      // Change text color
                      fontWeight: FontWeight.bold,
                      fontSize: 16
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
