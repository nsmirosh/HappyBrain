import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ExecutionCallback = void Function(String text);

class ProgressOrNextWidget extends StatefulWidget {
  final TextEditingController textController;

  final ExecutionCallback callback;

  ProgressOrNextWidget({this.textController, this.callback});

  @override
  ProgressOrNextWidgetState createState() => ProgressOrNextWidgetState(
      textController: textController, callback: callback);
}

class ProgressOrNextWidgetState extends State<ProgressOrNextWidget> {
  var isLoading = false;

  final TextEditingController textController;
  final ExecutionCallback callback;

  ProgressOrNextWidgetState({this.textController, this.callback});

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

                callback(textController.text);
/*
                _updateSteps(text).then((_) => _navigateToSecondStep(context));
*/
              })),
      Visibility(visible: isLoading, child: CircularProgressIndicator())
    ]);
  }
}
