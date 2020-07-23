import 'package:flutter/material.dart';

class RelationshipFormSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    final String todo = ModalRoute.of(context).settings.arguments;
    print(todo);
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("Тогда я чувствую себя  "),
            TextField(
              controller: myController,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                child: RaisedButton(
                  child: Text("Дальше"),
                  onPressed: () => print("stuff"),
                )),
          ],
        ),
      ),
    );
  }
}
