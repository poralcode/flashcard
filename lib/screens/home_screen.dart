import 'package:flashcard/screens/new_flashcard.dart';
import 'package:flutter/material.dart';

/* Home Screen */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard'),
      ),
      // Add resizeToAvoidBottomInset property to avoid keyboard overlapping
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 180, // Set the desired size
              color:
                  Color.fromARGB(255, 232, 230, 230), // Set the desired color
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
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewFlashcard(),
                  ),
                );
              },
              icon: Icon(Icons.add), // Add icon to the button
              label: Text("Add new flashcard"),
            ),
          ],
        ),
      ),
    );
  }
}
