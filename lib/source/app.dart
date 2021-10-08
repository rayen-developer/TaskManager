import 'package:flutter/material.dart';
import 'package:to_do_list/screen/Authscreen.dart';
import 'package:to_do_list/screen/HomeScreen.dart';
import 'package:to_do_list/screen/loginScreen.dart';


class App extends StatelessWidget {
  static int loginState=0;
  static String username;
 Widget _state(){
   print(loginState);
    if(loginState==1){
      return  HomeScreen();
    }else{
      return  LoginScreen();
    }
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _state(),
    );

  }
}
