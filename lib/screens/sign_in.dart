import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginpage/screens/sign_up.dart';
import '../widgets/roundbutton.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginpage/screens/otp.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class SignInPage extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _SignInPageState createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Image.asset(
                        'images/flogo.png',
                        width: 300.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                ),
                SizedBox (height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email=value;
                    },
                    decoration: InputDecoration (
                      filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)), labelText: 'Email',labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.black
                    ),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), labelText: 'Password',labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.black
                    ),),
                  ),
                ),

                RoundedButton(
                  colour: Colors.green,
                  title: 'Log In',
                  onPressed: () {
                    _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'or Log in with',
                    style: TextStyle(
                        color: Colors.black, fontSize: 18.0, fontFamily: 'Russian'),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column (
                  children: <Widget>[
                   SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        _googleSignUp();
                        Navigator.pushNamed(context, OTPPage.id);
                      },
                    ),
                    SizedBox (
                      height: 10,
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      onPressed: () {
                        signUpWithFacebook();
                        Navigator.pushNamed(context, OTPPage.id);
                      },
                    ),
                  ],
                ),
                SizedBox (
                  height:150,
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.pushNamed(context,SignUpPage.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '  Don\'t have an account?  ',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                      Text ('Sign Up now', style: TextStyle(fontSize: 18.0, color: Colors.green),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future<void> _googleSignUp() async {
  try {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ],
    );
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    return user;
  }catch (e) {
    print(e.message);
  }
}

Future<void> signUpWithFacebook() async{
  try {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logIn(['email']);
    if(result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      print( user.displayName);
      return user;
    }
  }catch (e) {
    print(e.message);
  }
}


