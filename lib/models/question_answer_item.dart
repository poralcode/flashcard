class QuestionAnswerItem {
  int id = 0;
  bool isImageQuestion = false;
  String textQuestion = '';
  String imageQuestion = '';
  String? answer;

  QuestionAnswerItem(this.id, this.isImageQuestion, this.textQuestion, this.imageQuestion, this.answer);
}
