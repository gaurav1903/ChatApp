import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

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
    final isvalid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isvalid == true) {
      _formkey.currentState?.save();
    }
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
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@'))
                      return "invalid email";
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
                ElevatedButton(
                    onPressed: null,
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
