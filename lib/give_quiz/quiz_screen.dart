import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'answerIndex': 2,
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'answerIndex': 1,
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'answerIndex': 1,
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'options': [
        'Charles Dickens',
        'William Shakespeare',
        'Jane Austen',
        'Mark Twain'
      ],
      'answerIndex': 1,
    },
    {
      'question': 'What is the largest mammal?',
      'options': ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
      'answerIndex': 1,
    },
    {
      'question': 'In which year did World War I begin?',
      'options': ['1910', '1925', '1939', '1914'],
      'answerIndex': 3,
    },
    {
      'question': 'What is the capital of Japan?',
      'options': ['Seoul', 'Tokyo', 'Beijing', 'Bangkok'],
      'answerIndex': 1,
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': [
        'Pablo Picasso',
        'Vincent van Gogh',
        'Leonardo da Vinci',
        'Michelangelo'
      ],
      'answerIndex': 2,
    },
    {
      'question': 'What is the currency of Brazil?',
      'options': ['Peso', 'Real', 'Euro', 'Dollar'],
      'answerIndex': 1,
    },
    {
      'question': 'What is the capital of Australia?',
      'options': ['Sydney', 'Canberra', 'Melbourne', 'Brisbane'],
      'answerIndex': 1,
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Column(
              children: List.generate(
                (_questions[_currentQuestionIndex]['options'] as List<String>)
                    .length,
                (index) => RadioListTile<int>(
                  title: Text(
                    (_questions[_currentQuestionIndex]['options']
                        as List<String>)[index],
                    style: TextStyle(fontSize: 18),
                  ),
                  value: index,
                  groupValue: _selectedOptionIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedOptionIndex = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                checkAnswer();
                moveToNextQuestion();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Submit Answer & Next Question',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await submitQuiz();
                showScoreDialog();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Submit Quiz',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> moveToNextQuestion() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Add a delay for better user experience

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex =
            null; // Reset selected option for the next question
      } else {
        showTestFinishDialog();
        return; // Stop further execution
      }
    });
  }

  void checkAnswer() {
    int correctAnswerIndex =
        _questions[_currentQuestionIndex]['answerIndex'] as int;

    if (_selectedOptionIndex != null &&
        _selectedOptionIndex == correctAnswerIndex) {
      setState(() {
        _score++;
      });
    }
  }

  Future<void> submitQuiz() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      CollectionReference userQuizScores = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('quiz');

      await userQuizScores.add({
        'score': _score,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // Reset question status for the next quiz
    setState(() {
      for (var question in _questions) {
        question['answered'] = false; // Set 'answered' to false
      }
    });
  }

  void showScoreDialog() {
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('Your score is $_score'),
            actions: [
              TextButton(
                onPressed: () {
                  restartQuiz();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  void showTestFinishDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Finished'),
          content: Text('Congratulations! You have completed the test.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                submitQuiz(); // Call submitQuiz when Finish is pressed
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  void restartQuiz() {
    setState(() {
      // Reset question status for the next quiz
      for (var question in _questions) {
        question['answered'] = false; // Set 'answered' to false
      }
      _score = 0;
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null; // Initialize _selectedOptionIndex to null
    });
  }
}
