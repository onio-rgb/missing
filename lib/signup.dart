import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future_button/future_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  final user = TextEditingController();
  final pass = TextEditingController();
  final cpass = TextEditingController();

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
                      onPressed: () {},
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
            height: 50,
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
                        controller: cpass,
                        style: TextStyle(fontSize: 20),
                        //cursorColor: Colors.black,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.password,
                              //color: Colors.black,
                            ),
                            labelText: 'Confirm Password',
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
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FutureRaisedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: user.text,
                        password: pass.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
