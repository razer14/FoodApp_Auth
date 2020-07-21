import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginpage/screens/sign_up.dart';
import '../widgets/roundbutton.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginpage/screens/otp.dart';


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
        backgroundColor: Colors.green,
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
                        width: 200.0,
                        height: 50.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text ('Log In your Account',style: TextStyle (
                      fontSize: 18.0, color: Colors.white
                  ),),),
                )
                ,Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
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
                  colour: Colors.lightGreen,
                  title: 'Log In',
                  onPressed: () {
                    _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text( 'By logging in,you are agreeing to our Terms of Use and Privacy Policy ',textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.white
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'or Log in with',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18.0, fontFamily: 'Russian'),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: SocialMediaButton.google(
                            size: 50.0,
                            color: Colors.white,
                            onTap: () {
                              _googleSignUp();
                            },
                          ),
                        ),
                        Container(child: Center(child: Text('Gmail',style: TextStyle (color: Colors.white),))),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: SocialMediaButton.facebook(
                            size: 50.0,
                            color: Colors.white,
                            onTap: () {
//                              print('go to faceboook');
                              signUpWithFacebook();

                            },),
                        ),
                        Container(child: Center(child: Text('Facebook',style: TextStyle (color: Colors.white),))),
                      ],
                    ),

                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context,OTPPage.id);

//                                print('go to mobile verification');
                              },
                              child: Icon(
                                Icons.phone_android,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                              child: Center(child: Text('OTP',style: TextStyle (color: Colors.white),))),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox (
                  height: 150,
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
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                      Text ('Sign Up now', style: TextStyle(fontSize: 18.0, color: Colors.lightGreenAccent),),
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


