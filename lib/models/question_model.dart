class QuestionModel {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  bool answered;

  // Default constructor
  QuestionModel({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
    this.answered = false,
  });

  // Named constructor for creating an answered question
  QuestionModel.answered({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
  }) : answered = true;
}
