import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'home.dart';
import 'ShowDailog.dart';

class UploadPhoto extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _UploadPhotoState();
  }
}

class _UploadPhotoState extends State<UploadPhoto>{

  ShowDailog dailogBox = new ShowDailog();

  File sampleImage;
  String _myValue;
  String url;
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

  void uploadStatus() async{
    if(validateAndSave()){
      dailogBox.onLoading(context);
      
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post_Images");
      
      //random key for image name
      var timeKey =  new DateTime.now();

      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString()  + "jpg").putFile(sampleImage);
      var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();

      saveToDatabase(url);
      Navigator.of(context).pop(); 
      Navigator.of(context).pop(); //Go back to home page
    }
  }

  

  void saveToDatabase(url){
    //get date and time separatly
    var dbTimeKey =  new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    //save to database
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data ={
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
    };

    ref.child("Posts").push().set(data);
  }


  Widget enableUpload(){
    return new Container(
      child: new Form(
        key: formkey,
        child: new Column(
          children: <Widget>[
            Image.file(sampleImage, height: 200.0, width: 400.0,),
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
            SizedBox(height: 80.0,),
                MaterialButton( 
                  height: 45.0,
                  minWidth: 300.0, 
                  color: Theme.of(context).primaryColor, 
                  textColor: Colors.white,
                  child: Text("Add a new Post"),
                  splashColor: Colors.greenAccent,
                  onPressed: uploadStatus,
                  shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(20.0)),
                     
                ),
          ],
        ),
      )
    );
  }
}

