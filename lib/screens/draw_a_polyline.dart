import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
// import 'package:google_map/polygon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class homeScreenPoly extends StatefulWidget {
  const homeScreenPoly({Key? key}) : super(key: key);

  @override
  State<homeScreenPoly> createState() => _homeScreenPolyState();
}

class _homeScreenPolyState extends State<homeScreenPoly> {


  Completer<GoogleMapController> _completer= Completer();

  final CameraPosition cameraPosition= CameraPosition(target: LatLng(34.006960, 71.533060));

  List<Marker> markers=[];
  List<Marker> list= const [

  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition();
  }


  // List<LatLng> points= [
  //   LatLng(34.002077, 71.538706 ),
  //   LatLng(34.009857, 71.523150),
  //   LatLng(34.013200, 71.546539),
  //   LatLng(34.002077, 71.538706 ),
  //
  // ];


  // polygon(){
  //   _polygon.add(
  //     Polygon(
  //         polygonId: PolygonId('1'),
  //         fillColor: Colors.red.withOpacity(0.2),
  //         visible: true,
  //         points: points,
  //       strokeWidth: 5,
  //       strokeColor: Colors.black
  //
  //     ),
  //   );
  // }


    currentLocation(){
    getUserCurrentLocation().then((value) async{

      markers.add(Marker(markerId: MarkerId('7'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: 'My curent Location',
          )
      ));

      CameraPosition cameraPosition= CameraPosition(
          target:  LatLng(value.latitude, value.longitude,),
          zoom: 14);
      GoogleMapController controller= await _completer.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState((){

      });
    });
  }

  Set<Polygon> _polygon= HashSet<Polygon>();


  List<LatLng> latlng=[
    LatLng(34.002077, 71.538706 ),
    LatLng(34.009857, 71.523150),
    LatLng(34.001176, 71.516241),
    LatLng(34.009441, 71.505651),

  ];

  final Set<Marker> _markers={};
  final Set<Polyline> _polyline={};



  @override
  void initState(){
    super.initState();
    markers.addAll(list);
    currentLocation();
    // polygon();

    for(int i=0; i< latlng.length; i++ ){

      _markers.add(Marker(
          markerId: MarkerId('9'),
          position: latlng[i],
        infoWindow: InfoWindow(
          title: 'point$i',
        )

      ),
      );
      setState((){

      });

      _polyline.add(Polyline(
          polylineId: PolylineId('5'),
        points: latlng,
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set.of(_markers),
          polygons: _polygon,
          polylines: _polyline,
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller){
            _completer.complete(controller);
          },

        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(left: 20, bottom: 20),
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: () async{
              // polygon();
             },

            child: Icon(Icons.location_disabled_outlined),
          ),
        ),
      ),
    );
  }
}