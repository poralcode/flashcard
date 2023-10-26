import 'package:flashcard/models/question_answer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services library for input formatters
import 'package:flashcard/screens/new_question.dart';

class NewFlashcard extends StatefulWidget {
  final bool isEdit;
  final int position;
  final String title;
  final List<QuestionAnswerItem> questionList;
  const NewFlashcard({Key? key, required this.isEdit, required this.title, required this.questionList, required this.position}) : super(key: key);

  @override
  _NewFlashcardState createState() => _NewFlashcardState();
}

class _NewFlashcardState extends State<NewFlashcard> {
  final titleController = TextEditingController();
  final numberController = TextEditingController();
  String? errorTitle;
  String? errorQuestionTotal;
  bool showMessage = false; //Track if showing the title set message.
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    // Initialize the titleController with the value of 'title'.
    titleController.text = widget.title;
    numberController.text = widget.questionList.length > 0 ? widget.questionList.length.toString() : '';
  }

  @override
  void dispose() {
    titleController.dispose(); // Dispose the controller to free resources
    numberController.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit Flashcard' : 'New Flashcard',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (_controller.page == 1.0) {
              _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
              return false;
            }
            return true;
          },
          child: PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(), // disable swiping
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            TextField(
                              key: Key('title_textfield'),
                              controller: titleController,
                              autofocus: true,
                              maxLength: 150,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                hintText: 'e.g. Medical Equipments',
                                hintStyle: TextStyle(color: Colors.grey),
                                helperText: 'Add a meaningful title for this flashcard.',
                                border: OutlineInputBorder(),
                                errorText: errorTitle,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    titleController.clear();
                                    setState(() {
                                      errorTitle = null;
                                    });
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                              ),
                              onChanged: (value) {
                                validateTitle(value);
                              },
                            ),
                            SizedBox(height: 25),

                            // Number input field with input formatter
                            TextFormField(
                              key: Key('number_input'),
                              controller: numberController,
                              maxLength: 2,
                              keyboardType: TextInputType.number, // Set input type to number
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly // Allow only digits
                              ],
                              decoration: InputDecoration(
                                labelText: 'Total number of questions',
                                hintText: 'Enter a number',
                                errorText: errorQuestionTotal,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                validateTotalNumber(value);
                              },
                            ),

                            SizedBox(height: 16),

                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton(
                                onPressed: () {
                                  validateTitle(titleController.text);
                                  validateTotalNumber(numberController.text);
                                  //Assuming there are no more errors, we will now proceed showing the new screen.
                                  if (errorTitle == null && errorQuestionTotal == null) {
                                    if (int.parse(numberController.text) < widget.questionList.length) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Reduce number of questions'),
                                            content: Text('This will reduce the number of questions to ${numberController.text}. Do you really want to do this?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => NewQuestion(
                                                              isEdit: widget.isEdit,
                                                              title: titleController.text,
                                                              totalQuestions: int.tryParse(numberController.text),
                                                              questionList: widget.questionList,
                                                              position: widget.position,
                                                            )),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                                    }
                                  }
                                },
                                child: Text("Continue"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 140,
                              color: Colors.deepPurple,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'The title is set',
                              style: TextStyle(
                                fontSize: 20, // Set the desired font size
                              ),
                            ),
                            Text(
                              "Let's now create the questions and answers.",
                              style: TextStyle(
                                fontSize: 14, // Set the desired font size
                                color: Colors.grey, // Set the desired text color
                              ),
                            ),
                            SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus(); // This should hide the Keyboard.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewQuestion(
                                              isEdit: widget.isEdit,
                                              title: titleController.text,
                                              totalQuestions: int.tryParse(numberController.text),
                                              questionList: widget.questionList,
                                              position: widget.position,
                                            )),
                                  );
                                  //_controller.previousPage(duration: Duration(milliseconds: 10), curve: Curves.ease);
                                },
                                child: Text("Continue"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void validateTotalNumber(String value) {
    if (value.isNotEmpty) {
      final int? number = int.tryParse(value);

      if (number != null && number > 0) {
        setState(() {
          errorQuestionTotal = null;
        });
      } else {
        setState(() {
          errorQuestionTotal = 'Please provide a valid positive number of questions.';
        });
      }
    } else {
      setState(() {
        errorQuestionTotal = 'Please provide total number of questions.';
      });
    }
  }

  void validateTitle(String value) {
    if (value.length >= 10) {
      setState(() {
        errorTitle = null;
      });
    } else {
      setState(() {
        errorTitle = 'Title must be at least 10 characters.';
      });
    }
  }
}
