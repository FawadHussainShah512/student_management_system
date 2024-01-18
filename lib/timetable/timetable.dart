import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  static const String routeName = 'TimetableScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Timetable',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Replace this with your actual timetable content
            buildTimetable(),
          ],
        ),
      ),
    );
  }

  Widget buildTimetable() {
    // Replace this with your actual timetable data and UI
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            buildTableCell('Time/Day', isHeader: true),
            buildTableCell('Monday', isHeader: true),
            buildTableCell('Tuesday', isHeader: true),
            buildTableCell('Wednesday', isHeader: true),
            buildTableCell('Thursday', isHeader: true),
            buildTableCell('Friday', isHeader: true),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('8:00 AM'),
            buildTableCell('Math'),
            buildTableCell('History'),
            buildTableCell('Physics'),
            buildTableCell('English'),
            buildTableCell('Chemistry'),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('10:00 AM'),
            buildTableCell('English'),
            buildTableCell('Physics'),
            buildTableCell('Math'),
            buildTableCell('Chemistry'),
            buildTableCell('Biology'),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('10:00 AM'),
            buildTableCell('English'),
            buildTableCell('Physics'),
            buildTableCell('Math'),
            buildTableCell('Chemistry'),
            buildTableCell('Biology'),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('10:00 AM'),
            buildTableCell('English'),
            buildTableCell('Physics'),
            buildTableCell('Math'),
            buildTableCell('Chemistry'),
            buildTableCell('Biology'),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('10:00 AM'),
            buildTableCell('English'),
            buildTableCell('Physics'),
            buildTableCell('Math'),
            buildTableCell('Chemistry'),
            buildTableCell('Biology'),
          ],
        ),
        TableRow(
          children: [
            buildTableCell('10:00 AM'),
            buildTableCell('English'),
            buildTableCell('Physics'),
            buildTableCell('Math'),
            buildTableCell('Chemistry'),
            buildTableCell('Biology'),
          ],
        ),

        // Add more rows as needed
      ],
    );
  }

  Widget buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: isHeader ? Colors.blue : Colors.white,
      child: Text(
        text,
        style: TextStyle(
          fontSize:5,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
