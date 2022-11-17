import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';

DocumentSnapshot? snap;
List<LatLng> list = [];
final Set<Polyline> _polyline = {};
List<LatLng> polylineCoordinates = [];
//  Set<Polyline> _polyline = Set<Polyline>();
PolylinePoints polylinePoints = PolylinePoints();
String googleAPiKey = "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI";

class ShowingDetails extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final double? newlatitude;
  final double? newLongitude;
  final String? distance;
  final String? totalTime;
  final String? title;
  final String? url;
  final String? averageSpeed;
  final String? description;

  const ShowingDetails(
      {super.key,
      this.title,
      this.description,
      this.averageSpeed,
      this.url,
      this.distance,
      this.totalTime,
      this.latitude,
      this.longitude,
      this.newlatitude,
      this.newLongitude});

  @override
  State<ShowingDetails> createState() => _ShowingDetailsState();
}

class _ShowingDetailsState extends State<ShowingDetails> {
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
    list.add(LatLng(widget.latitude!, widget.longitude!));
    list.add(LatLng(widget.newlatitude!, widget.newLongitude!));

    addPolyLine();
    setState(() {});
  }

  Completer<GoogleMapController> _controller = Completer();
  myMarker() async {
    mymarkers.add(Marker(
      rotation: 50.0,
        markerId: MarkerId('mylocation'),
        position: LatLng(widget.latitude!, widget.longitude!),
        infoWindow: InfoWindow(title: 'start')));
        setState(() {
          
        });
        mymarkers.add(Marker(
        markerId: MarkerId('mylocation'),
        position: LatLng(widget.newlatitude!, widget.newLongitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
        infoWindow: InfoWindow(title: 'End')));
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(widget.latitude!, widget.longitude!), zoom: 14);
    log(widget.newLongitude.toString() + " new ");

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getnewData();
    myMarker();
    log(widget.latitude.toString() + "init");
    List<LatLng> points = [
      LatLng(widget.latitude!, widget.longitude!),
      LatLng(widget.newlatitude!, widget.newLongitude!),
    ];
  }

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI';
  String totalDistance = 'No route';
  List<Marker> markers = [];

  //  var x=Uuid();
  int id = 1;
  Set<Polyline> _polyline = Set<Polyline>();
  @override
  List<Marker> mymarkers = [];
  @override
  Widget build(BuildContext context) {
    log(widget.latitude.toString());
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: GoogleMap(
            polylines: _polyline,
            markers: Set.of(mymarkers),
            // myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              zoom: 14,
              target: LatLng(widget.latitude!, widget.longitude!),
            ),
            onMapCreated: (controller) {
              _controller.complete(controller);
              getnewData();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
            height: 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Text(
                        "History",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Title : ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.title}",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "TotalTime :  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.totalTime}",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Distance :  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.distance}",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                         Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Description :  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.description}",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "AverageSpeed :  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.averageSpeed}",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.url.toString()),
                                  fit: BoxFit.cover),
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:40.0),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(height: 50,width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(20)
            ),
            child: Center(child: Text("Back",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
            ),
          ),
        )
      ],
    ));
  }
}
