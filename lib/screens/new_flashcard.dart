import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services library for input formatters
import 'package:flashcard/screens/new_question.dart';

class NewFlashcard extends StatefulWidget {
  const NewFlashcard({Key? key}) : super(key: key);

  @override
  _NewFlashcardState createState() => _NewFlashcardState();
}

class _NewFlashcardState extends State<NewFlashcard> {
  final titleController = TextEditingController();
  final numberController =
      TextEditingController(); // Controller for number input
  String? errorTitle;
  String? errorQuestionTotal;

  @override
  void dispose() {
    numberController.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Flashcard',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
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
                        helperText:
                            'Add a meaningful title for this flashcard.',
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
                      keyboardType:
                          TextInputType.number, // Set input type to number
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly // Allow only digits
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
                      child: ElevatedButton(
                        onPressed: () {
                          validateTitle(titleController.text);
                          validateTotalNumber(numberController.text);
                          if (errorTitle == null &&
                              errorQuestionTotal == null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewQuestion(
                                  title: titleController.text,
                                  totalQuestions:
                                      int.tryParse(numberController.text),
                                ),
                              ),
                            );
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
    );
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
          errorQuestionTotal =
              'Please provide a valid positive number of questions.';
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
