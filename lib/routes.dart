import 'package:flutter/cupertino.dart';
import 'package:student_management_system/login/login_screen.dart';
import 'package:student_management_system/login/signup_screen.dart';
import 'package:student_management_system/result/result.dart';
import 'package:student_management_system/timetable/timetable.dart';

import 'Main_menu/screens/main_menu.dart';
import 'Quiz/screens/welcome/welcome_screen.dart';
import 'ask/ask.dart';
import 'assignment_screen/assignment_screen.dart';
import 'change_password/change_password.dart';
import 'datesheet_screen/datesheet_screen.dart';
import 'event/event.dart';
import 'fee_screen/fee_screen.dart';
import 'holiday/holiday.dart';
import 'leave/leave.dart';

Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  LoginScreen.routeName: (context) => LoginScreen(),

  FeeScreen.routeName: (context) => FeeScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  MainMenuScreen.routeName: (context) => MainMenuScreen(),
  HolidayScreen.routeName: (context) => HolidayScreen(),
  TimetableScreen.routeName: (context) => TimetableScreen(),
  ResultScreen.routeName: (context) => ResultScreen(),
  QueryScreen.routeName: (context) => QueryScreen(),
  LeaveApplicationScreen.routeName: (context) => LeaveApplicationScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  EventScreen.routeName: (context) => EventScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
};
