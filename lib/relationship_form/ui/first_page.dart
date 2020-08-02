import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/ui/form_naming_page.dart';
import 'package:mental_health_app/relationship_form/ui/progress_or_next_widget.dart';
import 'package:mental_health_app/relationship_form/ui/second_page.dart';

import '../models/relationship_problem_form.dart';
import '../models/relationship_problem_form_step.dart';

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
            Text("When you  "),
            TextField(
              controller: controller,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                child: ProgressOrNextWidget(
                  textController: controller,
                  callback: (text) =>
                      _updateSteps(text).then(_navigateToSecondStep(context)),
                ))
          ],
        ),
      ),
    );
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
