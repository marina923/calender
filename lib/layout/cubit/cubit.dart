import 'package:bloc/bloc.dart';
import 'package:date/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  var controller = GroupedItemScrollController();
  void changeSelectedDate(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    focusedDate = focusedDay;
    return emit(SelectedDateState());
  }

  void changedFormat(CalendarFormat cFormat) {
    format = cFormat;
    emit(calenderChangeFormatState());
  }

  //List<DateTime> calender = [];
  DateTime first = DateTime.utc(2010, 1, 1);
  DateTime last = DateTime.utc(2022, 12, 31);
  // void fillCalender() {
  //   while (selectedDate.isBefore(selectedDate.add(Duration(days: 7)))) {
  //     calender.add(selectedDate);
  //   }
  // }
}
