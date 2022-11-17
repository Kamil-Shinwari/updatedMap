import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import 'FollowersSearchScreen.dart';

class AddUsers extends StatefulWidget {
  final String? key1;

  const AddUsers({super.key, this.key1});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0.h),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
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
                  "Add Friends",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                Text(
                  " Add Others Users as a Friends to see Thier Activites ,see routes and get inspired for your next ride",
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
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Friends :",
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
                                  .collection("AddFriends")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: InkWell(
                                            onTap: (){
                                              log("press");
                                            },
                                            child: ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                  FontWeight.bold,
                                                              fontSize: 18.sp),
                                                        ),
                                                        Text(
                                                            "${snapshot.data!.docs[index].get("name")}"
                                                                .toString()),
                                                      ],
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
                                                    itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                            onTap: () async {
                                                              log("new");
                                                                                
                                                              //  String uadd= snapshot.data!.docs[index].get("name");
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "user")
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .collection(
                                                                      "AddFriends")
                                                                  .doc(
                                                                      widget.key1)
                                                                  .delete();
                                                              setState(() {});
                                                            },
                                                            child:
                                                                Text("UnFriend"),
                                                            value: 2,
                                                          )
                                                        ])),
                                          ));
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
    );
  }
}
