import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/MyProfile_setting/photos_page.dart';
import 'package:googlemap/screens/MyProfile_setting/profile_setting.dart';
import 'package:googlemap/screens/followers/followers.dart';
import 'package:googlemap/screens/help_center.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/settings/Setting_screen.dart';
class MyMoreScreen extends StatefulWidget {
  const MyMoreScreen({super.key});

  @override
  State<MyMoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MyMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SafeArea(
          child: Container(width: double.infinity,height: 40,color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("More",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileSetting(),));
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height: 70.h,
              color: Colors.white,
              child: Row(children: [
                CircleAvatar(backgroundColor: Colors.blue,child: Text("K"),),
                SizedBox(width: 20.w,),
                Text("My Profile",style: TextStyle(fontWeight: FontWeight.bold,),)
              ],),
            ),
          ),
        ),
                InkWell(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersScreen(),));
                  },
                  child: MyCardWidgets(data: Icons.person_add,title: "Follower",)),
                InkWell(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => PhotosPage(),));
                  },
                  child: MyCardWidgets(title: "photos", data: Icons.photo)),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenter(),));
                  },
                  child: MyCardWidgets(title: "Help Center", data: Icons.help)),
                // Card(
                  
                //   child: InkWell(
                //     onTap: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(),));
                //     },
                //     child: Container(
                //       width: double.infinity,
                //       height: 70.h,
                //       padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                //       child: Align(
                //         alignment: Alignment.centerLeft,
                //         child: Row(
                //           children: [
                //             Icon(Icons.settings),
                //             SizedBox(width: 20.w,),
                //             Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                //           ],
                //         ))),
                //   ),
                // ),
                 InkWell(

                  onTap: () async{
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                    });
                  },
                   child: Card(
                    
                    child: Container(
                      width: double.infinity,
                      height: 70.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(width: 20.w,),
                            Text("LogOut",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ))),
                                 ),
                 ),
      ]),
    );
  }
}

class MyCardWidgets extends StatelessWidget {
  final String title;
  final IconData data;

  const MyCardWidgets({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height: 70,
            color: Colors.white,
            child: Row(children: [
              Icon(data),
              SizedBox(width: 20,),
              Text("$title",style: TextStyle(fontWeight: FontWeight.bold,),)
            ],),
          ),
        );
  }
}