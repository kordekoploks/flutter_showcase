import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

class ProfileItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final String data;
  final Widget? dataWidget;

  const ProfileItemCard(
      {Key? key,
      required this.title,
      this.onClick,
      required this.data,
      this.dataWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                dataWidget == null
                    ? Text(data,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold))
                    : dataWidget!,

                // const  Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
              ],
            ),
            // Divider(height: 20,
            //   thickness: 1,
            //   indent: 0,
            //   endIndent: 5,
            //   color: Colors.black12,)
          ],
        ),
      ),
    );
  }
}
