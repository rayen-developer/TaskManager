import 'package:flutter/material.dart';
import 'package:to_do_list/model/user.dart';
import 'package:to_do_list/screen/Authscreen.dart';
import 'package:to_do_list/screen/HomeScreen.dart';
import 'package:to_do_list/service/userservice.dart';
import 'package:to_do_list/source/app.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _userNameController = TextEditingController();
  var _userPasswordController = TextEditingController();
  var _userService = UserServise();

  List<User> _userList = List<User>();
  getAllUsers() async {
    _userList = List<User>();
    var categories = await _userService.readUser();
    categories.forEach((u) {
      setState(() {
        var userModel = User();
        userModel.userName = u['username'];
        userModel.password = u['password'];
        userModel.id = u['id'];
        _userList.add(userModel);
      });
    });
  }

  _userExist(User user) async {
    _userList.forEach((u) {
      setState(() {
        if (u == user) {
          print('ok');
          App.loginState = 1;
          App.username = user.userName;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  var userObject = User();
                  userObject.userName = _userNameController.text;
                  userObject.password = _userPasswordController.text;
                  _userExist(userObject);
                  if (App.loginState == 1) {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                color: Color.fromRGBO(242, 237, 215, 1),
                child: Text('login'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AuthScreen()));
        },
        child: Icon(Icons.account_circle),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }
}
