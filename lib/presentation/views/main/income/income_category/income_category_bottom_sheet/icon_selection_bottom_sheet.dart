import 'package:eshop/domain/entities/image/IconSelection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/images.dart';
import '../../../../../widgets/VwFilterTextField.dart';
import '../../../../../widgets/alert_card.dart';
import 'icon_helper.dart';
import 'icon_item_card.dart';

class IconSelectionBottomSheet extends StatefulWidget{
  final IconSelection defaultIcon;
  final ValueChanged<IconSelection>? onIconSelection;

  const IconSelectionBottomSheet({
    Key? key,
    required this.defaultIcon,
    this.onIconSelection,
    }) : super(key: key);

    @override
    _IconSelectionBottomSheetState createState() => _IconSelectionBottomSheetState();
}

class _IconSelectionBottomSheetState extends State<IconSelectionBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<IconSelection> _listIcon = IconHelper.listIcon();
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 75,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Icon",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20.0),
            GridView.builder(
              shrinkWrap: true, // Ensures it does not take infinite height
              physics: BouncingScrollPhysics(), // Prevents scrolling inside bottom sheet
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _listIcon.length,
              itemBuilder: (context, index) {
                return _buildIconItemCard(context, _listIcon[index], index);
              },
            )
            // Display the custom content here
          ],
        ),
      ),
    );
    }



  void _emptyIcon() {
    setState(() {
      _listIcon.clear();
    });
  }
  Widget _buildIconContent() {
      // Use FutureBuilder to ensure AnimatedList is built after setState() is called
      return FutureBuilder(
        future: Future.delayed(Duration.zero),
        // Delays the build to ensure proper rendering
        builder: (context, snapshot) {
          return SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _listIcon.length,
              itemBuilder: (context, index) {
                final icon = _listIcon[index];
                return _buildIconItemCard(
                  context,
                  icon,
                  index,
                );
              },
            ),
          );

        },
      );
  }

  Widget _buildIconItemCard(BuildContext context, IconSelection defaultIcon, int index) {
    return IconItemCard(
      listIcon: defaultIcon,
      index: index,
      onTap: () {
        widget.onIconSelection?.call(defaultIcon);
        Navigator.pop(context);
      },
      onAnimationEnd: () {
        setState(() {
          _listIcon[index] = _listIcon[index].copyWith(isUpdated: false);
        });
      },
    );
  }


  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "Account not found!",
    );
  }

}