import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'UploadPhoto.dart';

class Home extends StatefulWidget{
  Home({
    this.auth,
    this.onSignedOut,
  });

  final AuthenticationImplimentation auth;
  final VoidCallback onSignedOut;

  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  void logOutUser() async{
    try{
      widget.auth.signOut();
      widget.onSignedOut;
    }catch(e){
      print(e.toString());
    }
  }

  @override
    Widget build(BuildContext context) {
      
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Home'),
        ),

        body: new Container(

        ),

        bottomNavigationBar: new BottomAppBar(
          color: Colors.blue,
          child: new Container(
            margin: const EdgeInsets.only(left: 70.0, right: 70.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.local_car_wash),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: logOutUser,
                ),
                new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return new UploadPhoto();
                      })
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    }


}