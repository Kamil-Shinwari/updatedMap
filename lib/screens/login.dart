import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/HomePageWithOutLogin/withoutLogInHomePage.dart';
import 'package:googlemap/screens/MyHomePagee.dart';
import 'package:googlemap/screens/adminlogin.dart';
import 'package:googlemap/screens/adminpanel.dart';
import 'package:googlemap/screens/draw_Route/draw_a_route.dart';
import 'package:googlemap/screens/explore/explore.dart';
import 'package:googlemap/screens/followers/followers.dart';
import 'package:googlemap/screens/history.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/navigationBarScreen.dart';
// import 'package:googlemap/screens/newFollowers/newProfileSetting.dart';
import 'package:googlemap/screens/settings/MorePage.dart';
import 'package:googlemap/screens/showing_history_details/show_history_details.dart';
import 'package:googlemap/screens/signup.dart';
import 'package:googlemap/screens/webview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../utils/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // var x=Uuid();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Image.network(
                  'https://ampridesusa.com/wp-content/uploads/2022/07/amprideslogo.png',
                  fit: BoxFit.fill,
                  height: 150.0,
                  width: 150.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Book Your Ride Now "),
                  CupertinoButton(
                      child: Text(
                        'AmpRides',
                        style: txtstyle,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => webView()));
                      }),
                  // onPressed: ()async{
                  //   bool check;
                  //   try{
                  //     check=await launchUrl(Uri.parse('https://ampridesusa.com/'),mode: LaunchMode.inAppWebView);
                  //
                  //   }catch(e){
                  //     check=false;
                  //     print(e);
                  //   }
                  //
                  // }),
                ],
              ),
              txtField(emailController, 'Enter Email'),
              txtField(passwordController, 'Enter Password'),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminLogin()));
                          },
                          child: Text(
                            'Admin Panel Login',
                            style: txtstyle,
                            textAlign: TextAlign.end,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an id?"),
                  CupertinoButton(
                      child: Text(
                        'Sign Up',
                        style: txtstyle,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      }),
                ],
              ),
              CupertinoButton(
                  child: Container(
                    decoration: containerDeco,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Login',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                  onPressed: () async {
                    if (emailController.text != null &&
                        passwordController.text != null) {
                      try {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            });
                        UserCredential usercred = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (usercred.user != null) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>NavigationBarScreen()));
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
