import 'package:chat_app/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  var isloading = false;

  void _submitAuthForm(
      String email, String username, String password, bool islogin) async {
    final auth = FirebaseAuth.instance;
    var authResult;
    setState(() {
      isloading = true;
    });
    try {
      log("check 1");
      log(password);
      if (islogin == true) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        log("this ran");
        FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .set({'username': username, 'email': email});
        log("request successful");
      }
    } on PlatformException catch (err) {
      var mess = "Please check credentials";
      if (err.message != null) {
        mess = err.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mess),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isloading = false;
      });
    } //for invalid username
    catch (e) {
      print(e);
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          color: Theme.of(context).primaryColor,
          child: AuthForm(_submitAuthForm, isloading)),
    );
  }
}
