/* This class is the model for the Flashcard Item. */
import 'package:flashcard/models/question_answer_item.dart';

class FlashcardItem {
  int score = 0;
  int numberOfQuestions = 0;
  int numberOfTextQuestions = 0;
  int numberOfVisualQuestions = 0;
  String flashcardName = 'Flashcard Item';
  List<QuestionAnswerItem> questionItems = [];

  // Constructor
  FlashcardItem(this.score, this.numberOfQuestions, this.numberOfTextQuestions, this.numberOfVisualQuestions, this.flashcardName, this.questionItems);
}
