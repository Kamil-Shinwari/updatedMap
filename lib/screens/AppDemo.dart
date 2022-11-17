import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  TextStyle style = TextStyle(color: Colors.white);
  SizedBox box = SizedBox(height: 10,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffadd8e6).withOpacity(0.6),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:15.0.w),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                Expanded(child: Text("welcome ! We are  Happy that you are here ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                
              ],),
              Divider(color: Colors.white,),
              Center(child: Text("How To Use This App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
              Divider(),
              Text("👉 First of all create an Account If You Hava No Account For Creating new Account You Should click on Sign up. If Already Have an Account LogIn",style:style ),
              Text("👉 After Login a new Screen Will appear Look Like That",style: style,),
          
              Image.asset("assets/Demo/screen1.png",height: 350,),
                          SizedBox(height: 10,),
              Text("👉 After Successfull Login A page Will Appear which have complete information of users , rides , Total Distance , Rides History etc",style: style,)
            ,SizedBox(height: 10,),
            Text("👉  AT bottom we have bottom Navigation which will help us to Navigate To Diffrent Pages in the App",style: style,),
            Text("👉 By Clicking seconds tab we will Navigate to a New Screen Ride Screen . Here by Clicking Play Button we Can start a New Ride",style: style,),
            SizedBox(height: 10,),
            Image.asset("assets/Demo/screen2.png",height: 350,),
            box,
            Text("👉 At the Corner of the Screen We have a Menu Icon Here we have diffrent option for changing the units of distance , logout account, Draw A routes",style: style,),
            box,
             Image.asset("assets/Demo/screen5.png",height: 350,),
             box,
            Text("👉 by Clicking Third tab we will navigte to a All History Screen . in this screen user can see all His Rides along with path and details",style: style,),
            box,
            Image.asset("assets/Demo/screen3.png",height: 350,),
            box,
             Text("👉Last but Not the least we have setting screen where we have all settings details , where user can see thier history , total rides , update account information etc",style: style,),
             box,
             Image.asset("assets/Demo/screen4.png",height: 350,),

          
              
            ]),
          ),
        ),
      ),
    );
  }
}