import 'package:flashcard/models/question_answer_item.dart';
import 'package:flashcard/screens/quiz_result.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

class PlayFlashcard extends StatefulWidget {
  final String title;
  final List<QuestionAnswerItem> questionList;
  const PlayFlashcard({Key? key, required this.title, required this.questionList}) : super(key: key);

  @override
  _PlayFlashcard createState() => _PlayFlashcard();
}

class _PlayFlashcard extends State<PlayFlashcard> {
  final PageController _controller = PageController();
  List<GlobalKey<FlipCardState>> cardKeys = []; // Add this
  bool _isFront = true;
  int score = 0;

  @override
  void initState() {
    super.initState();
    widget.questionList.shuffle(Random());
    cardKeys = List.generate(widget.questionList.length, (index) => GlobalKey<FlipCardState>()); // Add this
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(), // disable swiping
        itemCount: widget.questionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlipCard(
                      key: cardKeys[index], // Use a unique key for each FlipCard
                      flipOnTouch: false,
                      onFlip: () {
                        setState(() {
                          _isFront = !_isFront;
                        });
                      },
                      front: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text("${index + 1}/${widget.questionList.length} Questions", textAlign: TextAlign.center),
                            ),
                            Container(
                              constraints: BoxConstraints(minHeight: 300),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16.0),
                              child: AutoSizeText(
                                widget.questionList[index].textQuestion,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      back: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text("Correct Answer", textAlign: TextAlign.center),
                            ),
                            Container(
                              constraints: BoxConstraints(minHeight: 300),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16.0),
                              child: AutoSizeText(
                                widget.questionList[index].answer!,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_isFront) ...[
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            cardKeys[index].currentState!.toggleCard();
                          },
                          child: Text('Reveal Answer'),
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle "I got it wrong" press
                              showNextQuestion(0, index);
                            },
                            child: Text('I got it wrong'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle "I got it right" press
                              showNextQuestion(1, index);
                            },
                            child: Text('I got it right'),
                          ),
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showNextQuestion(int isCorrectAnswer, int currentIndex) {
    score += isCorrectAnswer;
    debugPrint("Current Score: ${score}");
    if (currentIndex == widget.questionList.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizResult()), // Replace NewScreen() with your new screen
      );
    } else {
      _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      setState(() {
        _isFront = true;
      });
    }
  }
}
