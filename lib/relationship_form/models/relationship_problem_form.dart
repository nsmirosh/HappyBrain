

class RelationshipProblemForm {
  var completed = false;
  var formName = '';
  var creationTime = '';


  Map<String, dynamic> toMap() {
    return {
      'completed': completed,
      'formName': formName,
      'creationTime': creationTime
    };
  }
}