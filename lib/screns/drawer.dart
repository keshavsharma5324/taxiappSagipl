import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxiapp/Model/response/model/profile/profile_response.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/Profile/personal_details_cubit.dart';
import 'package:taxiapp/screns/bookingRequest/myaddresses.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/utils/Constant.dart';

class CustomDrawer extends StatefulWidget {
  String? fname,lname,number,email,accesstoken,id,username;
  Function? onClick;
  Function? onClickUpdate;
  CustomDrawer({this.fname,this.lname,this.number,this.email,this.onClick,this.accesstoken,this.id,this.username, this.onClickUpdate});

  @override
  State<StatefulWidget> createState() => CustomDrawerState();
// TODO: implement createState
//throw UnimplementedError();
}
class CustomDrawerState extends State<CustomDrawer> {
  bool editName = false;
  String name ='keshav';

  //ProfileResponse? profileResponse;
  //String fName=profileResponse.data.fname.toString();//widget.fname.toString();
  TextEditingController fullname=TextEditingController();
  TextEditingController lastname=TextEditingController();
  TextEditingController phonenumber=TextEditingController();
  TextEditingController emailaddress=TextEditingController();
  TextEditingController user_name=TextEditingController();
  /*final String assetName = 'assets/Group 1791 2.svg';
  final String assetName1 = 'assets/Group 1808.svg';
  final String assetName2 = 'assets/Group 9600.svg';
  final String assetName3 = 'assets/01-home.svg';
  final String assetName4 = 'assets/Group 1810.svg';
  final String assetName5 = 'assets/Group 1811.svg';
  final String assetName6 = 'assets/Group 1812.svg';
  final String assetName7 = 'assets/notification.svg';
  final String assetName8 = 'assets/Group 1813.svg';*/
  @override
  void initState() {
    // TODO: implement initState
    widget.onClick!();

    onPageLoad();
    //if(AppUtils.userData != null){
    /*if (AppUtils.userData!.success!.users!.first as String ==null) {
        fullname.text = '';
      } else {
        fullname.text = AppUtils.userData!.success!.users!.first as String;
      }*/
    //}
    //fullname.text=await
    // (widget.fname == null?'':widget.fname)!;
    //print(fullname);

    //a=widget.fname.toString();
    //widget.onClick;
  }
  void onPageLoad(){

  }
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  /*Future<void> didChangeDependencies() async {
    //if(widget.fname!=null){
    //fullname.text=await widget.fname.toString();
    print(fullname);
    lastname.text=widget.lname.toString();
    phonenumber.text=widget.number.toString();
    emailaddress.text=widget.number.toString();
    //profileResponse!.data!.fname.toString();
  //}
    super.didChangeDependencies();
  }*/
  GlobalKey _globalKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar:AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){NavigationService().navigationKey.currentState!.pop();}),title: Text('Profile'), ),
      body:Container(
        width: 366,
        child: Container(
            child: Container(
              height: 896,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: ListTile.divideTiles(context: context, tiles: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      height: 172,
                      // color: Color(0xffFFFFFF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                            child: Container(
                              height: 88,
                              width: 88,
                              decoration: BoxDecoration(
                                color: Color(0xffE4E4E4),
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Color(0xffF5F5F5), width: 1),
                              ),
                              child: FlatButton(child:Text('press here to edit profile'),onPressed: (){
                                //widget.onClick!();
                                // setState(() {
                                /*  setState(() {
                                editName =! editName;
                              });*/

                                //}
                                //  );
                              },),//SvgPicture.asset(assetName,),
                              //Icon(Icons.person,color: Color(0xffBEBEBE),size: 50,),
                            ),
                          ),
                          Container(//width: 200,
                            // padding: const EdgeInsets.fromLTRB(16, 60, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center
                                ,
                                children: [
                                  Text('Profile Details',style:TextStyle(fontSize: 22))


                                  /*TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                                  enabled: editName,
                                    textAlign: TextAlign.justify,
                                    controller: fullname,
                                    onChanged: (value){
                                      widget.fname = value;
                                    },decoration: InputDecoration(
                                  hintText: widget.fname,
                                  hintStyle: TextStyle(color: Colors.black,),
                                  fillColor: Colors.green,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)
                                  )
                                ),
                                   /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),
                                SizedBox(
                                  width: 110.0,
                                  height: 25.0,
                                  child: FittedBox(
                                    child: Text(widget.email.toString(),
                                        style: TextStyle(
                                          letterSpacing: 0.001,
                                          fontFamily: 'Gilroy',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff004238),
                                        )),
                                  ),
                                ),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //SizedBox(width: 35),
                          Container(child: Text('FirstName')//SvgPicture.asset(assetName1,)
                            ,),
                          /*SizedBox(
                          width: 28.25,
                        ),*/
                          Container(width:220,child:TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                            enabled: editName,
                            textAlign: TextAlign.justify,
                            controller: fullname,
                            onChanged: (value){
                              widget.fname = value;
                            },decoration: InputDecoration(
                              hintText: widget.fname,
                              hintStyle: TextStyle(color: Colors.black,),
                              fillColor: Colors.green,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2)
                              )
                          ),)
                            /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),
                          /*  Text(widget.number.toString(),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff004238),
                            ))*/
                        ],
                      ),
                    ),
                    Container(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          //SizedBox(width: 35),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Container(
                                child: //SvgPicture.asset(assetName2,)
                                Text('LastName')),
                          ),
                          /*SizedBox(
                          width: 32.25,
                        ),*/
                          Container(width:220,child: TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                            enabled: editName,
                            textAlign: TextAlign.justify,
                            controller: lastname,
                            onChanged: (value){
                              widget.lname = value;
                            },decoration: InputDecoration(
                              hintText: widget.lname,
                              hintStyle: TextStyle(color: Colors.black,),
                              fillColor: Colors.green,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2)
                              )
                          ),)
                            /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),
                          /*Text("One Tap Booking",
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff004238),
                            )),*/
                        ],
                      ),
                    ),
                    Container(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //SizedBox(width: 35),
                            //Icon(Icons.location_on,color: Color(0xff004238),),
                            Container(child: Text('Email')//SvgPicture.asset(assetName3,)
                              ,),
                            /*SizedBox(
                          width: 58.25,
                        ),*/
                            Container(width:220,
                              child:TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                                enabled: false,
                                textAlign: TextAlign.justify,
                                controller: emailaddress,
                                /*onChanged: (value){
                            widget.email = value;
                          },*/decoration: InputDecoration(
                                  hintText: widget.email,
                                  hintStyle: TextStyle(color: Colors.black,),
                                  fillColor: Colors.green,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2)
                                  )
                              ),),
                              /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),
                            /*Text("Addresses",
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff004238),
                            ))*/
                          ],
                        )),

                    Container(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Container(
                              //  width: 30,
                              // height: 25,
                              child: Text('Phone'),//SvgPicture.asset(assetName4,), /*Image.asset(
                              //'assets/credit-card.png',
                              /*  scale: 0.5,
                          fit: BoxFit.cover,
                          color: Color(0xff004238),
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),*/
                            ),
                          ),
                          //,
                          Container(width:220
                            ,child:TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                                enabled: false,
                                textAlign: TextAlign.justify,
                                controller: phonenumber,
                                /*onChanged: (value){
                            widget.number = value;
                          },*/decoration: InputDecoration(
                                hintText: widget.number,
                                hintStyle: TextStyle(color: Colors.black,),
                                fillColor: Colors.green,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)
                                ))
                            ),
                            /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),

                        ],
                      ),
                    ),
                    Container(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(width: 35),
                          Container(child: Text('UserName')//SvgPicture.asset(assetName5,)
                            ,),
                          Container(width:220
                            ,child:TextField(//'${widget.fname.toString()} ${widget.lname.toString()}',
                                enabled: false,
                                textAlign: TextAlign.justify,
                                controller: user_name,
                                /*onChanged: (value){
                                widget.username = value;
                              },*/decoration: InputDecoration(
                                hintText: widget.username,
                                hintStyle: TextStyle(color: Colors.black,),
                                fillColor: Colors.green,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)
                                ))
                            ),
                            /* style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff004238),
                                    )*/),

                        ],
                      ),
                    ),
                    /*Container(
                    height: 75,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Container(child: Text('gtty')//SvgPicture.asset(
                            //assetName6,),), //Icon(Icons.info_rounded,color: Color(0xff004238),),
                        ),),
                        SizedBox(
                          width: 28.25,
                        ),
                        Text("Help & Support",
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff004238),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Container(child: Text('fewff'))//SvgPicture.asset(
                            //assetName7,),), //Icon(Icons.notifications_active_rounded,color: Color(0xff004238),),
                        ),
                        SizedBox(
                          width: 28.25,
                        ),
                        Text("Notification",
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff004238),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 110,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Container(
                              child: Text('grgrgr'))//SvgPicture.asset(assetName8,),),

                          ),
                          SizedBox(
                            width: 28.25,
                          ),
                          Text("Logout",
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff004238),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      color: Color(0xffF2F2F2),
                      height: 63,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 34,
                          ),
                          Text('Legal',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff004238),
                              )),
                          SizedBox(width: 166),
                          Text('v4.339.10002',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff004238),
                              ))
                        ],
                      ))*/
                  ]).toList(),
                ),
              ),
            )),
      ),
      bottomSheet: Container(padding: EdgeInsets.symmetric(horizontal: 30),height: 100,child: Column(
        mainAxisAlignment: MainAxisAlignment.start ,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(width:MediaQuery.of(context).size.width,height:55,color:Colors.cyanAccent,child:FlatButton(onPressed: (){
            setState(() {
              editName =! editName;
            });
          }, child: editName?TextButton(child:Text('SAVE CHANGES'), onPressed: () async{
            setState(() {
              editName=false;
            });
            //check().then((internet) async{
            // if (internet != null && internet) {
            String deviceId = await _getId();
            var data = {
              "first_name": widget.fname.toString().trim(),
              "last_name": widget.lname.toString().trim(),
              "username": widget.username.toString().trim(),
              "email": widget.email.toString().trim(),
              "mobile": widget.number.toString().trim(),
              "device_id": deviceId,
              //"ext": Constants.defaultCountryCode,
              //  "user_type": Constants.userTypePassenger,
            };
            _globalKey.currentContext!.read<PersonalDetailsCubit>().updateProfile(data,widget.accesstoken!,int.parse(widget.id!));
            var args =await {

              "token": widget.accesstoken
            };
            NavigationService().navigationKey.currentState!.pushNamed(bookingrequest, arguments: args,);
          } //editName?
          )
              :TextButton(child:Text('UPDATE'),onPressed: ()async{
            setState(() {
              editName = true;

              fullname.text = widget.fname.toString();
              lastname.text = widget.lname.toString();
              emailaddress.text = widget.email.toString();
              phonenumber.text = widget.number.toString();
              user_name.text = widget.username.toString();});

          },)))
        ],)),
    );
  }
