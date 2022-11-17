import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NavigatorCon extends StatelessWidget {
  Completer<WebViewController> controller;
  NavigatorCon({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: controller.future,
        builder: (context,snapshot){
          WebViewController? controller=snapshot.data;
          print(snapshot.data);
          if(snapshot.connectionState!=ConnectionState.done || controller == null){
            return Row(
              children:[
                InkWell(onTap:(){print('she empty d');},child: Icon(Icons.arrow_back_ios)),
                Icon(Icons.arrow_forward_ios),
                Icon(Icons.replay),
              ]
           );
          }
          else{
            return Row(
              children: [
                InkWell(onTap:()async{
                  if(await controller.canGoBack()){
                    await controller.goBack();
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stack is Empty')));
                  }
                },child: Icon(Icons.arrow_back_ios)),
                InkWell(onTap:()async{
                  if(await controller.canGoForward()){
                    await controller.goForward();
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stack is Empty')));

                  }
                },child: Icon(Icons.arrow_forward_ios)),
                InkWell(onTap:()async{

                    await controller.reload();

                },child: Icon(Icons.replay)),
              ],
            );
          }
        });
  }
}
