import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/form_naming_page.dart';
import 'package:mental_health_app/relationship_form/models/relationship_problem_form.dart';

import 'models/relationship_problem_form_step.dart';

var relationshipFormDocId = '';

const STEP_NO = 2;

class RelationshipFormSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    relationshipFormDocId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
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
            Text("Тогда я чувствую себя"),
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
  Firestore.instance
      .collection(RELATIONSHIP_FORM_PATH)
      .document(relationshipFormDocId)
      .updateData({
    FORM_STEPS_FIELD: FieldValue.arrayUnion(
        [FormStep(stepNo: STEP_NO, answerText: text).toMap()])
  });
}
