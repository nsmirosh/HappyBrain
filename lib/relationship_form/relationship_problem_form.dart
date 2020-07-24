import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/relationship_form_second_page.dart';

import 'models/relationship_problem_form.dart';

const RELATIONSHIP_FORM_PATH = 'relationship_forms';

class RelationshipForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MyCustomForm());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("Название формы:  "),
            TextField(
              controller: myController,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                child: RaisedButton(
                  child: Text("Дальше"),
                  onPressed: () =>
                      _navigateToSecondScreen(context, myController.text),
                )),
          ],
        ),
      ),
    );
  }
}

_navigateToSecondScreen(BuildContext context, String formName) async {

  final form = RelationshipProblemForm();
  form.formName = formName;

  DocumentReference reference = await Firestore.instance.collection(RELATIONSHIP_FORM_PATH).add(form.toMap());
  if (reference != null) {
    print("document ${reference.documentID} succefully created!");
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RelationshipFormSecond(),
      // Pass the arguments as part of the RouteSettings. The
      // DetailScreen reads the arguments from these settings.
      settings: RouteSettings(
        arguments: reference.documentID,
      ),
    ),
  );

  /*print('\n \n \n \n STARTING TO READ THE STREAM \n \n \n \n ');
  await for (var value in snapshot) {
    final documentsList = value.documents;
    final step = documentsList.map((document) =>  Question.fromSnapshot(document)).toList();
    print('\n \n \n \n $step \n \n \n \n ');
  }

  */
}


class Question {
  final String text;
  final int stepNumber;
  final DocumentReference reference;

  Question.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['text'] != null),
        assert(map['step'] != null),
        text = map['text'],
        stepNumber = map['step'];

  Question.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Step<$stepNumber:$text>";
}
