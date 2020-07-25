import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/first_page.dart';
import 'package:mental_health_app/relationship_form/form_naming_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/relationshipFormFirstPage': (BuildContext context) => RelationshipForm()
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHome()
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
          onTap: ()  => Navigator.of(context).pushNamed('/relationshipFormFirstPage'),
          child: Text('Relationship form')
        )
      ],
    );
  }
}