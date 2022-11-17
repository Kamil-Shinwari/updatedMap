import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff94efff),
      appBar: AppBar(title: Text("Edit_info")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Center(
          child: Container(
            width: 350.w,
            height: 250.h,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          label: Text("Display Name"),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: EmailController,
                      decoration: InputDecoration(
                          label: Text("email"),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: PassController,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            if (nameController.text != null &&
                                EmailController.text != null &&
                                PassController.text != null) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection("userDetails")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "email": EmailController.text,
                                  "name": nameController.text,
                                  "password": PassController.text
                                }).then((value) {
                                 Fluttertoast.showToast(msg: "value Updated");
                                 Navigator.pop(context);
                                });
                              } on FirebaseAuthException catch (e) {
                               Fluttertoast.showToast(msg: e.message.toString());
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.red, width: 1),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              "Confirm",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            )),
                          ),
                        )),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white,
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            )),
                          ),
                        )),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
