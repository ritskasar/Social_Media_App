import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spark_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spark_app/User_Profile.dart';



class LogInScreen extends StatefulWidget {
  @override
  _LogInScreen createState() => _LogInScreen();

}

class _LogInScreen extends State<LogInScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation:0,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/WallPa.jpg"),fit: BoxFit.cover, )),

          alignment: Alignment.topCenter,
          // margin: EdgeInsets.symmetric(horizontal: 30),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to Spark Foundation and continue',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize: 22),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and password below to continue to the The Spark Foundation Digital World !',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize: 11),
                ),
                SizedBox(
                  height: 25,
                ),

                _buildTextField(
                    nameController, Icons.account_circle, 'Email'),
                SizedBox(height: 12),
                _buildTextField(passwordController, Icons.lock, 'Password'),
                SizedBox(height: 9),
                Align(alignment: Alignment.centerRight,child:Text('Forgot Password',
                  style: TextStyle(color: Colors.white,fontSize:11),)),
                SizedBox(height: 18),
                new SizedBox(
                  width: 300,
                  height: 50,
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () async {

                      FirebaseUser firebaseUser;
                      firebaseAuth.signInWithEmailAndPassword(email: 'demo@gmail.com', password: 'demo123').then((authResult){
                        setState(() {
                          firebaseUser = authResult.user;
                        });
                        FirebaseAuth.instance.signOut();
                       // Navigator.push(context,MaterialPageRoute(builder: (context)=>TextMessage));
                        TextMessage(context);
                        print(firebaseUser.email);
                        print("user login successfully!!");
                      });
                    },
                    color:Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white,width: 2)
                    ),
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),

                ),
                SizedBox(height: 18),
                new SizedBox(
                  width: 300,
                  height: 50,
                  child: RaisedButton(

                    elevation: 0,
                    onPressed: () async {
                      //Here goes the logic for Google SignIn

                      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
                      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                      final AuthCredential credential = GoogleAuthProvider.getCredential(
                          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

                      final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
                      print("signed in " + user.displayName);
                      TextMessage(context);
                      FirebaseAuth.instance.signOut();
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=>UserProfilePage()));
                      Image.network(googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,);
                      Text(googleSignIn.currentUser.displayName);

                      return user;
                    },
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white,width: 2)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.google,color: Colors.white,),
                        SizedBox(width: 12),
                        Text('Sign-in with Google',
                            style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height:18),
                new SizedBox(
                  width: 300,
                  height: 50,
                  child: MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.facebook,size: 30,color: Colors.white,),
                        SizedBox(width: 12),
                        Text(
                          'Sign up with Facebook ',
                          style: TextStyle(fontSize:15),
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                    color:Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white,width: 2)
                    ),
                    padding: EdgeInsets.all(10),
                    onPressed: () async{
                        signUpWithFacebook();
                    },
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
        ),

    );

  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/SparkF.png',
          height: 28,
        ),
        Text('By Spark Foundation ',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color:Colors.black12, border: Border.all(color: Colors.black)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
  Future<void> TextMessage(BuildContext context) async {

    AlertDialog alertDialog = AlertDialog(
      title: Text(" LogIn "),
      content: Text("Your LogIn Succesfull"),
    );

    showDialog(context: context,builder: (BuildContext context)
    {
      return alertDialog;
    }
    );
  }

}






