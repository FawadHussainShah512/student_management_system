import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../add_note/home_screen.dart';
import '../../ask/ask.dart';
import '../../assignment_screen/assignment_screen.dart';
import '../../attendance/attendace_screen.dart';
import '../../change_password/change_password.dart';
import '../../datesheet_screen/datesheet_screen.dart';
import '../../event/event.dart';
import '../../fee_screen/fee_screen.dart';
import '../../give_quiz/quiz_screen.dart';
import '../../holiday/holiday.dart';
import '../../leave/leave.dart';
import '../../login/login_screen.dart';
import '../../result/result.dart';
import '../../timetable/timetable.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = 'MainMenuScreen';
  var height, width;

  List<String> imgData = [
    "lib/Main_menu/images/quiz.png",
    "lib/Main_menu/images/assignment.png",
    "lib/Main_menu/images/holiday.png",
    "lib/Main_menu/images/timetable.png",
    "lib/Main_menu/images/result.png",
    "lib/Main_menu/images/datesheet.png",
    "lib/Main_menu/images/ask.png",
    "lib/Main_menu/images/fee.png",
    "lib/Main_menu/images/resume.png",
    "lib/Main_menu/images/lock.png",
    "lib/Main_menu/images/event.png",
    "lib/Main_menu/images/logout.png",
    "lib/Main_menu/images/event.png",
    "lib/Main_menu/images/resume.png",
  ];

  List<String> titles = [
    "Take Quiz",
    "Assignments",
    "Holidays",
    "Time Table",
    "Result",
    "DateSheet",
    "Ask",
    "Fee",
    "Leave Application",
    "Change Password",
    "Events",
    "Logout",
    "Attendance",
    "Add Notes",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.blue,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.2, // Adjust the height as needed
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'lib/Main_menu/animation/animation.json', // Replace with your Lottie asset file path
                    width: 120, // Adjust the width as needed
                    height: 120, // Adjust the height as needed
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Main Menu Screen",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.all(20), // Adjust padding as needed
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > height
                        ? 4
                        : 2, // Change the number of columns based on orientation
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: imgData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        // Navigate to a different page based on the index
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Quiz(),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssignmentScreen(),
                              ),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HolidayScreen(),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TimetableScreen(),
                              ),
                            );
                            break;

                          case 4:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(),
                              ),
                            );
                            break;
                          case 5:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DateSheetScreen(),
                              ),
                            );
                            break;
                          case 6:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QueryScreen(),
                              ),
                            );
                            break;
                          case 7:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeeScreen(),
                              ),
                            );
                            break;
                          case 8:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveApplicationScreen(),
                              ),
                            );
                            break;

                          case 9:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(),
                              ),
                            );
                            break;

                          case 10:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventScreen(),
                              ),
                            );
                            break;

                          case 11:
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                            break;

                          case 12:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendanceScreen(),
                              ),
                            );
                            break;

                          case 13:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home_Screen(),
                              ),
                            );
                            break;

                          default:
                            break;
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getRandomColor(),
                              ),
                              child: Center(
                                child: Image.asset(
                                  imgData[index],
                                  width: 50, // Adjust the image size as needed
                                ),
                              ),
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
      Colors.yellow.shade100,
    ];
    return colors[DateTime.now().microsecondsSinceEpoch % colors.length];
  }
}
