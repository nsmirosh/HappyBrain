import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/form_naming_page.dart';
import 'package:mental_health_app/relationship_form/second_page.dart';

import 'models/relationship_problem_form.dart';
import 'models/relationship_problem_form_step.dart';

var relationshipFormDocId = '';

const STEP_NO = 1;

class RelationshipFormFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    relationshipFormDocId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  var isLoading = false;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("Когда ты  "),
            TextField(
              controller: myController,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                child: RaisedButton(
                    child: Text("Дальше"),
                    onPressed: () => setState(() {
                          isLoading = true;
                        }) /*_doSomeStuff(context, myController.text)*/))
          ],
        ),
      ),
    );
  }
}

_doSomeStuff(BuildContext context, String text) {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
  _updateSteps(text).then((_) => _navigateToSecondStep(context));
}

Future<void> _updateSteps(String text) {
  return Firestore.instance
      .collection(RELATIONSHIP_FORM_PATH)
      .document(relationshipFormDocId)
      .updateData({
    FORM_STEPS_FIELD:
        List.filled(1, FormStep(stepNo: STEP_NO, answerText: text).toMap())
  });
}

_navigateToSecondStep(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RelationshipFormSecond(),
      settings: RouteSettings(
        arguments: relationshipFormDocId,
      ),
    ),
  );
}
