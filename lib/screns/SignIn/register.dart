
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/Constant.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  final Function onClick;
  Register({required this.onClick});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _controllerpassword = TextEditingController();
  TextEditingController _controllerusername = TextEditingController();
  TextEditingController _controllerfirstname = TextEditingController();
  TextEditingController _controllerlastname = TextEditingController();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  bool isEditing = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){NavigationService().navigationKey.currentState!.pop();},icon: Icon(Icons.arrow_back,color: Colors.black,),),title:Text('Registration',textAlign: TextAlign.start,style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
        body:Stack(
      children:[
      SingleChildScrollView(child:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child:Column(
        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Align(alignment: Alignment.center,child:Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.25), // border color
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(2), // border width
              child: Container( // or ClipRRect if you need to clip the content
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey, // inner circle color
                ),
                child: Icon(Icons.account_box_rounded,size:50), // inner content
              ),
            ),
          ),),
          SizedBox(height: 30,),

          Text('First Name',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 7,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              controller: _controllerfirstname,
              //obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'First Name',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),
          SizedBox(height: 20,),

          Text('Last Name',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 7,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              controller: _controllerlastname,
              //obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'Last Name',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),
          SizedBox(height: 20,),

          Text('Email',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 7,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              controller: _controlleremail,
             // obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'Enter Email',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),
          SizedBox(height: 20,),


          Text('Phone Number',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 7,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              controller: _controllerMobile,
              // obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'Enter Phone Number',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),

          SizedBox(height: 20,),

          Align(alignment: Alignment.center,child:Text('I agree the terms and conditions',style: TextStyle(color: Colors.amber,
          decoration: TextDecoration.underline),),),
          SizedBox(height: 7,),


          SizedBox(height: 30,),

          Container(height: 55,width:MediaQuery. of(context). size. width ,color:kPrimaryColor,child:FlatButton(onPressed: (){
          showModalBottomSheet(
          context: context, builder: (context) {
          return Container(height:350,padding:EdgeInsets.symmetric(horizontal: 20),child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              Text('User Name',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 10,),
              Material(
                elevation: 5,
                shadowColor: Color(0xffF5F5F5),
                child: TextFormField(
                  controller: _controllerusername,
                  //obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                    //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                      hintText: 'Enter User Name',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: Colors.white, width: 1.0))
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Text('Password',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 10,),
              Material(
                elevation: 5,
                shadowColor: Color(0xffF5F5F5),
                child: TextFormField(
                  controller: _controllerpassword,
                  //obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                    //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                      hintText: 'Enter password',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: Colors.white, width: 1.0))
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(height: 55,width:MediaQuery. of(context). size. width ,color:kPrimaryColor,child:FlatButton(onPressed: () async {
                if (isValidate()) {

                    /*Navigator.of(NavigationService().navigationKey.currentContext!,
                        rootNavigator: true)
                        .pop();*/

                  String deviceId = await _getId();
                  widget.onClick({
                    'first_name': _controllerfirstname.text,
                    'last_name':  _controllerlastname.text,
                    'username': /*'9818676867',*/_controllerMobile.text,
                    'password':  _controllerpassword.text,
                    'email': _controlleremail.text,
                    'mobile':  _controllerMobile.text,
                    'device_id': deviceId,
                    //'ext': _controllerCC.text,
                    //'user_type': Constants.userTypePassenger,
                    //'type': Constants.loginTypeRegistration
                  });
                  //NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                  //Navigator.pop(context);
                }

              }, child: Center(child:Text('SUBMIT',style: TextStyle(color: Colors.white),),))),


            ],



          ));});


          },child: Text('SUBMIT',style: TextStyle(color: Colors.white),),))


        ],
      )))]),/*bottomSheet: Container(child:isEditing?Container(height: 250,child: Column(children:[
        SizedBox(height: 30,),

          Text('User Name',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 10,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              //obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'Enter User Name',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),
          SizedBox(height: 20,),

          Text('E-mail',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 10,),
          Material(
            elevation: 5,
            shadowColor: Color(0xffF5F5F5),
            child: TextFormField(
              //obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                  hintText: 'Enter password',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.0))
              ),
            ),
          ),
      SizedBox(height: 30,),
    Container(height: 55,width:MediaQuery. of(context). size. width ,color:kPrimaryColor,child:FlatButton(onPressed: (){}, child: Center(child:Text('Submit',style: TextStyle(color: Colors.white),),)))

    ]),):Text('fgyrewrfjnuwjn'))*/

    );
  }
  bool isValidate() {
   /* if (_controllerMobile!.text.isEmpty) {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.showSnackBar(getSnackBar(
          'Please enter Mobile Number',
          "OK", _globalKey));
      return false;
    } else if (_controllerMobile!.text.length < 10) {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.showSnackBar(getSnackBar(
          'Please enter a valid Mobile Number',
          "OK", _globalKey));
      return false;
    }*/
    return true;
  }
}
