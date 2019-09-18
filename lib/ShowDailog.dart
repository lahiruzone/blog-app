import 'package:flutter/material.dart';

class ShowDailog{
  information(BuildContext contex, String title, String description){
    return(
      showDialog(
        context: contex,
        barrierDismissible: true,
        builder: (BuildContext contex){
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  return Navigator.pop(contex);
                },
              ),
            ],
          );
        }
      )
    );
  }
}