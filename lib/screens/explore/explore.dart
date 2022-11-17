import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindSaloonScreen extends StatefulWidget {
  const FindSaloonScreen({super.key});

  @override
  State<FindSaloonScreen> createState() => _FindSaloonScreenState();
}

class _FindSaloonScreenState extends State<FindSaloonScreen> {
 int x=1;
    GoogleMapController? mapController;
      List<LatLng> list=  [];
  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double? originLatitude;
  double? destLatitude ;
 final Set<Marker> _markers={};
  final Set<Polyline> _polyline={};
  List<LatLng> polylineCoordinates = [];
  //  Set<Polyline> _polyline = Set<Polyline>();
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI";

  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _showMaterialDialog();
    getLocation();
  
   
   
  }
  void addPolyLine(){
       for(int i=0; i< list.length; i++){
      _polyline.add(Polyline(
          polylineId: PolylineId('5'),
        points: list,
      )
      
      );
      setState(() {
        
      });
    }
  }


  var addressa;
  double? lat;
  double? longi;

  getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition();
    setState(() {});
  }


String query="";
TextEditingController searchc=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: position == null
                  ? LatLng(34.00895968237819, 71.54737448996782)
                  : LatLng(position!.latitude, position!.longitude),
              zoom: 14),
          onMapCreated: (GoogleMapController controller) {
          
          },
          // markers: Set<Marker>.of(markers),
          
          polylines:_polyline,
        ),
        Positioned(
            top: 40.h,
            left: 30.w,
            right: 30.w,
            child: Container(
              height: 45.h,
              color: Colors.white,
              child: TextField(
                onTap: (){
                  // _showMaterialDialog();
                },
                controller:searchc ,
                onEditingComplete: () {
                  setState(() {
                    query=searchc.text;
                    log(query);
                  });
                },
                  decoration: InputDecoration(
                      hintText: "Search By City Name", border: OutlineInputBorder())),
            )),
        Positioned(
          bottom: 40.h,
          left: 0,
          right: 0,
          child:query==""?
          Container(
            width: 350.w,
            height: 160.h,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Routes')
                    .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    // .where("role", isEqualTo: "ServicesProvider")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return InkWell(
                    onTap: (){
                      // log("prssed");
                    },
                    child: ListView(
                      // scrollDirection: Axisorizontal,
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.docs.map((document) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: (){
                                if(x==1){
                                  list.add(LatLng(document["lat"], document["lon"]));
                                list.add(LatLng(document["newlat"], document["newlon"]));
                               
                                addPolyLine();
                                setState(() {
                                  x=0;
                                });
                                }else{
                                  list.clear();
                                  setState(() {
                                    
                                  });
                                }
                              },
                              child: MyContainerListView(
                                lat: " ${document["lat"]}",
                                lon: "  ${document["lon"]}",
                                title: "${document["title"]}",
                                RideDeparted: document["RideDeparted"].toString(),
                                              
                                
                                
                                //  "${document["imageUrl"]}",
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
          ):
           InkWell(
            onTap: (){
              // log("clicked");
            },
               child: Container(
                width: 350.w,
                height: 160.h,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Routes')
                        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                        
                      return InkWell(
                        onTap: (){
                          log("tap");
                        },
                        child: ListView(
                          // scrollDirection: Axisorizontal,
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((document) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: (){
                                   
                                    // polylines.addAll(document["lat"],);
                                    // _getPolyline(document["lat"], document["lon"], document["newlat"], document["newlon"]);
                                  },
                                  child: MyContainerListView(
                                   lat: " ${document["lat"]}",
                                    lon: "  ${document["lon"]}",
                                    title: "${document["title"]}",
                                    RideDeparted: document["RideDeparted"].toString(),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                       ),
             ),
           ),
        
      ]),
    );
  }

}


class MyContainerListView extends StatelessWidget {
  final String RideDeparted;
  final String title;
  final String lat;
  final String lon;

  const MyContainerListView(
      {super.key,
      required this.title,
      required this.RideDeparted,
      required this.lat,
      required this.lon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 275.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Container(
                decoration:
                    (BoxDecoration(borderRadius: BorderRadius.circular(20.r))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(title),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(RideDeparted)
                    ]),
              ),
            )),
        // Expanded(
        //     flex: 1,
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         decoration: BoxDecoration(
        //             color: Colors.blue,
        //             borderRadius: BorderRadius.circular(20),
        //             image: DecorationImage(
        //                 image: NetworkImage(
        //                   url,
        //                 ),
        //                 fit: BoxFit.cover)),
        //       ),
        //     )),
      ]),
    );
  }
}