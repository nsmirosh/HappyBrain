import 'package:mental_health_app/relationship_form/models/relationship_problem_form_step.dart';

const FORM_STEPS_FIELD = 'formSteps';

class RelationshipProblemForm {
  final List<FormStep> steps = List();

  RelationshipProblemForm({this.formName});
  var completed = false;
  var formName = '';
  var creationTime = '';


  Map<String, dynamic> toMap() {
    return {
      'completed': completed,
      'formName': formName,
      'creationTime': creationTime,
    };
  }
}

