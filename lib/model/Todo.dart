import 'package:flutter/cupertino.dart';

class Todo {
  String title;
  bool checked;

  Todo({@required this.title, this.checked = false});

  Map toJson() => {
    'title' : title,
    'checked' : checked,

  };
}