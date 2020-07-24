import 'package:mental_health_app/relationship_form/models/relationship_problem_form_step.dart';

class RelationshipProblemForm {
  final List<FormStep> steps = List();
  var completed = false;
  var formName = '';
  var creationTime = '';

  Map<String, dynamic> toMap() {
    return {
      'completed': completed,
      'formName': formName,
      'creationTime': creationTime,
//      'steps': Map.fromIterable(steps, key: (e) => e.name, value: (e) => e.age);
    };
  }
}

