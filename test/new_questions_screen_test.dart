// DESCRIPTION: A Test when interacting with the New Question and Answer screen.
// What test is done here:
//  1. Ensure Question and Answer is valid.
//    - The TextField Question with the Key of `question_textfield` should have at least 1 character. Expected error message is 'Question must be at least 1 character.'
//    - The TextField Answer with the Key of `answer_textfield` should have at least 1 character. Expected error message is 'Answer must be at least 1 character.'
//
//  2. Ensure the visibility of Card (ImageView) and Question Text Field upon selection between the Radio Button with the Key of `text_radio_button` and `image_radio_button`.
//    - By default, the Radio Button with the Key `text_radio_button` is selected. At this point, the following are expected:
//      * Card with the Key of `image_card` is hidden.
//      * TextField with the Key of `question_textfield` is visible.
//    - Upon switching or selection of `image_radio_button`, the following are expected:
//      * TextField with the Key of `question_textfield` should be hidden.
//      * Card with the Key of `image_card` should be visible.
//
//  3. Ensure a valid image path when taking a photo using a Camera or selecting photo from the Gallery.
//    - The icon button with the Key of `icon_button_camera` will trigger the Camera by using the function `_handleCameraButton()`, the returned file path will be store in the variable called `_imageUrl`.
//    - The icon button with the Key of `icon_button_gallery` will trigger the Camera by using the function `_handleGalleryButton()`, the returned file path will be store in the variable called `_imageUrl`.
//    - The following are expected when using neither of the icon button:
//      * If valid path, the error message with the Key of `image_error_message` is hidden.
//      * Otherwise, it should be visible and the expected error message is 'Please select a valid image.'.
//
//  4. Ensure all input data are valid before proceeding or continuing to the next screen.
//    - In order to proceed to the next screen, the button with Key `button_done` or `button_next` should be clicked. At this point, the following are expected:
//      * If the Radio Button with the Key `text_radio_button` is selected, then the TextField Question and Answer should have a valid input.
//        - The error message 'Question must be at least 1 character.' and 'Answer must be at least 1 character.' should not be visible at this point.
//      * If the Radio Button with the Key `image_radio_button` is selected, then the TextField Answer should have a valid input and the image path should be valid.
//        - The error message 'Answer must be at least 1 character.' should not be visible and the error message with the Key of `image_error_message` should be hidden.

import 'package:flashcard/screens/new_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    expect(find.byKey(Key('image_radio_button')), findsOneWidget);

    // Tap on the "Text" radio button
    await tester.tap(find.byKey(Key('image_radio_button')));
    await tester.pump();

    // Verify that the question text field become invisible
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
    await tester.tap(find.byKey(Key('icon_button_camera')));
    await tester.pump();

    // The widget image_error_message should only visible if imageError contains any value of not null.
    // At this point, the _imageURL should have a valid path or value.
    expect(find.byKey(Key('image_error_message')),
        findsNothing); // Ensure no error message

    // Simulate tapping the gallery button
    await tester.tap(find.byKey(Key('icon_button_gallery')));
    await tester.pump();

    // The widget image_error_message should only visible if imageError contains any value of not null.
    // At this point, the _imageURL should have a valid path or value.
    expect(find.byKey(Key('image_error_message')),
        findsNothing); // Ensure no error message
  });

  testWidgets('Test valid Question and Answer', (WidgetTester tester) async {
    // Build the NewQuestion widget
    await tester.pumpWidget(MaterialApp(home: NewQuestion()));

    /* Test Text Question and Answer. */
    // Verify that the "Text" radio button is initially selected
    expect(find.byKey(Key('text_radio_button')), findsOneWidget);
    // Verify that the Question Text Field is visible.
    expect(find.byKey(Key('question_textfield')), findsOneWidget);
    // Input a valid Question
    await tester.enterText(
        find.byKey(Key('question_textfield')), 'Valid Question');
    // Input a valid Answer
    await tester.enterText(find.byKey(Key('answer_textfield')), 'Valid Answer');

    //Simulate tapping button done.
    await tester.tap(find.byKey(Key('button_done')));
    await tester.pump();

    //No error should be present.
    expect(find.text('Question must be at least 1 character.'), findsNothing);
    expect(find.text('Answer must be at least 1 character.'), findsNothing);

    //Simulate tapping button next.
    await tester.tap(find.byKey(Key('button_next')));
    await tester.pump();

    //No error should be present.
    expect(find.text('Question must be at least 1 character.'), findsNothing);
    expect(find.text('Answer must be at least 1 character.'), findsNothing);

    /* Test Image Question and Answer. */
    // Tap on the "Image" radio button to make the image card visible
    await tester.tap(find.byKey(Key('image_radio_button')));
    await tester.pump();

    // Verify that the image card is visible
    expect(find.byKey(Key('image_card')), findsOneWidget);

    // Simulate tapping the camera button
    await tester.tap(find.byKey(Key('icon_button_camera')));
    await tester.pump();

    // The widget image_error_message should only visible if imageError contains any value of not null.
    // At this point, the _imageURL should have a valid path or value.
    expect(find.byKey(Key('image_error_message')),
        findsNothing); // Ensure no error message

    // Simulate tapping the gallery button
    await tester.tap(find.byKey(Key('icon_button_gallery')));
    await tester.pump();

    // The widget image_error_message should only visible if imageError contains any value of not null.
    // At this point, the _imageURL should have a valid path or value.
    expect(find.byKey(Key('image_error_message')), findsNothing);

    // Input a valid Answer
    await tester.enterText(find.byKey(Key('answer_textfield')), 'Valid Answer');

    //Simulate tapping button done.
    await tester.tap(find.byKey(Key('button_done')));
    await tester.pump();

    //No error should be present.
    expect(find.text('Question must be at least 1 character.'), findsNothing);
    expect(find.text('Answer must be at least 1 character.'), findsNothing);

    //Simulate tapping button next.
    await tester.tap(find.byKey(Key('button_next')));
    await tester.pump();

    //No error should be present.
    expect(find.text('Question must be at least 1 character.'), findsNothing);
    expect(find.text('Answer must be at least 1 character.'), findsNothing);
  });
}
