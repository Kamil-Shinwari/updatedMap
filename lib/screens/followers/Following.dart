// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/followers/AddUsers.dart';
import 'package:googlemap/screens/followers/FollowersSearchScreen.dart';
import 'package:googlemap/screens/followers/newFollower.dart';
// import 'package:googlemap/screens/newFollowers/newProfileDetail.dart';
// import 'package:googlemap/screens/newFollowers/newProfileSetting.dart';
import 'package:uuid/uuid.dart';

class Followingscreen extends StatefulWidget {
  const Followingscreen({super.key});

  @override
  State<Followingscreen> createState() => _FollowingscreenState();
}

class _FollowingscreenState extends State<Followingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/nature.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black26, BlendMode.darken))),
                    child: Center(
                        child: Icon(
                      Icons.person_add_alt_1_sharp,
                      size: 70.r,
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Follow Others Users",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  Text(
                    "Follow Others Users to Thier Activites ,see routes and get inspired for your next ride",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Colors.deepOrange,
                      )),
                      child: Center(
                          child: Text(
                        "Explore Users",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      log("press");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User You Followed :",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("follower")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            log("press");
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => newFollowerPage(id: snapshot.data!.docs[index].get("uid"),),));
                                             
                                          },
                                          child: Card(
                                              child: ListTile(
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Name : ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    18.sp),
                                                          ),
                                                          Text(
                                                              "${snapshot.data!.docs[index].get("name")}"
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Join : ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18.sp),
                                                            ),
                                                            Text(
                                                                "${snapshot.data!.docs[index].get("joinData")}"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  leading: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.deepOrange,
                                                    child: Text(
                                                      "${snapshot.data!.docs[index].get("name").toString().substring(0, 1)}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  trailing: PopupMenuButton(
                                                      itemBuilder: (context) =>
                                                          [
                                                            PopupMenuItem(
                                                              child: Text(
                                                                  "unfollow"),
                                                              value: 1,
                                                              onTap: () {},
                                                            ),
                                                            PopupMenuItem(
                                                              onTap: () async {
                                                                var jj = Uuid();
                                                                var k = jj.v1();
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "user")
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .collection(
                                                                        "AddFriends")
                                                                    .doc(k)
                                                                    .set({
                                                                  "name": snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "name"),
                                                                  "uid": snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "uid"),
                                                                  "value": k
                                                                }).then((value) {
                                                                  log(k);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AddUsers(
                                                                          key1:
                                                                              k,
                                                                        ),
                                                                      ));
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Add Friend"),
                                                              value: 2,
                                                            )
                                                          ]))),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ]),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
