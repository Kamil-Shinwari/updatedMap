import 'package:flutter/material.dart';import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/utils/colors.dart';

class newPhotoPage extends StatefulWidget {
  final String? id;

  const newPhotoPage({super.key, this.id});

  @override
  State<newPhotoPage> createState() => _newPhotoPageState();
}

class _newPhotoPageState extends State<newPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text("Photos")),
          body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(widget.id)
            .collection("History")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
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
