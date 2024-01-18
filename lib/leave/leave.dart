import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../utils/utils.dart';

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future sendEmail() async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_sb7bhog";
  const templateId = "template_pmvkhhi";
  const userId = "1ao6Q1MqN26uuay03";

  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text,
        }
      }));

  if (response.statusCode == 200) {
    Utils.toastMessageS("Email Sent Successfully");

    // After sending the email, store additional details in Firestore
    await storeLeaveDetails(); // Modified to store leave details
  } else {
    Utils.toastMessageF("Error! Something wrong, try again");
  }

  return response.statusCode;
}

// Modify the method to store leave details as a subcollection
Future<void> storeLeaveDetails() async {
  // Get the current user ID (you may need to use your authentication logic)
  String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

  if (userId.isNotEmpty) {
    // Access the Firestore document for the user
    DocumentReference userDocument =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Access the subcollection 'leave' for the user
    CollectionReference leaveDetails = userDocument.collection('leave');

    // Add a new document with a generated ID
    await leaveDetails.add({
      'name': nameController.text,
      'subject': subjectController.text,
      'email': emailController.text,
      'message': messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class LeaveApplicationScreen extends StatefulWidget {
  static const String routeName = 'LeaveApplicationScreen';
  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.withOpacity(0.8), Colors.black],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 120),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be valid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            labelText: tFullName,
                            hintText: tFullName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        TextFormField(
                          controller: subjectController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 2) {
                              return 'Subject must be valid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                            labelText: "Subject",
                            hintText: "Subject",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            bool _isEmailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value!);
                            if (!_isEmailValid) {
                              return 'Invalid email.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: tEmail,
                            hintText: tEmail,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        TextFormField(
                          controller: messageController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 5) {
                              return 'Message must be valid';
                            }
                            return null;
                          },
                          minLines: 1,
                          maxLines: 100,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Message",
                            hintText: "Kindly enter your message",
                            contentPadding: EdgeInsets.fromLTRB(15, 90, 10, 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 10),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                int code = await sendEmail();
                              }
                            },
                            child: Text(
                              "Send".toUpperCase(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
