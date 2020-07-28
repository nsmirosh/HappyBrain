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
      body: SecondPageMainView(),
    );
  }
}

// Define a custom Form widget.
class SecondPageMainView extends StatefulWidget {
  @override
  _SecondPageMainState createState() => _SecondPageMainState();
}

class _SecondPageMainState extends State<SecondPageMainView> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
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
              controller: controller,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                child: ProgressOrNextWidget(text: controller.text))
          ],
        ),
      ),
    );
  }
}

class ProgressOrNextWidget extends StatefulWidget {
  final String text;

  ProgressOrNextWidget({this.text});

  @override
  ProgressOrNextWidgetState createState() =>
      ProgressOrNextWidgetState(text: text);
}

class ProgressOrNextWidgetState extends State<ProgressOrNextWidget> {
  var isLoading = false;

  final String text;

  ProgressOrNextWidgetState({this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Visibility(
          visible: !isLoading,
          child: RaisedButton(
              child: Text("Дальше"),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _updateSteps(text).then((_) => _navigateToSecondStep(context));
              })),
      Visibility(visible: isLoading, child: CircularProgressIndicator())
    ]);
  }
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
