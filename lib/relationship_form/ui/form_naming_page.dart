import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/ui/first_page.dart';

import '../models/relationship_problem_form.dart';

const RELATIONSHIP_FORM_PATH = 'relationship_forms';

class RelationshipForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MyCustomForm());
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Retrieve Text Input'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text("Название формы:  "),
                TextFormField(
                  controller: myController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Это поле не может быть пустым';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                    child: RaisedButton(
                        child: Text("Дальше"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _navigateToSecondScreen(context, myController.text);
                          }
                        })),
              ],
            ),
          ),
        ));
  }
}

_navigateToSecondScreen(BuildContext context, String formName) async {
  DocumentReference reference;

  reference = await Firestore.instance
      .collection(RELATIONSHIP_FORM_PATH)
      .add(RelationshipProblemForm(formName: formName).toMap());

  if (reference != null) {
    print("document ${reference.documentID} succefully created!");
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RelationshipFormFirstPage(),
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
