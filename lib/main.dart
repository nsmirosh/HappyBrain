import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mental_health_app/relationship_form/models/relationship_problem_form_step.dart';
import 'package:mental_health_app/relationship_form/reducers/relationship_form_reducer.dart';
import 'package:mental_health_app/relationship_form/ui/form_naming_page.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<List<FormStep>>(appReducers, initialState: new List());

  runApp(MaterialApp(
    home: MyApp(store), // becomes the route named '/'
    routes: <String, WidgetBuilder>{
      '/relationshipFormFirstPage': (BuildContext context) => RelationshipForm()
    },
  ));
}

class MyApp extends StatelessWidget {
  final Store<List<FormStep>> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<List<FormStep>>(
      store: store,
      child: Scaffold(body: MyHome()),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Some other form', style: TextStyle(height: 5, fontSize: 10)),
        GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed('/relationshipFormFirstPage'),
            child: Text('Relationship form'))
      ],
    );
  }
}
