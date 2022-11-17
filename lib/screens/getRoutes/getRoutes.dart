import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GetRoutes extends StatefulWidget {
  const GetRoutes({super.key});

  @override
  State<GetRoutes> createState() => _GetRoutesState();
}

class _GetRoutesState extends State<GetRoutes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Routes")
            .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Loading..."),
                  SizedBox(
                    height: 50.0.h,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:  EdgeInsets.all(10.0.h),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1)),
                    child: Padding(
                      padding:  EdgeInsets.all(8.0.h),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          height: 90.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.docs[index]["lat"]),
                                  fit: BoxFit.cover)),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 90.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Title : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp),
                                        ),
                                        Text(snapshot.data!.docs[index]
                                            ["title"])
                                      ],
                                    ),
                                   
                                   
                                  
                                  ]),
                            )),
                      ]),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
        
    );
  }
}