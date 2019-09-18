import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Mapping.dart';

void main(){
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'My Blog',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Mapping(auth: Authentication(),),
      );
    }
}