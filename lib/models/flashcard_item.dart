/* This class is the model for the Flashcard Item. */
class FlashcardItem {
  int score = 0;
  int numberOfQuestions = 0;
  int numberOfTextQuestions = 0;
  int numberOfVisualQuestions = 0;
  String flashcardName = 'Flashcard Item';

  // Constructor
  FlashcardItem(this.score, this.numberOfQuestions, this.numberOfTextQuestions,
      this.numberOfVisualQuestions, this.flashcardName);
}
