import 'package:flutter/material.dart';
import 'package:flashcard/screens/new_question.dart';

/* NewFlashcard Screen */
class NewFlashcard extends StatefulWidget {
  const NewFlashcard({Key? key}) : super(key: key);

  @override
  _NewFlashcardState createState() => _NewFlashcardState();
}

class _NewFlashcardState extends State<NewFlashcard> {
  final titleController = TextEditingController();
  String? errorText;

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
            // Centered Container to limit the width and align horizontally
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400), // Limit the width
                child: Column(
                  children: [
                    // TextField for the title
                    TextField(
                      key: Key('title_textfield'), // Assign a unique Key
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
                        errorText: errorText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            titleController.clear();
                            setState(() {
                              errorText = null;
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      onChanged: (value) {
                        validateTitle(value);
                      },
                    ),
                    // Add spacing between TextField and Button
                    SizedBox(height: 16),

                    // Align the Button to the right
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Check if there's no error before continuing
                          validateTitle(titleController.text);
                          if (errorText == null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewQuestion(),
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

  void validateTitle(String value) {
    if (value.length >= 10) {
      // Clear any previous error message
      setState(() {
        errorText = null;
      });
    } else {
      setState(() {
        errorText = 'Title must be at least 10 characters.';
      });
    }
  }
}
