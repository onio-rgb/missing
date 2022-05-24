import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:missing/custom%20widgets/textfield.dart';
import 'package:missing/globals.dart';
import 'package:missing/screens/missing_people_list.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final user = TextEditingController();

  final pass = TextEditingController();
  String error = "";
  final cpass = TextEditingController();
  void feedback(String s) {
    setState(() {
      error = s;
    });
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CustomTextField(
                  label: "Email",
                  input: user,
                  maxline: 1,
                  width: double.infinity,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: "Password",
                  input: pass,
                  maxline: 1,
                  width: double.infinity,
                  icon: Icons.password,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: "Confirm Password",
                  input: cpass,
                  maxline: 1,
                  width: double.infinity,
                  icon: Icons.password,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AsyncButtonBuilder(
                  onPressed: () async {
                    try {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MissingList()),
                        (Route<dynamic> route) => false,
                      );
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: user.text,
                        password: pass.text,
                      );
                      Map<String, dynamic> m = {
                        'email': user.text,
                        'pass': pass.text
                      };
                      db
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(m);
                      currentUid = FirebaseAuth.instance.currentUser!.uid;
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        feedback('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        feedback('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
