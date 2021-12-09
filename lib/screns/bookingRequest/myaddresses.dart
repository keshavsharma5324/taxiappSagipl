//import 'package:addresslistapp/utils/ImageHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:taxiapp/Model/response/model/booking_request.dart';
import 'package:taxiapp/base/base/base_state.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/booking/booking_screen.dart';

import 'package:taxiapp/screns/bookingRequest/bookingrequest_cubit.dart';
import 'package:taxiapp/service/navigation_service.dart';




getSnackBar(String msg, String actionLable, GlobalKey<ScaffoldState> key) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: Text(msg,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
    ),
    action: SnackBarAction(
      textColor: Colors.black87,
      label: actionLable,
      onPressed: () {
        // Some code to undo the change.
        key.currentState!.hideCurrentSnackBar();
      },
    ),
  );
  return snackBar;
}

class MyAddresses extends StatefulWidget {
  final dynamic? data;
  String? accessToken;
  MyAddresses({this.data,this.accessToken});

  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {


  BookingRequestCubit? _bookingRequestCubit;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<User> user = [];
  bool data= false;
  double? lat,lng;
  List<Placemark>? placemarks;
  int? id;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<BookingRequestCubit>.getAllAddresses//('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjMyNzE3MzU2LCJleHAiOjE2MzI4MDM3NTZ9.d9F6tTjE_goi8U4fmc_pZ5yDlT1d140Kqc1-4QXBNcY',2);//
    //  (widget.data["token"]);

    //_bookingRequestCubit = BookingRequestCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookingRequestCubit(repo: BaseRepo(),accessToken: widget.data["token"]),
        child: Scaffold(
          key: _globalKey,
          // drawer: CustomDrawer(),
          body: BlocConsumer<BookingRequestCubit, BaseState>(builder: (_, state) {
            return Stack(children: [UI()], );
          },
              listenWhen: (previous, current) => previous != current,
              buildWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state is LoadingState) {
                  // showLoader("Sending request");
                  print("State => LoadingState");
                }

                print("Outer State");
                if (state is SuccessState) {
                  // hideLoader();
                  print(state.response);

                  BookingRequest _bookreqModel = BookingRequest.fromJson(state.response!);
                  print("AddressDataLength => ${_bookreqModel.success!.users!.length}");
                  //_addressModel.
                  setState(() {
                    user = _bookreqModel.success!.users!;
                  });
                }

                if (state is ErrorState) {
                  print("error => ${state.message}");
                  // hideLoader();
                  print("ErrorState");
                  FocusScope.of(context).requestFocus(FocusNode());

                  ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                      state.message!,
                      "OK", _globalKey));
                }
              }),
        )
    );
  }

  Widget UI(){
    return Scaffold(body:Container(
      color: Color(0xffF4F6F8),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(vertical: 55, horizontal: 10),
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 36,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "My Addresses",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff3D3D3D),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 77,
                  child: SingleChildScrollView(
                      child: TextField(
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.white),
                            /* borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),*/
                          ),enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.white, ),
                        ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          //contentPadding: EdgeInsets.symmetric(vertical:-5),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(Icons.add_to_home_screen),
                          ),
                          hintText: "No Saved address found",
                          hintStyle: TextStyle(
                            fontFamily: 'SourceSansPans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3D3D3D),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          //border: InputBorder.none,
                        ),
                      )),
                ),
                user.length==0?Column(children: [
                  SizedBox(
                    height: 39,
                  ),
                  Text(
                    "Please Add an address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3D3D3D)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 96,
                    width: 96,
                    child: Icon(Icons.add),
                  ),
                ],):Flexible(
                  child: Container(child:ListView.builder(
                    itemCount: user.length==0?0:user.length,
                    itemBuilder: (context, index) {
                      //data = data[index];
                      // Address _addressModel = data[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),),
                        child: ListTile(
                          leading: Container(height: 50,width: 150,child: InkWell(onTap: ()async{
                            List<Placemark> placemarks1 = await placemarkFromCoordinates(user[index].latitude!, user[index].longitude!);
                            setState(() {
                              id = user[index].id!;
                              placemarks = placemarks1;
                              data=true;
                              lat = user[index].latitude!;
                              lng = user[index].longitude!;
                            });
                          },child: Center(child: Text('View Address'),),)),
                          title: Text(user[index].userId.toString()+" address :",style: TextStyle(
                            fontFamily: 'SourceSansPans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D3D3D),
                          ),),
                          subtitle: Text('${user[index].latitude.toString()} ${user[index].latitude.toString()}',style: TextStyle(
                            fontFamily: 'SourceSansPans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3D3D3D),
                          ),),
                        ),
                      );
                    },)),
                )

              ],
            ),
          )
        ],
      ),
    ),bottomSheet: data?Container(height: 200,child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[Center(child:Container(padding: EdgeInsets.only(top: 15),height: 50,width: MediaQuery.of(context).size.width,child: Text('Street name:${placemarks![0].street.toString()} Region:${placemarks![0].name.toString()} Address:${placemarks![0].locality.toString()}',textAlign: TextAlign.center,style: TextStyle(letterSpacing: 0,fontSize: 16,color: Colors.blueAccent),
    ))),
      SizedBox(height: 30,),
      Row(children: [
        SizedBox(width: 16,),
        Container(decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(10)),height: 50,width: MediaQuery.of(context).size.width/2-25,child: InkWell(child: Center(child:Text('Accept Booking',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),),onTap: (){
          var data = {

            "req_id": id
            //"ext": Constants.defaultCountryCode,
            //  "user_type": Constants.userTypePassenger,
          };
          _globalKey.currentContext!.read<BookingRequestCubit>().acceptBooking(data, widget.data["token"]);
          var args = {

            "req_id": id,
            "token": widget.data["token"],
            "latitude": lat,
            "longitude": lng,
            //"ext": Constants.defaultCountryCode,
            //  "user_type": Constants.userTypePassenger,
          };
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingScreen(id: id!,accesstoken: widget.data["token"]!,latitude: lat!,longitude: lng!,)),
          );
          //NavigationService().navigationKey.currentState!.pushNamed(navigation, arguments: args);
        },)),
        SizedBox(width: 18,),
        Container(decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(10)),height: 50,width: MediaQuery.of(context).size.width/2-25,child: InkWell(child: Center(child:Text('Decline Booking',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),)),onTap: (){
          var data = {

            "req_id": id,
            "token" : widget.data["token"]
            //"ext": Constants.defaultCountryCode,
            //  "user_type": Constants.userTypePassenger,
          };
          _globalKey.currentContext!.read<BookingRequestCubit>().declineBooking(data, widget.data["token"]);
          NavigationService().navigationKey.currentState!.pushNamed(bookingrequest, arguments: data,);
        },)),

      ],)
    ])):Text(''));
  }
}
/*class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ,);
  }
}*/

