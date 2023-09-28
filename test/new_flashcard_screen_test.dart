// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
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
