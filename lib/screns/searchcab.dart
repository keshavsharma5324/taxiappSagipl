
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/imagehelper.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class searchCab extends StatefulWidget {
  const searchCab({Key? key}) : super(key: key);

  @override
  _searchCabState createState() => _searchCabState();
}

class _searchCabState extends State<searchCab> {
/*  var cp = CameraPosition(
    target: LatLng(51.52782851262915, -0.10701929241472438),
    zoom: 15.5,
    tilt: 0,
  );*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Stack(children:[

        Positioned(right:-40,top:225,child:Container(
          width: 260,height: 220,//MediaQuery.of(context).size.width,

          margin:  EdgeInsets.all(100),
          //padding: EdgeInsets.all(80.0),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber.withOpacity(0.22),//here i want to add opacity


            // borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        )),
      Positioned(top: 265,right:10,child:Container(
        width: 160,height: 150,//MediaQuery.of(context).size.width,

        margin:  EdgeInsets.all(100),
        //padding: EdgeInsets.all(80.0),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber.withOpacity(0.4),//here i want to add opacity


          // borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      )),
      Positioned(top: 430,left: 40,child:  Container(
        height: 130,width:300,
        child: Column(children: [
          SizedBox(height:15),
          Container(height: 60,child:Image.asset(search),
          color: Colors.black,),
          SizedBox(height: 20,),
          Text('Searching for Cab near you',style: TextStyle(letterSpacing: 0.05,color: Colors.white,fontSize: 19),)
        ],),
        // color: Colors.white,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // height: 90,
        //width: 270,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 1,color: Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),),),
      Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
      SizedBox(height: 50,),
      Row(children:[SizedBox(width: 20,),
        SizedBox(height: 50,),
        Container(height:20,child:Image.asset(menu))
        //Icon(Icons.reorder),
         ]),
      //GoogleMap(initialCameraPosition: cp, mapType: MapType.normal),
      Container(padding: EdgeInsets.symmetric(horizontal:20,vertical: 0),
            width: MediaQuery. of(context). size. width ,
            height: 110,
            color: Colors.grey,//(0xffFFFFFF),
            child:Column(
              children: [
              /*  Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Icon(

                              Icons.arrow_back_rounded,
                              size: 27.0,
                              color: Color(0xff202020),
                            ),
                          ),
                          //),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(
                        width: 310,
                        height: 20,
                      )
                      /* Padding(
                          padding: const EdgeInsets.fromLTRB(80, 52, 8, 0),
                          child: Container(
                            height: 32,
                            width: 32,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xff004238), width: 1),

                            ),
                            child: Icon(
                              Icons.person,
                              color: Color(0xff004238),
                              size: 22,
                            ),


                          ),
                        ),*/

                      /*Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 52),
                            child: Text('One Tap Booking',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202020),
                                )),
                          ),
                        ),*/
                      /* Padding(
                          padding: const EdgeInsets.fromLTRB(0, 52, 0, 0),
                          child: Container(
                            height: 32,
                            width: 28,
                            child: Icon(
                              Icons.expand_more,
                              color: Color(0xff004238),
                              size: 22,
                            ),
                          ),
                        ),*/
                    ],
                  ),
                ),*/
                Row(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          //topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(5),
                          //bottomRight: Radius.circular(20),
                        ),
                      border: Border.all(
                        width:1,
                        color:Colors.white
                      )
                    ),
                    //color: Colors.white,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 22.5, 0, 10),
                    //  height: 105,
                    width: 50,

                    child: Column(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            //borderRadius: BorderRadius.circular(2),
                           // color: Color(0xffF9534B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 37.39,
                          width: 0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff707070), width: 1),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right:0),
                          child: Icon(Icons.location_on,color: Colors.red,),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                           // color: Color(0xff004238),
                           // shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                   // color: Colors.white,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    // height: 90,
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        //bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                         // height:55,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(
                            textAlign: TextAlign.justify,
                            obscureText: false,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff004238)),
                            decoration: InputDecoration(
                              hintText: "933 Colin gateway Suite 973",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.only(bottom: -15),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 9),
                          child: TextField(
                            textAlign: TextAlign.justify,
                            obscureText: false,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff004238)),
                            decoration: InputDecoration(
                              hintText: "5342 Mauricio Walks",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.only(bottom: -15),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Container(
                          padding: EdgeInsets.fromLTRB(14, 110, 23.91, 0.91),
                          child: Icon(
                            Icons.add,
                            color: Color(0xff004238),
                          ))*/
                ])
              ],
            )),

      Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [



        SizedBox(height: 50,),
       // Center(child:),
      ],



      )])
    ]),
    bottomSheet: Container(height:130,child:Column(children: [
      SizedBox(height:40),
      MaterialButton(onPressed: () {  },child: Container(padding: EdgeInsets.symmetric(horizontal:20),height: 50,width:MediaQuery.of(context).size.width,color: kPrimaryColor,child: Center(child:Text('CANCEL RIDE',style: TextStyle(fontSize: 20,color: Colors.white),)),),),
    ],))
      ,
    );
  }

}
