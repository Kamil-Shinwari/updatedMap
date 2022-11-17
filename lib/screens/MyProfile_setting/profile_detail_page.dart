import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/utils/colors.dart';
import 'package:http/http.dart';

String? email;
String? name;
String? rides;
String? totalDistance;
String? photoTaken;
DocumentSnapshot? snap;

class ProfileDetailPage extends StatefulWidget {
  final String? id;

  const ProfileDetailPage({super.key, this.id});


  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  
  @override
  getdata() async {
    snap = await FirebaseFirestore.instance
        .collection("userDetails")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    //  log(snap!.get("email"));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 1,
            child: Container(
              width: double.infinity,
              height: 90.h,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 90.h,
                          color: Colors.black38,
                          child: Center(
                              child: Text(
                            snap == null
                                ? "Ahmad"
                                : snap!.get("name").toString().substring(0, 1),
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap == null
                                ? "Ahmad"
                                : snap!.get("name").toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.deepOrange),
                          ),
                          Text(
                            "Khyber PukhtunKhwa ",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "Member Since : ${snap == null ? "No date" : snap!.get("join")} ",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Text(
            "Stat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            color: Colors.grey,
            height: 150.h,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              snap == null
                                  ? "0"
                                  : snap!.get("rides").toString(),
                            ),
                            Text("Rides",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: [
                            Text(snap == null
                                ? "0.00 M"
                                : snap!
                                        .get("totalDistance")
                                        .toString()
                                        .substring(0, 5) +
                                    " M"),
                            Text("distance Traveled",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("00 M"),
                            Text("Total Time",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        // Column(children: [
                        //      Text("00 M"),
                        // Text("Climbed",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18)),

                        // ],),
                        Column(
                          children: [
                            Text(snap == null
                                ? "0 Photo"
                                : snap!.get("phots").toString() + "  Photos"),
                            Text("Photos Taken",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
          )
        ],
      ),
    ));
  }
}
