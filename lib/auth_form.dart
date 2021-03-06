import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AuthForm extends StatefulWidget {
  var isloading;
  final void Function(
          String email, String password, String username, bool islogin)
      saveauthform;
  AuthForm(this.saveauthform, this.isloading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  String _useremail = '';
  String _username = '';
  String _userpassword = '';
  var _islogin = true;
  void _submit() {
    var status = _formkey.currentState;
    // log("status " + status.toString());
    final isvalid = status?.validate();
    FocusScope.of(context).unfocus();
    // log("isvalid " + isvalid.toString());

    if (isvalid == true) {
      _formkey.currentState?.save();
      log(_useremail + " " + _userpassword);
      widget.saveauthform(_useremail, _username, _userpassword, _islogin);
      _formkey.currentState?.reset();
    }
    // FirebaseFirestore.instance.collection(collectionPath)
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) return "invalid email";
                        return null;
                      },
                      onSaved: (val) {
                        if (val != null) _useremail = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Adress'),
                    ),
                    if (_islogin == true)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (val) {
                          if (val == null || val.isEmpty) return "invalid";
                          return null;
                        },
                        onSaved: (val) {
                          if (val != null) _username = val;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (val) {
                        if (val == null || val.isEmpty || val.length < 7)
                          return 'length must be 7 or greater';
                        return null;
                      },
                      onSaved: (val) {
                        if (val != null) _userpassword = val;
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(height: 10),
                    if (widget.isloading == true)
                      Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            _islogin == true ? 'Login' : 'Signup',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink))),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(
                        _islogin == true
                            ? 'Create New Account'
                            : 'Already have account',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
