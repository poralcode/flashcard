import 'package:flashcard/models/flashcard_item.dart';
import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  List<FlashcardItem> _flashcardItems = [];

  List<FlashcardItem> get flashcardItems => _flashcardItems;

  void addFlashcard(FlashcardItem item) {
    _flashcardItems.add(item);
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
