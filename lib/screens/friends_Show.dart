import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/screens/showing_history_details/show_history_details.dart';
class FriendsShowScreen extends StatefulWidget {
  const FriendsShowScreen({super.key});

  @override
  State<FriendsShowScreen> createState() => _FriendsShowScreenState();
}

class _FriendsShowScreenState extends State<FriendsShowScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("AddFriends")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                             child: Column(
                              
                               children: [
                                Text("List OF Friends",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                                SizedBox(height: 20,),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red)
                                    ),
                                     child: ListTile(
                                      title: Text(snapshot.data!.docs[index].get("name")),
                                       leading: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: CircleAvatar(
                                           child: Text(snapshot.data!.docs[index].get("name").toString().substring(0,1)),
                                         ),
                                         
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             )
                            );
                          },
                        );
                      }
                    },
                  ),
   );
  }
}