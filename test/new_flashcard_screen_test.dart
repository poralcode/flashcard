// DESCRIPTION: A Test when interacting with the creation of New Flashcard.
// What test is done here:
//  1. Ensure that the Title of thew new flashcard item is valid.
//    - The TextField Title with the Key of `title_textfield` should have at least 10 characters. Expected error message is 'Title must be at least 10 characters.'

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flashcard/screens/new_flashcard.dart';

void main() {
  testWidgets('Check valid Flashcard Title.', (WidgetTester tester) async {
    // Build the NewFlashcard widget
    await tester.pumpWidget(MaterialApp(home: NewFlashcard()));

    // Find the TextField by its Key
    final textFieldKey = Key('title_textfield');
    expect(find.byKey(textFieldKey), findsOneWidget);

    // Enter a valid title (e.g., more than 10 characters)
    await tester.enterText(find.byKey(textFieldKey), 'Valid Title');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is not shown
    expect(find.text('Title must be at least 10 characters.'), findsNothing);

    // Enter an invalid title (less than 10 characters)
    await tester.enterText(find.byKey(textFieldKey), 'Short');

    // Trigger a frame rebuild
    await tester.pump();

    // Verify that the error text is shown
    expect(find.text('Title must be at least 10 characters.'), findsOneWidget);
  });
}
