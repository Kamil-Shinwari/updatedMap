
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class WalkData extends StatefulWidget {
  String uid;
  WalkData({Key? key,required this.uid}) : super(key: key);

  @override
  State<WalkData> createState() => _WalkDataState();
}

class _WalkDataState extends State<WalkData> {
  @override
  Widget build(BuildContext context) {
    TextStyle style=TextStyle(
      color:Colors.red,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Individual History'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').doc(widget.uid).collection('History').snapshots(),
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                QuerySnapshot   querySnapshot=snapshot.data as QuerySnapshot;
                print(querySnapshot.docs.length);

                 return ListView.builder(itemCount:querySnapshot.docs.length,itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red,width: 2.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text('Time Taken: '+querySnapshot.docs[index]['Time taken'],style: style,)),
                                  Expanded(child: Text('Distance: '+querySnapshot.docs[index]['Total Distance Covered'],style: style,)),
                                  Expanded(child: Text('Average Speed: '+querySnapshot.docs[index]['average Speed'],style: style,)),
                                ],
                              ),
                            ),
                          ),
                        );
                 });
              }
              else{
                Fluttertoast.showToast(msg: 'No Data To Show');
                return Container();
              }
            }
            else{
              return Center(child: CircularProgressIndicator(color: Colors.red,));
            }

          },
        ),
      ),
    );
  }
}
