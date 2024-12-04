import 'package:eshop/presentation/widgets/menu_item_toggle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../data/models/setting/setting_model.dart';
import '../../../../blocs/setting/setting_bloc.dart';
import '../../outcome_category/RichTextEditor.dart';
import '../../outcome_category/basic_example.dart';
import '../../outcome_category/complex_example.dart';
import '../../outcome_category/events_example.dart';
import '../../outcome_category/range_example.dart';

HtmlEditorController controller = HtmlEditorController();

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
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
  meetings.add(
      Meeting('Conference2 ', startTime, endTime, const Color(0xFF0F8644), false));
  meetings.add(
      Meeting('Conference3', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
