import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:missing/loginpage.dart';
import 'package:missing/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    theme: FlexThemeData.light(
        scheme: FlexScheme.greyLaw,
        useMaterial3: true,
      ),
    // The Mandy red, dark theme.
    //darkTheme: FlexThemeData.dark(scheme: FlexScheme.mango),
    // Use dark or light theme based on system setting.

    home: LoginPage(),
  ));
}
