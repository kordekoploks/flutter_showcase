import 'package:eshop/data/models/account/account_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/images.dart';
import '../../../../../../domain/entities/image/IconSelection.dart';

class IconHelper {
  static const IconSelection defaultIcon =
  IconSelection(id: "1", name: "User", icon: Icons.person);
  static const IconSelection moneyIcon =
  IconSelection(id: "2", name: "Money Icon",icon: Icons.money);
  static const IconSelection userIcon =
  IconSelection(id: "3", name: "User Icon",icon: Icons.person);
  static const IconSelection addIcon =
  IconSelection(id: "4", name: "Add Icon",icon: Icons.add);
  static const IconSelection defaultIcons =
  IconSelection(id: "5", name: "User Person", icon: Icons.person);
  static const IconSelection moneyIcons =
  IconSelection(id: "6", name: "Money Icons",icon: Icons.money);
  static const IconSelection userIcons =
  IconSelection(id: "7", name: "User Icons",icon: Icons.person);
  static const IconSelection addIcons =
  IconSelection(id: "8", name: "Adds Icon",icon: Icons.add);
  static const IconSelection settingIcon =
  IconSelection(id: "9", name: "Setting Icon",icon: Icons.settings);

  static List<IconSelection> listIcon() {
    return <IconSelection>[
      defaultIcon,
      moneyIcon,
      userIcon,
      addIcon,
      defaultIcons,
      moneyIcons,
      userIcons,
      addIcons,
      settingIcon,
    ].toList(); // Ensures it is growable
  }

}
