// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flashcard/screens/new_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flashcard/screens/new_flashcard.dart';

void main() {
  testWidgets("Check valid Question", (tester) async {
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));
    final questionTexFieldKey = Key('question_textfield');
    expect(find.byKey(questionTexFieldKey), findsOneWidget);

    await tester.enterText(find.byKey(questionTexFieldKey), 'Valid Question');
    await tester.pump();
    expect(find.text('Question must be at least 1 character.'), findsNothing);

    await tester.enterText(find.byKey(questionTexFieldKey), '');
    await tester.pump();
    expect(find.text('Question must be at least 1 character.'), findsOneWidget);
  });

  testWidgets("Check valid Answer", (tester) async {
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));
    final answerTexFieldKey = Key('answer_textfield');
    expect(find.byKey(answerTexFieldKey), findsOneWidget);

    await tester.enterText(find.byKey(answerTexFieldKey), 'Valid Answer');
    await tester.pump();
    expect(find.text('Answer must be at least 1 character.'), findsNothing);

    await tester.enterText(find.byKey(answerTexFieldKey), '');
    await tester.pump();
    expect(find.text('Answer must be at least 1 character.'), findsOneWidget);
  });

  testWidgets("Check Radio Button Text Selected", (tester) async {
    // Build the NewQuestion widget
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));

    // Verify that the "Text" radio button is initially selected
    expect(find.byKey(Key('text_radio_button')), findsOneWidget);

    // Verify that the image card is initially invisible
    expect(find.byKey(Key('image_card')), findsNothing);

    // Verify that the question text field and answer text field are initially visible
    expect(find.byKey(Key('question_textfield')), findsOneWidget);
    expect(find.byKey(Key('answer_textfield')), findsOneWidget);

    // Tap on the "Text" radio button
    await tester.tap(find.byKey(Key('text_radio_button')));
    await tester.pump();

    // Verify that the image card remains invisible
    expect(find.byKey(Key('image_card')), findsNothing);

    // Verify that the question text field become visible
    expect(find.byKey(Key('question_textfield')), findsOneWidget);
  });

  testWidgets("Check Radio Button Image Selected", (tester) async {
    // Build the NewQuestion widget
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));

    // Verify that the "Text" radio button is initially selected
    expect(find.byKey(Key('text_radio_button')), findsOneWidget);
    // Verify that the image card is initially invisible
    expect(find.byKey(Key('image_card')), findsNothing);
    // Verify that the question text field and answer text field are initially visible
    expect(find.byKey(Key('question_textfield')), findsOneWidget);
    expect(find.byKey(Key('answer_textfield')), findsOneWidget);

    // Tap on the "Text" radio button
    await tester.tap(find.byKey(Key('image_radio_button')));
    await tester.pump();

    // Verify that the qquestion text field become invisible
    expect(find.byKey(Key('question_textfield')), findsNothing);

    // Verify that the image card become visible
    expect(find.byKey(Key('image_card')), findsOneWidget);
  });

  testWidgets('Test Camera and Gallery Button', (WidgetTester tester) async {
    // Build the NewQuestion widget
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));

    // Tap on the "Image" radio button to make the image card visible
    await tester.tap(find.byKey(Key('image_radio_button')));
    await tester.pump();

    // Verify that the image card is visible
    expect(find.byKey(Key('image_card')), findsOneWidget);

    // Simulate tapping the camera button
    //  await tester.tap(find.byKey(Key('icon_button_camera')));
    //  await tester.pump();

    // In this test, you can assert that the `_imageUrl` is not empty, which means a valid image was picked.
    expect(find.byKey(Key('image_error_message')),
        findsOneWidget); // Ensure no error message

    // Ensure the error message text is empty
    final errorMessageText =
        tester.widget<Text>(find.byKey(Key('image_error_message'))).data;
    debugPrint('${errorMessageText} - Message');
    //expect(errorMessageText, '');
/*
    expect(tester.widget<IconButton>(find.byKey(Key('icon_button_camera'))),
        findsOneWidget);

    // Simulate tapping the gallery button
    await tester.tap(find.byKey(Key('icon_button_gallery')));
    await tester.pump();

    // In this test, you can assert that the `_imageUrl` is not empty, which means a valid image was picked.
    expect(find.byKey(Key('image_error_message')),
        findsNothing); // Ensure no error message
    expect(tester.widget<IconButton>(find.byKey(Key('icon_button_gallery'))),
        findsOneWidget);*/
  });

  /*testWidgets("Check valid Image URL", (tester) async {
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));
    final imageFileIconKey = Key('image_file_icon');
    expect(find.byKey(imageFileIconKey), findsOneWidget);

    await tester.tap(find.byKey(imageFileIconKey));
    await tester.pump();
    expect(find.text('Please select a valid image.'), findsNothing);

    await tester.enterText(find.byKey(imageFileIconKey), '');
    await tester.pump();
    expect(find.text('Please select a valid image.'), findsOneWidget);
  });*/

  /*testWidgets("Check Radio Button Image Selected", (tester) async {
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));

    final imageCardKey = Key('question_textfield');
    expect(find.byKey(imageCardKey), findsOneWidget);

    final questionTexFieldKey = Key('question_textfield');
    expect(find.byKey(questionTexFieldKey), findsOneWidget);

    final answerTexFieldKey = Key('answer_textfield');
    expect(find.byKey(answerTexFieldKey), findsOneWidget);

    final textRadioButonKey = Key('text_radio_button');
    expect(find.byKey(textRadioButonKey), findsOneWidget);

    await tester.tap(find.byKey(textRadioButonKey));
    await tester.pump();

    expect(find.byKey(questionTexFieldKey), findsOneWidget);
    expect(find.byKey(answerTexFieldKey), findsOneWidget);
  });*/

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
