import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginpage/screens/sign_in.dart';
import '../widgets/roundbutton.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {

  static const String id = 'registration_screen';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth=FirebaseAuth.instance;
  String lastname;
  String firstname;
  String email;
  String mobilenumber;
  String password;
  String confirmpassword;

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
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text ('Create your Account',style: TextStyle (
                      fontSize: 18.0, color: Colors.white
                  ),),),
                )
                ,CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.text,labelText: 'Last Name',onChange: (value){
                  lastname=value;
                },obscureText: false,),
                CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.text,labelText: 'First Name',onChange: (value){
                  firstname= value ;
                },obscureText: false,),
                CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.emailAddress,labelText: 'Email',
                onChange: (value){
                  email=value;
                },obscureText: false),
                CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.phone,labelText: 'Mobile Number',onChange: (value){
                  mobilenumber=value;
                },obscureText: false,),
                CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.text,labelText: 'Password',onChange: (value){
                  password=value;
                },obscureText: true,),
                CustomTextField(myFocusNode: myFocusNode,keyboardType: TextInputType.text,labelText: 'Confirm Password',
                onChange: (value){
                  confirmpassword=value;
                },obscureText: true,),

                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  colour: Colors.lightGreen,
                  title: 'Sign Up',
                  onPressed: () {
//                    print (email);
//                    print (password);
                  _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text( 'By Signing up,you are agreeing to our Terms of Use and Privacy Policy ',textAlign: TextAlign.center,
                    style: TextStyle (
                      color: Colors.white
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.pushNamed(context,SignInPage.id);
                  },
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '  Already have an account?  ',
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                        Text ('Log In', style: TextStyle(fontSize: 18.0, color: Colors.lightGreenAccent),),
                      ],
                    ),
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

