import 'package:date/layout/cubit/cubit.dart';
import 'package:date/layout/cubit/states.dart';
import 'package:date/pages/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'layout/network/local/cash_helper.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TableCalendar Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Calender(),
          );
        },
      ),
    );
  }
}
