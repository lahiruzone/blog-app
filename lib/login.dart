import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'ShowDailog.dart';

class Login extends StatefulWidget{

  final AuthenticationImplimentation auth;
  final VoidCallback onSignedIn;

  Login({
    this.auth,
    this.onSignedIn, onSignedOut
  });

  @override
  State<StatefulWidget> createState() {
   return _LoginState();
  }
}

enum FormType{
  login,
  register
}

class _LoginState extends State<Login>{


  ShowDailog dailogBox = new ShowDailog();
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  //methords
  bool validateSave(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async{
    if(validateSave()){
      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.signIn(_email, _password);
          dailogBox.information(context, "Hello", "You are logged in Successfully!");
          print("Login UserID = "+ userId);
        }else{
          String userId = await widget.auth.signUp(_email, _password);
          dailogBox.information(context, "Hello", "Your Account has been created Successfully!");
          print("Register UserID ="+ userId);
        }
        widget.onSignedIn();
      }catch(e){
        dailogBox.information(context, "Error", e.toString());
        print("Error  "+e.toString());
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
          _formType = FormType.register;
        });
  }

   void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
          _formType = FormType.login;
        });
  }

  //design
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Blog App'),
        // ),
        body: new Container(
          margin: EdgeInsets.all(30.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButton(),
            ),
          ),
        ),
      );
    }

  //
  List<Widget> createInputs(){
    return [
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 20.0,),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value){
          return value.isEmpty ? 'Email is reauired.' : null;
        },
        onSaved: (value){
          return _email = value;
        },
      ),SizedBox(height: 10.0,),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
         validator: (value){
          return value.isEmpty ? 'Password is reauired.' : null;
        },
        onSaved: (value){
          return _password = value;
        },
      ),
      SizedBox(height: 20.0,)
    ];
  }

  List<Widget> createButton(){
    if(_formType == FormType.login){
      return[
        new RaisedButton(
          child: new Text("Login", style: new TextStyle(fontSize: 20.0),),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text("Not Have an Account? Create Account", style: new TextStyle(fontSize: 14.0),),
          textColor: Colors.blue,
          onPressed:moveToRegister,
        )
      ];

    }else{
      return[
        new RaisedButton(
          child: new Text("Create an Account", style: new TextStyle(fontSize: 20.0),),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text("Have an Account? Login", style: new TextStyle(fontSize: 14.0),),
          textColor: Colors.blue,
          onPressed:moveToLogin,
        )
      ];
    }
    
  }


  Widget logo(){
    return new Hero(
      tag: 'Hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('images/logo.png'),
      ),
    );
  }


    
}


