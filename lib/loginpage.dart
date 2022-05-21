import 'dart:ffi';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missing/providers/startup.dart';
import 'package:missing/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();

  final pass = TextEditingController();
  String error = "";

  void feedback(String s) {
    setState(() {
      error = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage())),
                      child: Text('SignUp',
                          style: TextStyle(
                            fontSize: 17,
                          )
                          //color: Colors.white
                          ),
                    ),
                  ),
                  decoration: BoxDecoration(

                      //color: Colors.black
                      ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('SignIn',
                          style: TextStyle(
                            fontSize: 17,
                          )
                          //color: Colors.white
                          ),
                    ),
                  ),
                  decoration: BoxDecoration(

                      //color: Colors.black
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    //shadowColor: Colors.grey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: user,
                        style: TextStyle(fontSize: 20),
                        //cursorColor: Colors.black,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.login,
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 15),
                            floatingLabelStyle: TextStyle(fontSize: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            //focusColor: Colors.white,
                            //hoverColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            //fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    //shadowColor: Colors.grey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: pass,
                        style: TextStyle(fontSize: 20),
                        //cursorColor: Colors.black,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.password,
                              //color: Colors.black,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 15),
                            floatingLabelStyle: TextStyle(fontSize: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            //focusColor: Colors.white,
                            //hoverColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            //fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0)),
                      ),
                    ),
                  ),
                )
              ]),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              child: Text(
                error,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              width: 300,
              height: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AsyncButtonBuilder(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: user.text, password: pass.text);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      feedback('user not found');
                    } else if (e.code == 'wrong-password') {
                      feedback('wrong password');
                    }
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 17),
                ),
                builder: (context, child, callback, _) {
                  return ElevatedButton(onPressed: callback, child: child);
                },
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    );
  }
}
