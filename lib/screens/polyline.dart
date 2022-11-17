import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
// import 'package:google_map/polygon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

 static Position? position;
  Completer<GoogleMapController> _completer= Completer();

  final CameraPosition cameraPosition= CameraPosition(target: LatLng(34.006960, 71.533060));

  List<Marker> markers=[];
 
  List<Marker> list= const [

  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition();
  }




    currentLocation() async{
   position= await getUserCurrentLocation();

      CameraPosition cameraPosition= CameraPosition(
          target:  LatLng(position!.latitude, position!.longitude,),
          zoom: 14);
      GoogleMapController controller= await _completer.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState((){

      });
  //   });
  }

  Set<Polygon> _polygon= HashSet<Polygon>();


  List<LatLng> latlng=[
   position==null? LatLng(34.009857, 71.523150): LatLng(position!.latitude,position!.longitude ),
    LatLng(34.009857, 71.523150),

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
          initialCameraPosition: CameraPosition(target: position==null?LatLng(34.006960, 71.533060):LatLng(position!.latitude, position!.longitude)),
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