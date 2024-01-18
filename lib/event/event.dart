import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  static const String routeName = '/events';

  // Example event data
  final List<EventItem> events = [
    EventItem(
      title: 'Music Festival',
      date: 'May 15, 2023',
      imageUrl:
          'https://uncoverasia.com/wp-content/uploads/2018/12/Guide-to-Music-Festivals-in-Southeast-Asia_Good-Vibes-Festival.jpg',
    ),
    EventItem(
      title: 'Art Exhibition',
      date: 'June 10, 2023',
      imageUrl:
          'https://images.hindustantimes.com/img/2021/03/06/1600x900/pjimage_-_2021-03-06T192427.069_1615038899966_1615038907778.jpg',
    ),
    EventItem(
      title: 'Science Fair',
      date: 'July 5, 2023',
      imageUrl:
          'https://images.ctfassets.net/cnu0m8re1exe/4RVb4XzCDzGcfVzsqeVKXc/8448619993a22dce73eddad2f0924d72/Intel-2018-ISEF-4-1024x606.jpg',
    ),
    // Add more event items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Customize the title color
                ),
              ),
              SizedBox(height: 20),
              // Replace this with your actual event content
              buildEventList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventList() {
    return ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(events[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      events[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Customize the text color
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Date: ${events[index].date}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EventItem {
  final String title;
  final String date;
  final String imageUrl;

  EventItem({required this.title, required this.date, required this.imageUrl});
}
