import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceStack {
  final CollectionReference<Map<String, dynamic>> _userAttendanceCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> markAttendance(String studentName) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      CollectionReference<Map<String, dynamic>> userAttendance =
          _userAttendanceCollection.doc(userId).collection('attendance');

      await userAttendance.add({
        'entry': '$studentName marked attendance',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> undoAttendance() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      CollectionReference<Map<String, dynamic>> userAttendance =
          _userAttendanceCollection.doc(userId).collection('attendance');
      QuerySnapshot<Map<String, dynamic>> snapshot = await userAttendance
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String lastDocumentId = snapshot.docs.first.id;
        await userAttendance.doc(lastDocumentId).delete();
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAttendanceHistory() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      CollectionReference<Map<String, dynamic>> userAttendance =
          _userAttendanceCollection.doc(userId).collection('attendance');
      return userAttendance.orderBy('timestamp', descending: true).snapshots();
    } else {
      return Stream.empty();
    }
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceStack _attendanceStack = AttendanceStack();

  String _studentName = '';

  void _markAttendance() async {
    if (_studentName.isNotEmpty) {
      await _attendanceStack.markAttendance(_studentName);
      setState(() {
        _studentName = '';
      });
    }
  }

  void _undoAttendance() async {
    await _attendanceStack.undoAttendance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter student name'),
              onChanged: (value) {
                setState(() {
                  _studentName = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _markAttendance,
              child: Text('Mark Attendance'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _undoAttendance,
              child: Text('Undo Last Attendance'),
            ),
            SizedBox(height: 20),
            Text(
              'Attendance History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _buildAttendanceHistory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceHistory() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _attendanceStack.getAttendanceHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<String> attendanceHistory = snapshot.data!.docs
            .map((document) => document['entry'] as String)
            .toList();

        if (attendanceHistory.isEmpty) {
          return Text('No attendance recorded.');
        } else {
          return ListView(
            children: attendanceHistory
                .map((entry) => _buildHistoryEntry(entry))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildHistoryEntry(String entry) {
    return ListTile(
      title: Text(entry),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AttendanceScreen(),
  ));
}
