import 'package:flashcard/models/flashcard_item.dart';
import 'package:flashcard/models/flashcard_provider.dart';
import 'package:flashcard/screens/new_flashcard.dart';
import 'package:flashcard/screens/play_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/* Home Screen */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var flashcardProvider = context.watch<FlashcardProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flashcard',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          if (flashcardProvider.flashcardItems.isNotEmpty)
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add New'), // Add this line
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewFlashcard(
                            isEdit: false,
                            title: '',
                            questionList: [],
                            position: 0,
                          )),
                );
              },
            ),
        ],
      ),
      // Add resizeToAvoidBottomInset property to avoid keyboard overlapping
      resizeToAvoidBottomInset: false,
      body: flashcardProvider.flashcardItems.isEmpty ? _buildEmptyFlashcard(context) : _buildFlashcardList(flashcardProvider),
    );
  }

  Widget _buildEmptyFlashcard(BuildContext context) {
    return Center(
      key: Key('empty_flashcard'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.view_list,
            size: 180, // Set the desired size
            color: Color.fromARGB(255, 232, 230, 230), // Set the desired color
          ),
          Text(
            'Empty Flashcard',
            style: TextStyle(
              fontSize: 20, // Set the desired font size
            ),
          ),
          Text(
            'This is where you see the list of your flashcards.',
            style: TextStyle(
              fontSize: 14, // Set the desired font size
              color: Colors.grey, // Set the desired text color
            ),
          ),
          SizedBox(height: 50), // Add spacing
          FilledButton.icon(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewFlashcard(
                          isEdit: false,
                          title: '',
                          questionList: [],
                          position: 0,
                        )),
              );
            },
            icon: Icon(Icons.add), // Add icon to the button
            label: Text("Add new flashcard"),
          ),
        ],
      ),
    );
  }

  String _determineQuestionType(int numberOfTextQuestions, int numberOfVisualQuestions) {
    if (numberOfTextQuestions > 0 && numberOfVisualQuestions > 0) {
      return 'Text and visual questions';
    } else if (numberOfTextQuestions > 0) {
      return 'Text questions only';
    } else if (numberOfVisualQuestions > 0) {
      return 'Visual questions only';
    } else {
      return 'No questions available'; // Handle the case when there are no questions
    }
  }

  Widget _buildFlashcardList(FlashcardProvider flashcardProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: flashcardProvider.flashcardItems.length,
        itemBuilder: (context, index) {
          FlashcardItem item = flashcardProvider.flashcardItems[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          item.flashcardName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.score > 0)
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD4AF37),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)), // adjust the radius as you need
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(FontAwesomeIcons.award, size: 14, color: Colors.white), // replace with your icon
                                  ),
                                  TextSpan(
                                    text: ' ${item.score}/${item.questionItems.length}', // replace with your text
                                    style: TextStyle(fontSize: 10, color: Colors.white), // change the color here
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.questionItems.length < 2 ? '${item.questionItems.length} Question' : '${item.questionItems.length} Questions', // Replace with your first text
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            _determineQuestionType(
                              item.numberOfTextQuestions,
                              item.numberOfVisualQuestions,
                            ), // Replace with your second text
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit), // Edit icon button
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewFlashcard(isEdit: true, title: item.flashcardName, questionList: item.questionItems, position: index)),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete), // Remove icon button
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete ${item.flashcardName}'),
                                      content: Text('Are you sure? Do you really want to delete this flashcard?'),
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
                                            Provider.of<FlashcardProvider>(context, listen: false).removeFlashcard(item);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.play_arrow), // Play icon button
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PlayFlashcard(title: item.flashcardName, questionList: item.questionItems, position: index)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
