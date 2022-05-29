import 'dart:ffi';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missing/custom%20widgets/textfield.dart';
import 'package:missing/globals.dart';
import 'package:missing/providers/startup.dart';
import 'package:missing/screens/missing_people_list.dart';
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
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
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
                Container(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
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
              ],
            ),
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Image.asset(
                "assets/logo.png",
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Text(
                "Make World Smaller",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 40,
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
                    hasIcon: true,
                    obscure: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: "Password",
                    input: pass,
                    maxline: 1,
                    width: double.infinity,
                    icon: Icons.password_rounded,
                    hasIcon: true,
                    obscure: true,
                  ),
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
                    UserCredential credential;
                    try {
                      credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: user.text, password: pass.text);
                      currentUid = credential.user!.uid;
                      print("${currentUid}  CurrentUid");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        feedback('user not found');
                      } else if (e.code == 'wrong-password') {
                        feedback('wrong password');
                      }
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MissingList()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Login',
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
          ],
        ),
      ),
    );
  }
}
