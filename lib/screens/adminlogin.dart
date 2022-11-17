import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/adminpanel.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/signup.dart';
import 'package:googlemap/utils/colors.dart';
class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network('https://ampridesusa.com/wp-content/uploads/2022/07/amprideslogo.png',fit: BoxFit.fill,height: 150.0,width:150.0,),
              ),
              txtField(emailController, 'Enter Email'),
              txtField(passwordController, 'Enter Password'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are You a User?"),
                  CupertinoButton(
                      child: Text('User Login',style:txtstyle,),
                      onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));}),
                ],),
              CupertinoButton(child: Container(
                decoration: containerDeco,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Admin Panel Login',style:TextStyle(color: Colors.white,fontSize: 20.0)),
                ),
              ), onPressed: ()async{

                if(emailController.text=="admin" && passwordController.text=="admin123"){
                  try{
                    showDialog(context: context, builder: (context){
                      return Center(child: CircularProgressIndicator(color: Colors.red,),);
                    });
                    // UserCredential usercred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                    // if(usercred.user!=null){
                    //  QuerySnapshot query = await FirebaseFirestore.instance.collection('admin').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
                    //  if(query.docs.length>0){
                       Navigator.pop(context);
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminPanel()));
                    //  }
                    //  else{
                    //    Navigator.pop(context);
                    //    FirebaseAuth.instance.signOut();
                    //    Fluttertoast.showToast(msg: 'Wrong Admin Credientials!');
                    //  }
                    
                      // }
                  }catch(e){
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg:e.toString());
                  }
                }else{
                  Fluttertoast.showToast(msg: "Wrong email or password");
                }

              }),
            ],
          ),
        ),
      ),
    );
  }
}
