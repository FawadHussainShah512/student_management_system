import 'package:flutter/material.dart';

class HolidayScreen extends StatelessWidget {
  static const String routeName = 'HolidayScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays'),
      ),
      body: ListView.builder(
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          return HolidayCard(holiday: holidays[index]);
        },
      ),
    );
  }
}

class HolidayCard extends StatelessWidget {
  final Holiday holiday;

  const HolidayCard({Key? key, required this.holiday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            holiday.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          holiday.name,
          style: TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          holiday.date,
          style: TextStyle(
            color:Colors.black,
          ),
        ),
        onTap: () {
          // Add action to view more details or navigate to a detailed view
          // For example, you can use a dialog or navigate to another screen.
          print('Tapped on holiday: ${holiday.name}');
        },
      ),
    );
  }
}

class Holiday {
  final String name;
  final String date;
  final String imageUrl;

  Holiday({required this.name, required this.date, required this.imageUrl});
}

// Sample holiday data
List<Holiday> holidays = [
  Holiday(name: 'New Year', date: 'January 1', imageUrl: 'https://cdn5.vectorstock.com/i/1000x1000/78/99/people-watching-fireworks-persons-standing-behind-vector-44167899.jpg'),
  Holiday(name: 'Independence Day', date: 'July 4', imageUrl: 'https://i.pinimg.com/originals/e8/de/1b/e8de1b548519d76621ed96efd4410821.jpg'),
  Holiday(name: 'Christmas', date: 'December 25', imageUrl: 'https://i.natgeofe.com/k/dfc7bec2-0657-4887-81a7-6d024a8c3f70/WH-XmasTree_4x3.jpg'),
  // Add more holiday data as needed
];
