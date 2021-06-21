import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spark_app/LogIn_Screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:spark_app/User_Profile.dart';





void main()=>runApp(MaterialApp(home: HomePage(),));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     // backgroundColor: primaryColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/WallPa.jpg"),fit: BoxFit.cover, )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'assets/SparkF.png',
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            Text(
              'Welcome ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              ' The Digital World of Spark Foundation !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            new SizedBox(
              width: 250,
            height: 50,
             child: new RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              elevation: 0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>LogInScreen()));
              },
              color: Colors.transparent,
               shape: RoundedRectangleBorder(
                 side: BorderSide(color: Colors.white,width: 2)
               ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            ),
            ),
            SizedBox(
                height: 80),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildFooterLogo(),
            ),
          ],
        ),
      ),

    );
  }
}


  _signInWithGoogle() async {

     final GoogleSignInAccount googleUser = await googleSignIn.signIn();
     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

     final AuthCredential credential = GoogleAuthProvider.getCredential(
     idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

     final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
     print("signed in " + user.displayName);

     return user;
  }

Future<void> signUpWithFacebook() async {
  try {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,

      );
      final FirebaseUser user = (await FirebaseAuth.instance
          .signInWithCredential(credential)).user;
      print('signed in ' + user.displayName);
      return user;
    }
  } catch (e) {
    print(e.message);
  }
}


_buildFooterLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'assets/SparkF.png',
        height: 25,
      ),
      Text('By Spark Foundation ',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold)),
    ],
  );
}

