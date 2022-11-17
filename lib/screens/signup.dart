import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/navigationBarScreen.dart';

import '../utils/colors.dart';
import 'adminlogin.dart';
import 'homepage.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network('https://ampridesusa.com/wp-content/uploads/2022/07/amprideslogo.png',fit: BoxFit.fill,height: 150.0,width:150.0,),
              ),
              txtField(nameController,'Enter Your Name'),
              txtField(emailController,'Enter Your Email'),
              txtField(passwordController,'Enter Password'),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                          },
                          child: Text('Admin Panel Login',style:txtstyle,textAlign: TextAlign.end,)),


                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an Account?"),
                  CupertinoButton(
                      child: Text('Log In',style:txtstyle,),
                      onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));}),
                ],),
              CupertinoButton(child: Container(decoration:containerDeco,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign Up',style:TextStyle(color: Colors.white,fontSize: 20.0)),
              )), onPressed: ()async{
                if(emailController.text!=''&&passwordController!=''){
                  UserCredential usercred;
                 try {
                   usercred=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                    showDialog(context: context, builder: (context){
                      return Center(child: CircularProgressIndicator(color: Colors.red,),);
                    });
                    DateTime today = DateTime.now();
                    String dateStr = "${today.day}-${today.month}-${today.year}";
                   if(usercred.user!=null){
                    await FirebaseFirestore.instance.collection('userDetails').doc(usercred.user!.uid).set(
                         {  

                           'uid':usercred.user!.uid,
                           'name':nameController.text,
                           "join":dateStr,
                           'totalDistance':0.0,
                           'rides':"",
                           'totalTime':"",
                           "phots":"",
                           "location":"",
                         }).then((value) => Fluttertoast.showToast(msg: 'User created successfuly'));
                     Navigator.pop(context);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationBarScreen()));
                   }

                 }catch(e){

                   Fluttertoast.showToast(msg:e.toString());
                 }

                }
                else{
                  Fluttertoast.showToast(msg:'Fields Empty');
                }

              }),
                ],
          ),
        ),
      ),
    );
  }
}

Widget txtField(TextEditingController controller,String txt){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      style: TextStyle(
        color: Colors.red,
      ),
      controller: controller,
      cursorColor: Colors.red,
      decoration: InputDecoration(
          hintText: txt,
          hintStyle: TextStyle(
            color: Colors.red,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20.0),
      ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
      ),
    ),
  );

}
