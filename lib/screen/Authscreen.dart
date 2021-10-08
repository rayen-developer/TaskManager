import 'package:flutter/material.dart';
import 'package:to_do_list/model/user.dart';
import 'package:to_do_list/screen/loginScreen.dart';
import 'package:to_do_list/service/userservice.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _userNameController = TextEditingController();
  var _userPasswordController = TextEditingController();
  var _userrePasswordController = TextEditingController();
  var _user = User();

  var user;

  __sucessFormDialod(BuildContext context, message) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          String text;
          String text1;
          if (message == 1) {
            text = 'login';
            text1 = 'account created';
          } else {
            text = 'return';
            text1 = 'echec !!!!';
          }

          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (message == 1) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(text),
                color: Colors.black26,
              ),
            ],
            title: Text(text1),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Write Todo Username',
                  )),
              TextField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Password', hintText: 'Write a Password'),
                  obscureText: true),
              TextField(
                  controller: _userrePasswordController,
                  decoration: InputDecoration(
                    labelText: 'RePassword',
                    hintText: 'ReWrite the Password',
                  ),
                  obscureText: true),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  var userObject = User();
                  userObject.userName = _userNameController.text;
                  userObject.password = _userPasswordController.text;

                  if (_userrePasswordController.text ==
                      _userPasswordController.text) {
                    print(userObject);
                    var _userservice = UserServise();
                    var result = await _userservice.saveUser(userObject);
                    if (result > 0) {
                      __sucessFormDialod(context, 1);
                    }
                  } else {
                    __sucessFormDialod(context, 0);
                  }
                },
                color: Color.fromRGBO(242, 237, 215, 1),
                child: Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
