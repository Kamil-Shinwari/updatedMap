import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/utils/Utils.dart';
import 'package:provider/provider.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {

  PageController pageController = PageController();
  int currentindex=0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  changePage(int page){
            pageController.jumpToPage(page);
            setState(() {
              currentindex=page;
            });
          }
          @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserDetailProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
        body: PageView(
          
          controller: pageController,
          // ignore: prefer_const_literals_to_create_immutables
          children:screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade400,width: 1),),),
          child: TabBar(

            indicator: BoxDecoration(border: Border(top: BorderSide(color: activeCyanColor,width: 4))),
            
            onTap: changePage,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black,
            
            tabs: [
            Tab(
                child:
                  Icon(Icons.home_outlined,color: currentindex==0?activeCyanColor:Colors.black,),
                 
            ),
           
            Tab(
              child: Icon(Icons.adjust_outlined,color: currentindex==2?activeCyanColor:Colors.black),
            ),
            Tab(
              child: Icon(Icons.my_library_add,color: currentindex==3?activeCyanColor:Colors.black),
            ),
             Tab(
             
              child: 
                  Icon(Icons.more_vert,color: currentindex==4?activeCyanColor:Colors.black,),
              
                
            ),
             
          ]),
        ),
      ),
    );
  }
}