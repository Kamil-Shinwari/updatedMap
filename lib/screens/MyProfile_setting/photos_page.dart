import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/utils/colors.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(title: Text("Photos")),
          body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("History")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1,
                crossAxisSpacing: 10.0,
                children: snapshot.data!.docs.map((document) {
                  return GestureDetector(
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          border: Border.all(color: Colors.red,width: 1),
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                              image: NetworkImage(document["url"]),
                              fit: BoxFit.cover)
                          ),
                          
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      )),
    );
  }
}
