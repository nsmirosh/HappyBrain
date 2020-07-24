import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/relationship_problem_form.dart';

import 'models/relationship_problem_form_step.dart';

var relationshipFormDocId = '';

const STEP_NO = 1;

class RelationshipFormSecond extends StatelessWidget {
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

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('relationshipFormDocId : $relationshipFormDocId');
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
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
                  onPressed: () => _onButtonPress(myController.text),
                )),
          ],
        ),
      ),
    );
  }
}

_onButtonPress(String text) async {
  final formStep = FormStep(stepNo: STEP_NO, answerText: text).toMap();

  final List<Map<String, dynamic>> steps = List();
  steps.add(formStep);
  await Firestore.instance
      .collection(RELATIONSHIP_FORM_PATH)
      .document(relationshipFormDocId)
      .updateData({'formSteps': steps});
}
