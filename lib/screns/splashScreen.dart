

import 'package:flutter/material.dart';
import 'package:taxiapp/utils/imagehelper.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery. of(context). size. width,
      height: MediaQuery. of(context). size. height,
      child:
      FittedBox(
        child: Image.asset(splashLogo),
        fit: BoxFit.fill,
      ),

    /*  Positioned(child: Container(color: Colors.yellow,width: 10,height: 150,)),
      Container(color: Colors.white,child:Stack(children: [
        //SizedBox(height: 120,width: MediaQuery. of(context). size. width,),
       /* ClipOval(child: Container(decoration: BoxDecoration(border: Border.all(),
            borderRadius: new BorderRadius.all(Radius.elliptical(10, 10))),width: 60,height: 80,child:Column(children: [
          SizedBox(height: 15,),
          Text('SAG',style: TextStyle(fontSize: 20),),
          Text('CAB',style: TextStyle(fontSize: 20)),

        ],),)),*/
        Positioned(top:220,right:60,child:Align(
          child: Container(
            height: 175,
            width:175,
            margin: EdgeInsets.only(top: 40, left: 40, right: 40),
            decoration: new BoxDecoration(
              color: Colors.lightGreen,
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(90, 90)),
            ),
            child: Column(children:[
              SizedBox(height: 15,),
              Icon(Icons.car_rental_sharp,size:125)
              //Text('SAG',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              //Text('CAB',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ])
          ),
        ),),
        Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 40,vertical:20),width:MediaQuery.of(context).size.width,child: Column(children: [
          SizedBox(height:430),
        Text('Cab Service',style: TextStyle(fontSize: 50),),
          SizedBox(height: 50,),
          Align(alignment: Alignment.centerLeft,child:Text('User App',textAlign:TextAlign.left,style: TextStyle(fontSize: 50,),))
        ],)),
      ],))*/
    ));
  }
}
