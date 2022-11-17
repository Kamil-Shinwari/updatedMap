import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ontapMarker extends StatefulWidget {
  const ontapMarker({super.key});

  @override
  State<ontapMarker> createState() => _ontapMarkerState();
}

class _ontapMarkerState extends State<ontapMarker> {
  List<Marker> markers = [];
  LatLng? newone;
 Completer<GoogleMapController> _controller=Completer();
 int id=1;
 Set<Polyline> _polyline = Set<Polyline>();
 var first=LatLng(33.99378661430651, 71.60745936614394);
 var second =LatLng(33.99586807931898, 71.603725731216);
 List<LatLng> polylineCordinates=[];
 Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(double lat,double lng) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI",
        PointLatLng(first.latitude,first.longitude),
        PointLatLng(lat, lng),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onTap: (LatLng latlng){
              Marker newMarker= Marker(markerId: MarkerId("$id"),
              position: LatLng(latlng.latitude,latlng.longitude),
              infoWindow: InfoWindow(title: "Marker added"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed
              ),
              );
              markers.add(newMarker);
              id++;
              newone=latlng;
              // PointLatLng(newone!.latitude,newone!.longitude);
              setState(() {
                _getPolyline(newone!.latitude, newone!.longitude);
              });
              log(latlng.toString());
              log(markers.length.toString());
              
            },
            initialCameraPosition: CameraPosition(
                zoom: 14,
                target: LatLng(33.994284747327136, 71.60471278412798)),
                onMapCreated: ((controller) {
                  _controller.complete(controller);
                  // _getPolyline();
                }),
                markers: markers.map((e) => e).toSet(),
                 polylines: Set<Polyline>.of(polylines.values),
          )),
        ]),
      ),
    ));
  }
}
