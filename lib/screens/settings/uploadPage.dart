import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/navigationBarScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

int rideCount = 0;
int photos = 0;
int? totalDis;
DocumentSnapshot? snap;
List<LatLng> list = [];
final Set<Polyline> _polyline = {};
List<LatLng> polylineCoordinates = [];
//  Set<Polyline> _polyline = Set<Polyline>();
PolylinePoints polylinePoints = PolylinePoints();
String googleAPiKey = "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI";
final dateTime = DateTime.now();
  final format = DateFormat('yyyy-MM-dd');


class UploadPage extends StatefulWidget {
  final String? distance;
  final String? speed;
  final String? averagespeed;
  final double? lat;
  final double? long;
  final String? time;
  final double? newLat;
  final double? newlng;
  const UploadPage(
      {this.newLat,
      this.newlng,
      this.lat,
      this.long,
      this.time,
      this.distance,
      this.speed,
      this.averagespeed});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  
  Uint8List? image;
  var uuid = Uuid();
  
 GoogleMapController? newGoogleMapController;
  
  
  Future<Position> getlatlong() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  

  List<Marker> mymarkers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.206123, 72.029800),
      infoWindow: InfoWindow(
        title: 'My initial place',
      ),
    ),
  ];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(34.206123, 72.029800),
    zoom: 14.4746,
  );
  List<LatLng> latlng = [
    // LatLng(33.999845587814384, 71.53845949838735),
    // 34.0106607622248, 71.54734297444328
  ];
  // List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();
  // Uint8List? image;
  // XFile? image;

  void selectImages() async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {}
    setState(() {});
  }

  // final Set<Polyline> _polyline = {};
  var lat;
  var long;
  // Mydata() {
  //   getFirebaseData();
  // }

  // getFirebaseData() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection("user")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("History")
  //       .get();

  //   lat = snapshot.docs[0].get("lat");
  //   long = snapshot.docs[0].get("lon");
  //   latlng.add(LatLng(lat, long));
  //   // log("my lat $lat");
  //   setState(() {});
  // }
    getdata() async{
       snap= await  FirebaseFirestore.instance.collection("userDetails").doc(FirebaseAuth.instance.currentUser!.uid).get();

      }
  void addPolyLine() {
    for (int i = 0; i < list.length; i++) {
      _polyline.add(Polyline(
        polylineId: PolylineId('5'),
        points: list,
      ));
      setState(() {});
    }
  }

  getnewData() {
    list.add(LatLng(widget.lat!, widget.long!));
    list.add(LatLng(widget.newLat!, widget.newlng!));

    addPolyLine();
    LatLngBounds? latLngBounds;
    if (widget.lat! > widget.newLat! &&
       widget.long! > widget.newlng!) {
      latLngBounds =
          LatLngBounds(southwest: LatLng(widget.newLat!,widget.newlng!), northeast: LatLng(widget.lat!,widget.long!));
    } else if (widget.long! > widget.newlng!) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(widget.lat!, widget.newlng!),
          northeast: LatLng(widget.newLat!, widget.long!));
    } else if (widget.lat! > widget.newLat!) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(widget.newLat!, widget.long!),
          northeast: LatLng(widget.lat!, widget.newlng!));
    } else {
      latLngBounds =
          LatLngBounds(southwest: LatLng(widget.lat!,widget.long!), northeast:LatLng(widget.newLat!,widget.newlng!));
    }
    // newGoogleMapController!
    //     .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Mydata()
    getnewData();
    getlatlong().then((value) async {
       getdata();
      details.text = "Public";
      // latlng.add(LatLng(value.latitude, value.longitude));
      latlng.add(LatLng(value.latitude, value.longitude));
      // log(latlng.toString());
      // _polyline.add(
      //   Polyline(
      //     polylineId: PolylineId('5'),
      //     points: latlng,
      //   ),
      // );
      mymarkers
          .add(Marker(markerId: MarkerId("dest"), position: LatLng(widget.newLat!, widget.newlng!),icon: BitmapDescriptor.defaultMarker));
      mymarkers.add(Marker(
          markerId: MarkerId('mylocation'),
          icon: BitmapDescriptor.defaultMarkerWithHue(240),
          position: LatLng(widget.lat!,widget.long!),
          infoWindow: InfoWindow(title: 'start')));
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      getdata();
      setState(() {});
    });

  }

  TextEditingController title1 = TextEditingController();
  TextEditingController description1 = TextEditingController();
  TextEditingController details = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.blue,
            height: 300.h,
            child: GoogleMap(
                myLocationButtonEnabled: true,
                // myLocationEnabled: true,
                markers: Set.of(mymarkers),
                polylines: _polyline,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.lat!,
                      widget.long!,
                    ),
                    zoom: 14)),
          ),
          Container(
            color: Colors.black,
            height: 60.h,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(children: [
                Text(
                  widget.distance == 0 ? "0.0 Km" : "${widget.distance} km",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  widget.time==0? "0.00 min":widget.time.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: title1,
                        decoration: InputDecoration(
                            label: Text(
                          "title",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: description1,
                        decoration: InputDecoration(
                            label: Text(
                          "Description",
                          style: TextStyle(fontSize: 18.sp),
                        )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0.h),
                            child: InkWell(
                                onTap: () async {
                                  // var pickedfiles = await imgpicker.pickMultiImage();
                                  //you can use ImageCourse.camera for Camera capture
                                },
                                child: Text(
                                  "Images",
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.deepOrange)),
                                    child: InkWell(
                                      onTap: () async {
                                        // selectImages();
                                        Uint8List? list = await pickImage();
                                        if (list != null) {
                                          setState(() {
                                            image = list;
                                          });
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.deepOrange,
                                          )),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Center(
                                              child: Text(
                                            "Images",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  " ${image != null ? "image selected" : "No Image"}",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: details,
                        decoration: InputDecoration(
                            label: Text(
                          "Visibility",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            label: Text(
                          "Gear",
                          style: TextStyle(fontSize: 18),
                        )),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 8.0.w, vertical: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBarScreen(),
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        //  child: Container(width: double.infinity,height: 40,decoration: BoxDecoration(),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: InkWell(
              onTap: () async {
                String url =
                    await uploadImageToDatabase(image: image!, uid: uuid.v1());
                 FirebaseFirestore.instance
                    
                    .collection('History')
                    .add({
                  "uid":FirebaseAuth.instance.currentUser!.uid,
                  "newlat": widget.newLat,
                  "newlng": widget.newlng,
                  "url": url,
                  "date": DateTime.now(),
                  'lat': widget.lat,
                  "lon": widget.long,
                  "title": title1.text.trim(),
                  "desc": description1.text.trim(),
                  'ride': "new",
                  // 'uid': keyUid,
                  'average Speed':
                      ((double.parse(widget.averagespeed!) / 1000) * 3600)
                              .toStringAsFixed(3) +
                          ' km/h',
                  'Time taken': widget.time! + "" + ' minutes',
                  'Total Distance Covered':
                      widget.distance!.toString() + "" + ' meters',
                })
                .then((value) async {
                  
                  double dis = snap!.get("totalDistance");
                  var newDis = double.parse(widget.distance!);
                  var totalDistan = dis + newDis;
                  var istTime=snap!.get("totalTime");
                  // var timeToDouble=int.parse(istTime);
                  // var totalTim=istTime+timeToDouble;
                  rideCount++;
                    photos++;
                  setState(() {
                    
                  });
                  await FirebaseFirestore.instance
                      .collection("userDetails")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    // "totalTime":totalTim,
                    "totalDistance": totalDistan,
                    // "totalDistance"
                    "phots": photos,
                    "rides": rideCount
                  }).then((value) async {
                     await FirebaseFirestore.instance.collection("RoutesCount")
                     .doc(FirebaseAuth.instance.currentUser!.uid)
                     .set({
                      "id":FirebaseAuth.instance.currentUser!.uid,
                      "rides":rideCount,
                      "date":DateTime.now(),

                     }).then((value) {
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarScreen(),));
                     });
                  });
                });
              },
              child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
          ),
          //  child: Container(width: double.infinity,height: 40,decoration: BoxDecoration(),),
        ]),
      ),
    );
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageref =
        FirebaseStorage.instance.ref().child('products').child(uid);
    UploadTask uploadTask = storageref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }
}
