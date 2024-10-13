import 'package:eshop/presentation/widgets/menu_item_toggle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/setting/setting_model.dart';
import '../../../../blocs/setting/setting_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      bool isDarkModeEnabled =
          state is SettingApplied && state.setting.darkMode;
      return ListView(physics: const BouncingScrollPhysics(), children: [
        const SizedBox(height: 6),
        MenuItemSlideCard(
          title: 'Dark Mode',
          icon: Icon(Icons.settings),
          isToggled: isDarkModeEnabled,
          onToggle: (bool isToggled) {
            context.read<SettingBloc>().add(SaveSetting( SettingModel(darkMode: isToggled)));
            // Add your logic here based on the toggled state
          },
        )
      ]);
    }));
  }
}
