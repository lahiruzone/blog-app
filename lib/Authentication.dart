import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationImplimentation{
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Authentication implements AuthenticationImplimentation{

 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 Future<String> signIn(String email, String password) async{
   final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
   return user.uid;
 } 

 Future<String> signUp(String email, String password) async{
   FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));
   return user.uid;
 }

 Future<String> getCurrentUser() async{
   FirebaseUser user = await _firebaseAuth.currentUser();
   return user.uid;
 }

 Future<void> signOut() async{
   _firebaseAuth.signOut();
 }

}