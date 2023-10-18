import 'package:flashcard/models/question_answer_item.dart';
import 'package:flashcard/screens/play_flashcard.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  // final String title;
  // final List<QuestionAnswerItem> questionList;
  // const PlayFlashcard({Key? key, required this.title, required this.questionList}) : super(key: key);
  final String title;
  final List<QuestionAnswerItem> questionList; // Assuming questionList is a list of Question objects

  QuizResult({required this.title, required this.questionList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            Text(
              '${questionList.length} Questions',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: 140,
              color: Colors.yellow,
            ),
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 20, // Set the desired font size
              ),
            ),
            Text(
              "You answer 8 out of 10 questions correctly!",
              style: TextStyle(
                fontSize: 14, // Set the desired font size
                color: Colors.grey, // Set the desired text color
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    // Handle Retry button click
                    Navigator.of(context).pop(); // Close the loading dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlayFlashcard(title: title, questionList: questionList)),
                    );
                  },
                  child: Text('Retry'),
                ),
                SizedBox(width: 24),
                FilledButton(
                  onPressed: () {
                    // Handle Finish button click
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
