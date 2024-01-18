import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const String routeName = '/result';

  // Example result data
  final List<ResultItem> results = [
    ResultItem(subject: 'Math', grade: 'A'),
    ResultItem(subject: 'English', grade: 'B'),
    ResultItem(subject: 'Physics', grade: 'A-'),
    // Add more result items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Result',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the title color
              ),
            ),
            SizedBox(height: 20),
            // Replace this with your actual result content
            buildResultList(),
            SizedBox(height: 20),
            buildTotalGradeAverage(),
          ],
        ),
      ),
    );
  }

  Widget buildResultList() {
    return ListView.builder(
      itemCount: results.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              results[index].subject,
              style: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Grade: ${results[index].grade}',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Customize the text color
            ),),
            leading: CircleAvatar(
              backgroundColor: Colors.blue, // Customize the circle avatar color
              child: Text(
                results[index].grade,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Customize the text color
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTotalGradeAverage() {
    // Calculate total grade average
    double totalGrade = 0.0;
    results.forEach((result) {
      totalGrade += convertGradeToNumeric(result.grade);
    });
    double averageGrade = totalGrade / results.length;

    return Column(
      children: [
        Text(
          'Total Grade Average:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          convertNumericToGrade(averageGrade),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  double convertGradeToNumeric(String grade) {
    // You can customize this method based on your grading system
    switch (grade) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B':
        return 3.0;
    // Add more cases as needed
      default:
        return 0.0; // Default value for unknown grades
    }
  }

  String convertNumericToGrade(double numericGrade) {
    // You can customize this method based on your grading system
    if (numericGrade >= 3.5) {
      return 'A';
    } else if (numericGrade >= 3.0) {
      return 'A-';
    } else if (numericGrade >= 2.0) {
      return 'B';
    } else {
      return 'C'; // Customize for other grade ranges
    }
  }
}

class ResultItem {
  final String subject;
  final String grade;

  ResultItem({required this.subject, required this.grade});
}
