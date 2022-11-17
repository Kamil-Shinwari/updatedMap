import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/followers/Following.dart';
import 'package:googlemap/screens/followers/followers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: "Email Address"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Center(
                child: Text(
                  "Search",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.lightBlue),
                ),
              )),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("userDetails")
                .where("name", isEqualTo: emailController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                  if (datasnapshot.docs.length > 0) {
                    Map<String, dynamic> userMap =
                        datasnapshot.docs[0].data() as Map<String, dynamic>;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: datasnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Row(
                              children: [
                                Text("Name : "),
                                Text(datasnapshot.docs[index].get("name")),
                              ],
                            ),
                            SizedBox(height: 5,),
                            InkWell(
                              onTap: () async{
                                await FirebaseFirestore.instance.collection("user").
                                doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("follower")
                                .add({
                                  "uid":datasnapshot.docs[index].get("uid"),
                                  "name":datasnapshot.docs[index].get("name"),
                                  "joinData":datasnapshot.docs[index].get("join"),
                                  "block":"0",
                                }).then((value) {
                                  Fluttertoast.showToast(msg: " you follow ${datasnapshot.docs[index].get("name")}  ");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersScreen(),));
                                });
                              },
                              child: Container(height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange,width: 1,),color: Colors.deepOrange,borderRadius: BorderRadius.circular(20),),
                              child: Center(child: Text("Follow",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.sp),)),
                              ),
                            )
                          ],),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No Record found"));
                  }
                } else if (snapshot.hasError) {
                  return Text("an error occured");
                } else {
                  return Text("No result fount");
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ]),
    );
  }
}
