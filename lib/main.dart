import 'package:flutter/material.dart';
import 'package:loginpage/screens/otp.dart';
import 'package:loginpage/screens/test.dart';
import 'screens/welcome_screen.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';



void main() => runApp(FoodToGo());

class FoodToGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        OTPPage.id: (context) => OTPPage(),
        HomeScreen.id: (context) => HomeScreen(),

      },
    );
  }
}
