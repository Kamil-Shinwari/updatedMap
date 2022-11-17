import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googlemap/utils/navigatorcontrols.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  const webView({Key? key}) : super(key: key);

  @override
  State<webView> createState() => _webViewState();
}

class _webViewState extends State<webView> {
final controller=Completer<WebViewController>();
  ValueNotifier<int> loadingProgres=ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:[
        NavigatorCon(controller: controller),
      ],title: Text('AmpRides'),centerTitle: true,),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://ampridesusa.com/',
         onWebViewCreated: (WebViewController controllerr){
              controller.complete(controllerr);
         },
           javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (navigation){
              if(Uri.parse(navigation.url).host.contains('www.youtube.com')){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Blocked this site')));
                return NavigationDecision.prevent;
              }
              else{
                return NavigationDecision.navigate;
              }
            },
            onPageStarted: (url){
              loadingProgres.value=0;
            },
            onProgress: (int progress){
             loadingProgres.value=progress;
            },
            onPageFinished: (url){
              loadingProgres.value=100;
            },
          ),
        ],
      ),
    );
  }
}
