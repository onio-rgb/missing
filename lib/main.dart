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
      theme: FlexThemeData.light(
  scheme: FlexScheme.blueWhale,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
),
darkTheme: FlexThemeData.dark(
  scheme: FlexScheme.blueWhale,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      // The Mandy red, dark theme.
      //darkTheme: FlexThemeData.dark(scheme: FlexScheme.mango),
      // Use dark or light theme based on system setting.

      home: LoginPage(),
    ),
  ));
}
