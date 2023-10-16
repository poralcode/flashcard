import 'dart:io';

import 'package:flashcard/models/flashcard_item.dart';
import 'package:flashcard/models/flashcard_provider.dart';
import 'package:flashcard/models/question_answer_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewQuestion extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question & Answer',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: QuestionAnswerPage(
        isEdit: isEdit,
        title: title,
        totalQuestions: totalQuestions,
        questionList: questionList,
        position: position,
      ),
    );
  }
}

class QuestionAnswerPage extends StatefulWidget {
  final int? totalQuestions;
  final int position;
  final String title;
  final bool isEdit;
  final List<QuestionAnswerItem> questionList;
  const QuestionAnswerPage({
    Key? key,
    required this.isEdit,
    required this.title,
    required this.totalQuestions,
    required this.questionList,
    required this.position,
  }) : super(key: key);

  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  List<QuestionAnswerItem> questionList = [];
  int currentPage = 0;
  final PageController pageController = PageController();
  List<GlobalKey<FormState>> formKeys = [];

  @override
  void initState() {
    super.initState();
    createQuestionsList(widget.totalQuestions ?? 1);
  }

  void createQuestionsList(int total) {
    if (widget.isEdit) {
      questionList = widget.questionList; //replace with the old list object.
      if (total < questionList.length) {
        questionList.sublist(0, total); //Reduce items here.
      } else if (total > questionList.length) {
        for (int i = questionList.length; i < total; i++) {
          questionList.add(QuestionAnswerItem(i, false, '', '', '')); //Add items to list
        }
      }
      for (int i = 0; i < questionList.length; i++) {
        formKeys.add(GlobalKey<FormState>()); //recreate the formKeys
      }
    } else {
      //Create new items
      for (int i = 0; i < total; i++) {
        questionList.add(QuestionAnswerItem(i, false, '', '', ''));
        formKeys.add(GlobalKey<FormState>());
      }
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
    return PageView.builder(
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
                                            Icons.photo,
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
                          if (currentQuestion.isImageQuestion && currentQuestion.imageQuestion.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(left: 12.0, top: 5.0),
                              child: Text(
                                'Please select a valid image.',
                                key: Key('image_error_message'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
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
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () async {
                            if (formKeys[index].currentState!.validate()) {
                              if (index == questionList.length - 1) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          new CircularProgressIndicator(),
                                          new Text("Loading"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                // Wait for 3 seconds
                                await Future.delayed(Duration(seconds: 3));
                                FlashcardItem newFlashcardItem = FlashcardItem(0, 0, 0, 0, widget.title, questionList);
                                if (widget.isEdit)
                                  Provider.of<FlashcardProvider>(context, listen: false).updateFlashcard(widget.position, newFlashcardItem);
                                else
                                  Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(newFlashcardItem);
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
    );
  }
}
