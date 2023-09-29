// DESCRIPTION: A Test when interacting with the creation of New Flashcard.
// What test is done here:
//  1. Ensure that the Title of thew new flashcard item is valid.
//    - The TextField Title with the Key of `title_textfield` should have at least 10 characters. Expected error message is 'Title must be at least 10 characters.'

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard/screens/new_flashcard.dart';

void main() {
  testWidgets('Check valid Flashcard Title', (WidgetTester tester) async {
    // Build the NewFlashcard widget
    await tester.pumpWidget(MaterialApp(home: NewFlashcard()));

    // Find the TextField by its Key
    final titleTextFieldKey = Key('title_textfield');
    expect(find.byKey(titleTextFieldKey), findsOneWidget);

    // Enter a valid title (e.g., more than 10 characters)
    await tester.enterText(find.byKey(titleTextFieldKey), 'Valid Title');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is not shown
    expect(find.text('Title must be at least 10 characters.'), findsNothing);

    // Enter an invalid title (less than 10 characters)
    await tester.enterText(find.byKey(titleTextFieldKey), 'Short');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is shown
    expect(find.text('Title must be at least 10 characters.'), findsOneWidget);
  });

  testWidgets('Check valid Total Number of Questions',
      (WidgetTester tester) async {
    // Build the NewFlashcard widget
    await tester.pumpWidget(MaterialApp(home: NewFlashcard()));

    // Find the TextField by its Key
    final numberTextFieldKey = Key('number_input');
    expect(find.byKey(numberTextFieldKey), findsOneWidget);

    // Enter a valid total number (e.g., a positive number)
    await tester.enterText(find.byKey(numberTextFieldKey), '5');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is not shown
    expect(find.text('Please provide a valid positive number of questions.'),
        findsNothing);

    // Enter an invalid total number (e.g., a non-positive number)
    await tester.enterText(find.byKey(numberTextFieldKey), '0');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is shown
    expect(find.text('Please provide a valid positive number of questions.'),
        findsOneWidget);
  });
}
