import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/HomePageWithOutLogin/withoutLogInHomePage.dart';
import 'package:googlemap/screens/MyHomePagee.dart';
import 'package:googlemap/screens/MyProfile_setting/profile_detail_page.dart';
import 'package:googlemap/screens/MyProfile_setting/profile_setting.dart';
import 'package:googlemap/screens/adminlogin.dart';
import 'package:googlemap/screens/adminpanel.dart';
import 'package:googlemap/screens/draw_Route/draw_a_route.dart';
import 'package:googlemap/screens/draw_a_polyline.dart';
import 'package:googlemap/screens/explore/explore.dart';
// import 'package:googlemap/screens/fetchadata.dart';
import 'package:googlemap/screens/help_center.dart';
import 'package:googlemap/screens/history.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/navigationBarScreen.dart';
import 'package:googlemap/screens/paractice/ontap_add_marker.dart';
import 'package:googlemap/screens/polyline.dart';
// import 'package:googlemap/screens/provider/count_provider.dart';
import 'package:googlemap/screens/settings/MorePage.dart';
import 'package:googlemap/screens/settings/uploadPage.dart';
import 'package:googlemap/screens/signup.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var check=true;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => 
       MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.red
          ),
        ),
        home:
        FirebaseAuth.instance.currentUser!=null?
        FutureBuilder(
          future: FirebaseFirestore.instance.collection('admin').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context,snapshot){
            QuerySnapshot querySnapshot;
            if(snapshot.connectionState==ConnectionState.active || snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData){
                querySnapshot=snapshot.data as QuerySnapshot;
                if(FirebaseAuth.instance.currentUser!=null && querySnapshot.docs.length>0){
                  return AdminPanel();
                }
                else if(FirebaseAuth.instance.currentUser!=null && querySnapshot.docs.length<=0){
                  return Login();
                }
                else{
                  return NavigationBarScreen();
                }
              }
              else if(FirebaseAuth.instance.currentUser!=null){
                return NavigationBarScreen();
              }
              else{
                return WithOutLogInHomeScreen();
              }
            }
            else{
              return Center(
                child: Container(
                  child: CircularProgressIndicator(color: Colors.red,),
                ),
              );
            }
        
          },
        ):Login(),
          //AdminPanel():
        // FirebaseAuth.instance.currentUser!.uid!=null && check == false?
        // MyHomePage():
        // Login(),
        //home: const MyHomePage(),
      ),
    );
  }
}






