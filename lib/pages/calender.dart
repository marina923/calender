import 'package:date/layout/cubit/cubit.dart';
import 'package:date/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    var _elements = <Element>[
      Element(cubit.selectedDate),
      Element(cubit.selectedDate.add(const Duration(days: 1))),
      Element(cubit.selectedDate.add(const Duration(days: 2))),
      Element(cubit.selectedDate.add(const Duration(days: 3))),
      Element(cubit.selectedDate.add(const Duration(days: 4))),
      Element(cubit.selectedDate.add(const Duration(days: 5))),
      Element(cubit.selectedDate.add(const Duration(days: 6))),
      Element(cubit.selectedDate.add(const Duration(days: 7))),
    ];
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableCalendar(
                    pageJumpingEnabled: true,
                    focusedDay: cubit.focusedDate,
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      selectedDecoration: BoxDecoration(
                        color: Colors.deepPurpleAccent.shade100,
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(cubit.selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) =>
                        cubit.changeSelectedDate(selectedDay, focusedDay),
                    daysOfWeekVisible: true,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    firstDay: cubit.first,
                    lastDay: cubit.last,
                    calendarFormat: cubit.format,
                    onFormatChanged: (format) => cubit.changedFormat(format),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: StickyGroupedListView<Element, DateTime>(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemScrollController: cubit.controller,
                      elements: _elements,
                      order: StickyGroupedListOrder.DESC,
                      groupBy: (Element element) =>
                          DateTime(element.date.month, element.date.day),
                      groupComparator: (DateTime value1, DateTime value2) =>
                          value2.compareTo(value1),
                      itemComparator: (Element element1, Element element2) =>
                          element1.date.compareTo(element2.date),
                      floatingHeader: true,
                      groupSeparatorBuilder: (Element element) => SizedBox(
                        height: 40,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEE, MMM d').format(element.date),
                                  textAlign: TextAlign.start,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (_, Element element) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 8.0,
                          ),
                          child: Text('No appointments'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            onPressed: () {},
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}

class Element {
  DateTime date;

  Element(this.date);
}
