import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:googlemap/screens/MyHomePagee.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/login.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
 var x1=Uuid();
 String? add;
 DateTime? now = DateTime. now();
class MapsRoutesExample extends StatefulWidget {
  const MapsRoutesExample({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MapsRoutesExampleState createState() => _MapsRoutesExampleState();
}

class _MapsRoutesExampleState extends State<MapsRoutesExample> {
  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> points = [];

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI';
  String totalDistance="No route";
  static  double? currentLocationLatitude;
 static double? currentLocationLongitude;

 static double? destLat;
 static double? destlong;
   List<Marker> markers = [];
   getDistance() {
    setState(() {
      // totalDistance = drawRoute();
    });
   }
  
   int id=1;
   String? x5= x1.v1();
 Set<Polyline> _polyline = Set<Polyline>();

//  DateTime? now = DateTime. now();
String formattedDate = DateFormat("yyyy-MM-dd"). format(now!);
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("draw a Route"),
      actions: [
        Center(child: Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: InkWell(
            onTap: (){
               String url = 'https://www.google.com/maps/dir/?api=1&origin=$currentLocationLatitude,$currentLocationLongitude&destination=$destLat,$destlong&travelmode=driving&dir_action=navigate';
               _launchURL(url);
            },
            child: Text("Direction")),
        )),
        IconButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapsRoutesExample(title: ""),));
          });
        }, icon: Icon(Icons.delete)),
      ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (LatLng latLng) async{
                
                var x2=latLng;
                
                  Marker newMarker= Marker(markerId: MarkerId("$id"),
              position: LatLng(latLng.latitude,latLng.longitude),
              infoWindow: InfoWindow(title: "Marker added"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed
              ),
              );
              if(markers.length==0){
                FirebaseFirestore.instance.collection("Routes")
                .doc(x5.toString())
                .set({
                  "lat":x2.latitude,
                  "lon":x2.longitude,
                  "newlat":"",
                  "newlon":"",
                  "RideDeparted":DateTime.now(),
                  "name":FirebaseAuth.instance.currentUser!.displayName,
                  "title":formattedDate,
                  "uid":FirebaseAuth.instance.currentUser!.uid,
                  "address":""
                });
                setState(() {
                  currentLocationLatitude = x2.latitude;
                  currentLocationLongitude = x2.longitude;
                  log(currentLocationLongitude.toString());
                });
              }else {
                 FirebaseFirestore.instance.collection("Routes")
                .doc(x5.toString())
                .update({
                  
                  "newlat":x2.latitude,
                  "newlon":x2.longitude,
                }).then((value) {
                  setState(() {
                   destLat =x2.latitude;
                   destlong=x2.longitude;
                   log(destLat.toString());
                      x5=x1.v1();
                  });
                });
                setState(() {
                  
                });
              }
              
              markers.add(newMarker);
              id++;
              setState(()async {
                points.add(LatLng(latLng.latitude, latLng.longitude));
                
                
              });
              },
                markers: markers.map((e) => e).toSet(),
                //  polylines: Set<Polyline>.of(polylines.values),
              zoomControlsEnabled: false,
              polylines: route.routes,
              initialCameraPosition: const CameraPosition(
                zoom: 14.0,
                target: LatLng(40.715888142250016, -73.99345738955843),
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Align(
                    alignment: Alignment.center,
                    child:
                        Text(totalDistance, style: TextStyle(fontSize: 25.0)),
                  )),
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        if(points.length >=2) {
             add= await   drawRoute().then((value) {
              
              
             });
            
              FirebaseFirestore.instance.collection("Routes")
                .doc(x5.toString())
                .update({
                  "address":add,
                });
                setState(() {
                  
                });
            
            log("address is "+add!);
              // Future.delayed(Duration(seconds: 4),() =>  Navigator.push(context, MaterialPageRoute(builder:(context) => Login(),)),);
                }
      },child: Text("draws"),),
    );
  }

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

 Future<String> drawRoute() async{
    // var x=TravelModes.driving;
       await route.drawRoute(points, 'Test routes',
              Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
              travelMode: TravelModes.driving);
          setState(() {
            totalDistance =
                distanceCalculator.calculateRouteDistance(points, decimals: 1);
          });
          return totalDistance;
  }
}
