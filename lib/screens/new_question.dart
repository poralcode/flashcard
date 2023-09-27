import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewQuestion extends StatefulWidget {
  const NewQuestion({Key? key});

  @override
  State<NewQuestion> createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  int selectedRadio = 0;
  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();
  String _imageUrl = '';
  String? imageError;
  String? questionError;
  String? answerError;

  Future<void> _handleCameraButton() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
        validateImage(_imageUrl);
      });
    }
  }

  Future<void> _handleGalleryButton() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
        validateImage(_imageUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questions & answers',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // Wrap your Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Radio(
                        key: Key('text_radio_button'),
                        value: 0,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value as int;
                          });
                        },
                      ),
                      const Text('Text'),
                      Radio(
                        key: Key('image_radio_button'),
                        value: 1,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value as int;
                          });
                        },
                      ),
                      const Text('Image'),
                    ],
                  ),
                  // Conditional rendering based on selected radio button
                  if (selectedRadio == 0)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          key: Key('question_textfield'),
                          controller: questionTextController,
                          maxLines:
                              questionTextController.text.split('\n').length < 5
                                  ? null
                                  : 5,
                          maxLength: 300,
                          decoration: InputDecoration(
                            labelText: 'Question no. 1',
                            helperText: 'Specify the question.',
                            errorText: questionError,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {});
                            validateQuestion(value);
                          },
                        ),
                      ),
                    )
                  else if (selectedRadio == 1)
                    Card(
                      key: Key('image_card'),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Center(
                              child: _imageUrl.isEmpty
                                  ? Icon(
                                      Icons.photo,
                                      size: 100,
                                      color: Colors.grey,
                                    )
                                  : Image.file(
                                      File(_imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left margin
                                child: Text(
                                  'Question no. 1',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    key: Key('icon_button_camera'),
                                    icon: Icon(Icons.camera),
                                    onPressed: _handleCameraButton,
                                  ),
                                  IconButton(
                                    key: Key('icon_button_gallery'),
                                    icon: Icon(Icons.photo),
                                    onPressed: _handleGalleryButton,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  if (selectedRadio == 1 && imageError != null)
                    Padding(
                      padding: EdgeInsets.only(
                          left: 12.0, top: 5.0), // Add left margin
                      child: Text(
                        key: Key('image_error_message'),
                        imageError!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[
                              800], // Use a shade of red for error messages
                        ),
                      ),
                    ),

                  SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        key: Key('answer_textfield'),
                        controller: answerTextController,
                        decoration: InputDecoration(
                          labelText: 'Answer',
                          helperText: 'Specify the correct answer.',
                          errorText: answerError,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          validateAnswer(value);
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Handle Done button click
                          if (isValidInput(
                              questionTextController.text,
                              answerTextController.text,
                              _imageUrl)) debugPrint("Done button clicked");
                        },
                        child: const Text("Done"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Next button click
                          if (isValidInput(
                              questionTextController.text,
                              answerTextController.text,
                              _imageUrl)) debugPrint("Next button clicked");
                        },
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* This function validates the input base on the selected type of question which is Text or Image.  
     This should be call upon clicking the Button Next or Done to finally validate the inputs before proceeding to the next screen or page.
  */
  bool isValidInput(String question, String answer, String imageURL) {
    if (selectedRadio == 0) {
      // Text radio button is selected, only validate Question and Answer
      validateQuestion(question);
      validateAnswer(answer);
      return questionError == null && answerError == null;
    } else if (selectedRadio == 1) {
      // Image radio button is selected, only validate ImageView and Answer
      validateImage(imageURL);
      validateAnswer(answer);
      return imageError == null && answerError == null;
    }
    return false;
  }

  /* Function to check for a valid image. This function relies on the URL(string) or the Path(string) of the image. Empty string means invalid image. */
  void validateImage(String value) {
    if (value.isEmpty) {
      setState(() {
        imageError = 'Please select a valid image.';
      });
    } else {
      setState(() {
        imageError = null;
      });
    }
  }

  /* This function check if the input is a valid question having at least minimum of 1 character. */
  void validateQuestion(String value) {
    if (value.length >= 1) {
      // Clear any previous error message
      setState(() {
        questionError = null;
      });
    } else {
      setState(() {
        questionError = 'Question must be at least 1 character.';
      });
    }
  }

  /* This function check if the input is a valid answer having at least minimum of 1 character. */
  void validateAnswer(String value) {
    if (value.length >= 1) {
      // Clear any previous error message
      setState(() {
        answerError = null;
      });
    } else {
      setState(() {
        answerError = 'Answer must be at least 1 character.';
      });
    }
  }
}
