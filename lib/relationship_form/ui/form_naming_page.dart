import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/helpers/validators.dart';
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
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text("Название формы:  "),
                  TextFormField(
                    controller: myController,
                    validator: (toValidate) => validateNotEmpty(toValidate),
                  ),
                  RaisedButton(
                      child: Text("Дальше"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _navigateToFormScreen(context, myController.text);
                        }
                      }),
                ],
              ),
            )));
  }
}

_navigateToFormScreen(BuildContext context, String formName) async {
  DocumentReference reference = await Firestore.instance
      .collection(RELATIONSHIP_FORM_PATH)
      .add(RelationshipProblemForm(formName: formName).toMap());

  if (reference != null) {
    print("document ${reference.documentID} succefully created!");
  } else {
    print(" \n \n \n \n Could not create a document Reference!\n \n \n \n");
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RelationshipFormFirstPage(),
      settings: RouteSettings(
        arguments: reference.documentID,
      ),
    ),
  );
}
