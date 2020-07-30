import 'package:flutter/material.dart';
import 'package:mental_health_app/relationship_form/actions/save_step_action.dart';
import 'package:mental_health_app/relationship_form/models/relationship_problem_form_step.dart';

List<FormStep> appReducers(List<FormStep> items, dynamic action) {
  if (action is SaveStepAction) {
    return addItem(items, action);
  }
  return items;
}

List<FormStep> addItem(List<FormStep> items, SaveStepAction action) {
  return List.from(items)..add(action.step);
}