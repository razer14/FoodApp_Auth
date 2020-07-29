import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/widgets/authservice.dart';
import 'package:loginpage/widgets/roundbutton.dart';


class OTPPage extends StatefulWidget {
  static const String id = 'otp_screen';
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;
  FocusNode myFocusNode = new FocusNode();

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'images/flogo.png',
                          width: 300.0,
                          height: 70.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox (height: 25,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text ('MOBILE VERIFICATION',style: TextStyle(fontSize: 18.0, color: Colors.white),),
              ),
              SizedBox (height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  style: TextStyle (color: Colors.black) ,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    this.phoneNo = value;
                  },
                  decoration: InputDecoration (
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)), labelText: 'Enter Phone Number',labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.black,
                  ),),
                ),
              ),
              codeSent ? Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      this.smsCode = value;
                    },
                    decoration: InputDecoration (
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)), labelText: 'Enter OTP',labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.black
                    ),),

                  )) : Container(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RoundedButton(
                      colour: Colors.green,
                      title: (codeSent) ? 'Login' : 'Verify',
                      onPressed: (){

                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                        },
                    ),
                  ),)
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
