import 'dart:io';
import 'package:flashcard/models/flashcard_item.dart';
import 'package:flashcard/models/flashcard_provider.dart';
import 'package:flashcard/models/question_answer_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewQuestion extends StatefulWidget {
  final String title;
  final int? totalQuestions;
  final int position;
  final bool isEdit;
  final List<QuestionAnswerItem> questionList;

  const NewQuestion({
    Key? key,
    required this.title,
    required this.totalQuestions,
    required this.isEdit,
    required this.questionList,
    required this.position,
  }) : super(key: key);

  @override
  _NewQuestionState createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  List<QuestionAnswerItem> questionList = [];
  int currentPage = 0;
  final PageController pageController = PageController();
  List<GlobalKey<FormState>> formKeys = [];
  bool _showLinearProgress = false;

  @override
  void initState() {
    super.initState();
    createQuestionsList(widget.totalQuestions ?? 1);
  }

  void createQuestionsList(int total) {
    if (widget.isEdit) {
      questionList = widget.questionList;
      if (total < questionList.length) {
        questionList = questionList.sublist(0, total);
      } else if (total > questionList.length) {
        for (int i = questionList.length; i < total; i++) {
          questionList.add(QuestionAnswerItem(i, false, '', '', ''));
        }
      }
      formKeys = List.generate(questionList.length, (index) => GlobalKey<FormState>());
    } else {
      questionList = List.generate(
        total,
        (i) => QuestionAnswerItem(i, false, '', '', ''),
      );
      formKeys = List.generate(total, (index) => GlobalKey<FormState>());
    }
  }

  Future<void> _handleImageSelection(ImageSource source, int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        questionList[index].imageQuestion = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question & Answer',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.0),
          child: Visibility(
            visible: _showLinearProgress, // Show LinearProgressIndicator when _showLinearProgress is true
            child: LinearProgressIndicator(),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
              controller: pageController,
              itemCount: questionList.length,
              itemBuilder: (context, index) {
                final currentQuestion = questionList[index];
                int? qMaxLines = null;
                void setMaxLines() {
                  setState(() {
                    qMaxLines = currentQuestion.textQuestion.split('\n').length < 5 ? null : 5;
                  });
                }

                return Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKeys[index],
                  child: SingleChildScrollView(
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
                                // Radio buttons for selecting Text or Image question
                                Radio(
                                  key: Key('text_radio_button'),
                                  value: false,
                                  groupValue: currentQuestion.isImageQuestion,
                                  onChanged: (value) {
                                    setState(() {
                                      currentQuestion.isImageQuestion = false;
                                    });
                                  },
                                ),
                                const Text('Text'),
                                Radio(
                                  key: Key('image_radio_button'),
                                  value: true,
                                  groupValue: currentQuestion.isImageQuestion,
                                  onChanged: (value) {
                                    setState(() {
                                      currentQuestion.isImageQuestion = true;
                                    });
                                  },
                                ),
                                const Text('Image'),
                              ],
                            ),
                            if (!currentQuestion.isImageQuestion)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    key: Key('question_textfield'),
                                    initialValue: currentQuestion.textQuestion,
                                    maxLines: qMaxLines,
                                    maxLength: 300,
                                    decoration: InputDecoration(
                                      labelText: 'Question no. ${index + 1}',
                                      helperText: 'Specify the question.',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      return value == null || value.isEmpty || value.length < 1 ? 'Question must be at least 1 character.' : null;
                                    },
                                    onChanged: (value) {
                                      currentQuestion.textQuestion = value;
                                      setMaxLines();
                                    },
                                  ),
                                ),
                              )
                            else
                              Column(
                                children: [
                                  // Card for displaying the image question
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
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                          ),
                                          child: Center(
                                            child: currentQuestion.imageQuestion.isEmpty
                                                ? Icon(
                                                    FontAwesomeIcons.solidImage,
                                                    size: 100,
                                                    color: Colors.grey,
                                                  )
                                                : Image.file(
                                                    File(currentQuestion.imageQuestion),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                'Question no. ${index + 1}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                // Buttons for image selection
                                                IconButton(
                                                  key: Key('icon_button_camera'),
                                                  icon: Icon(Icons.camera),
                                                  onPressed: () => _handleImageSelection(ImageSource.camera, index),
                                                ),
                                                IconButton(
                                                  key: Key('icon_button_gallery'),
                                                  icon: Icon(Icons.photo),
                                                  onPressed: () => _handleImageSelection(ImageSource.gallery, index),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (currentQuestion.isImageQuestion && currentQuestion.imageQuestion.isEmpty) _buildErrorMessage('Please select a valid image.'),
                                ],
                              ),
                            SizedBox(height: 16),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  initialValue: currentQuestion.answer,
                                  maxLength: 255,
                                  decoration: InputDecoration(
                                    labelText: 'Answer',
                                    helperText: 'Specify the correct answer.',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    return value == null || value.isEmpty || value.length < 1 ? 'Answer must be at least 1 character.' : null;
                                  },
                                  onChanged: (value) {
                                    currentQuestion.answer = value;
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                if (index > 0)
                                  FilledButton(
                                    onPressed: () {
                                      pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text('Previous'),
                                  ),
                                const SizedBox(width: 24),
                                FilledButton(
                                  onPressed: () async {
                                    if (formKeys[index].currentState!.validate()) {
                                      if (index == questionList.length - 1) {
                                        setState(() {
                                          _showLinearProgress = true; // Show linear progress indicator
                                        });
                                        // Simulating a loading process with Future.delayed
                                        await Future.delayed(Duration(seconds: 3));
                                        FlashcardItem newFlashcardItem = FlashcardItem(0, 0, 0, 0, widget.title, questionList);
                                        if (widget.isEdit) {
                                          Provider.of<FlashcardProvider>(context, listen: false).updateFlashcard(widget.position, newFlashcardItem);
                                        } else {
                                          Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(newFlashcardItem);
                                        }
                                        Navigator.of(context).pop(); // Close the loading dialog
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                      }
                                      pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Text(index < questionList.length - 1 ? 'Next' : 'Finish'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showLinearProgress)
            Center(
              child: ModalBarrier(
                dismissible: false, // Prevents users from tapping outside the dialog
                color: Colors.black.withOpacity(0.3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 5.0),
      child: Text(
        message,
        key: Key('image_error_message'),
        style: TextStyle(
          fontSize: 12,
          color: Colors.red[800],
        ),
      ),
    );
  }
}
