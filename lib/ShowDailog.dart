import 'package:flutter/material.dart';

class ShowDailog {
  information(BuildContext contex, String title, String description) {
    return (showDialog(
        context: contex,
        barrierDismissible: true,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  return Navigator.pop(contex);
                },
              ),
            ],
          );
        }));
  }

  onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(30.0),
          // margin: EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[CircularProgressIndicator(), Text('Uploading')],
          ),
        );
      },
    );
  }
}
