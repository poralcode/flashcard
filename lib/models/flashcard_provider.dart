import 'package:flashcard/models/flashcard_item.dart';
import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  List<FlashcardItem> _flashcardItems = [];

  List<FlashcardItem> get flashcardItems => _flashcardItems;

  FlashcardItem countTextVisualQuestion(FlashcardItem item) {
    item.numberOfVisualQuestions = item.questionItems.where((q) => q.isImageQuestion).length;
    item.numberOfTextQuestions = item.questionItems.where((q) => !q.isImageQuestion).length;
    return item;
  }

  void addFlashcard(FlashcardItem item) {
    _flashcardItems.add(countTextVisualQuestion(item));
    notifyListeners();
  }

  void updateFlashcard(int position, FlashcardItem item) {
    _flashcardItems[position] = countTextVisualQuestion(item);
    notifyListeners();
  }

  void removeFlashcard(FlashcardItem item) {
    _flashcardItems.remove(item);
    notifyListeners();
  }

  void removeAllFlashcard() {
    _flashcardItems.clear();
    notifyListeners();
  }
}