/*bool isValidate() {
    var phone = _controllerUsername.text.toString().trim();
    var password = _controllerPassword.text.toString().trim();

    if(isEmail!){
      if(phone.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Email ID or Phone number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(!Validator().validateEmail(phone)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter a valid Email ID",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Password",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.length<1){//!Validator().validatePassword(password)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please Enter 8 letters of combination of One Capital, Lower and Numeric characters",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else{
        FocusScope.of(context).unfocus();
        check().then((internet) async {
          if (internet != null && internet) {
            String deviceId = await _getId();
            var data = {
              "email": phone,
              "password": password,
              "device_id": deviceId, //identifier
              //"ext": Constants.defaultCountryCode,
              //"user_type": Constants.userTypePassenger,
            };
            _globalKey.currentContext!.read<LoginCubit>().doLogin(data);
          }else{
            _globalKey.currentState!.showSnackBar(getSnackBar(
                "Please check your internet connection.",
                "OK", _globalKey));
          }
        });
        return true;
      }
    } else{
      if(phone.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Email ID or Phone number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(phone.length<9){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter a valid Phone Number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter password",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      } else if(password.length<1){//!Validator().validatePassword(password)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "eefde",//"Please Enter 8 letters of combination of One Capital, Lower and Numeric characters",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else{
        check().then((internet) async{
          if (internet != null && internet) {
            String deviceId = await _getId();
            var data = {
              "email": phone,
              "password": password,
              "device_id": deviceId,
              //"ext": Constants.defaultCountryCode,
              //  "user_type": Constants.userTypePassenger,
            };
            _globalKey.currentContext!.read<PersonalDetailsCubit>().updateProfile(data, widget.accesstoken.toString(), int.parse(widget.id.toString()));
          }else{
            _globalKey.currentState!.showSnackBar(getSnackBar(
                "Please check your internet connection.",
                "OK", _globalKey));
          }
        });
        FocusScope.of(context).unfocus();
        return true;
      }
    }
  }*/
}
