class FormStep {
  final stepNo;
  var answerText = '';

  FormStep({this.stepNo, this.answerText});

  Map<String, dynamic> toMap() {
    return {'stepNo': stepNo, 'answerText': answerText};
  }
}
