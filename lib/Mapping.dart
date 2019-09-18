import 'package:blog/Authentication.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Mapping extends StatefulWidget{

  final AuthenticationImplimentation auth;

  Mapping({
    this.auth,
  });

  State<StatefulWidget> createState(){
    return _MappingState();
  } 

}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _MappingState extends State<Mapping>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  void initState(){

    super.initState();
      widget.auth.getCurrentUser().then((firebaseUserID){
        setState(() {
                  authStatus = firebaseUserID == null ? AuthStatus.notSignedIn: AuthStatus.signedIn;
                });
      });
  }

  void _signedIn(){
    setState(() {
          authStatus = AuthStatus.signedIn;
        });
  }

  void _signOut(){
    setState(() {
          authStatus = AuthStatus.notSignedIn;
        });
  }

  @override
    Widget build(BuildContext context) {
      
      switch(authStatus){
        case AuthStatus.notSignedIn:
          return new Login(
            auth: widget.auth,
            onSignedIn: _signedIn
          );

        case AuthStatus.signedIn:
          return new Home(
            auth: widget.auth,
            onSignedOut: _signOut,
          );
      }
    }

    

}