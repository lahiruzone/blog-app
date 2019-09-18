import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhoto extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _UploadPhotoState();
  }
}

class _UploadPhotoState extends State<UploadPhoto>{

  File sampleImage;
  String _myValue;
  final formkey = new GlobalKey<FormState>();

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Upload Image"),
          centerTitle: true,
        ),
        body: new Center(
          child: sampleImage == null? Text("Select an Image"): enableUpload(),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Add Image',
          child: new Icon(Icons.add_a_photo),
          onPressed: getImage,
        ),
      );
    }

  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
          sampleImage = tempImage;
        });
  }

  bool validateAndSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  Widget enableUpload(){
    return new Container(
      child: new Form(
        key: formkey,
        child: new Column(
          children: <Widget>[
            Image.file(sampleImage, height: 280.0, width: 560.0,),
            SizedBox(height: 15.0,),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value){
                return value.isEmpty ? 'Description is Required': null;
              },
              onSaved: (value){
                return _myValue = value;
              },
            ),
            SizedBox(height: 15.0,),
            RaisedButton(
              elevation: 10.0,
              child: Text("Add a new Post"),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: validateAndSave,
            ),
          ],
        ),
      )
    );
  }
}