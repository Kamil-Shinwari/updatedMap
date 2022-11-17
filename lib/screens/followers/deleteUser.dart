import 'package:flutter/material.dart';
class DeleteUsers extends StatefulWidget {
  const DeleteUsers({super.key});

  @override
  State<DeleteUsers> createState() => _DeleteUsersState();
}

class _DeleteUsersState extends State<DeleteUsers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = ElevatedButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Simple Alert"),  
    content: Text("This is an alert message."),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}