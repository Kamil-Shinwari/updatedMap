import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/draw_Route/draw_a_route.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/signup.dart';

class WithOutLogInHomeScreen extends StatefulWidget {
  const WithOutLogInHomeScreen({super.key});

  @override
  State<WithOutLogInHomeScreen> createState() => _WithOutLogInHomeScreenState();
}

class _WithOutLogInHomeScreenState extends State<WithOutLogInHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(
          height: 30.h,
        ),
        Container(
          width: double.infinity,
          color: Colors.black,
          height: 50.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(
              "Home",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
          },
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 150.w,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/path.jpg"),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3), BlendMode.darken),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15.r)),
                      child: Icon(Icons.adjust,size: 55.sp,color: Colors.white,),
                                  ),
                                   SizedBox(height: 10.h,),
                  Text("Record a Ride",style: TextStyle(fontSize: 22.sp),),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MapsRoutesExample(title: ""),));
                      },
                      child: Container(
                        width: 150.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/path2.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3), BlendMode.darken)),
                        borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Icon(Icons.share_location,color: Colors.white,size: 50,),
                        
                      ),
                    ),
                    SizedBox(height: 10.h,),
                   Text("Explore Routes",style: TextStyle(fontSize: 22),), 
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding:  EdgeInsets.only(left:8.0.w),
          
          child: Text("Gain Access",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        Card(child: Container(height: 70.h,child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.only(left:15.0.w),
              child: Text("Log into Sync Your rides, see your ,\n stats enable sharing and more "),
            ),
            CircleAvatar(child: Icon(Icons.person,color: Colors.white,size: 40.sp,))
        ]),)),


             Card(child: Container(height: 70.h,child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                },
                child: Text("Sign In",style: TextStyle(color: Colors.deepOrange,fontSize: 20.sp),)),
            ),
            SizedBox(width: 15.w,),
           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
            },
            child: Text("Log In",style: TextStyle(color: Colors.deepOrange,fontSize: 20.sp),)),
        ]),)),

         SizedBox(height: 10.h,),
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          
          child: Text("Open Shortcut",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),

        ),
        Card(child: Container(height: 70.h,child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left:15.0.h),
              child: Text("use shortcut to access a shareed,\n tour , event , or route "),
            ),
            CircleAvatar(child: Icon(Icons.qr_code,size: 40.sp,))
        ]),)),
      ]),
    );
  }
}
