import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:missing/loginpage.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      Provider<MissingPeople>(
        create: (_) => MissingPeople(),
      ),
    ],
    child: MaterialApp(
      theme: FlexThemeData.dark(
        scheme: FlexScheme.vesuviusBurn,
        useMaterial3: true,
      ),
      // The Mandy red, dark theme.
      //darkTheme: FlexThemeData.dark(scheme: FlexScheme.mango),
      // Use dark or light theme based on system setting.

      home: LoginPage(),
    ),
  ));
}
