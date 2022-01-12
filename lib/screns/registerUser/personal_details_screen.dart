//import 'dart:io';
//import 'dart:math';
/*import 'package:customer/route/route_constant.dart';
import 'package:customer/ui/base/base_repo.dart';
import 'package:customer/ui/customviews/custom_button.dart';
import 'package:customer/ui/personal_details/personal_details_cubit.dart';
import 'package:customer/utils/constants.dart';
import 'package:customer/utils/app_colors.dart';
import 'package:customer/utils/AppUtils.dart';
import 'package:customer/utils/ColorHelper.dart';
import 'package:customer/utils/CustomPainter.dart';*/
//import 'package:customer/utils/Gap.dart';
//import 'package:customer/utils/ImageHelper.dart';
/*import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_cubit/flutter_cubit.dart';
/*import 'package:customer/service/navigation_service.dart';
import 'package:customer/utils/Constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:customer/ui/personal_details/nearby_state.dart';*/
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/screns/registerUser/personal_details_cubit.dart';
import 'package:taxiapp/screns/registerUser/nearby_state.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:taxiapp/utils/Constant.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final dynamic? data;

  PersonalDetailsScreen({this.data});

  @override
  State<StatefulWidget> createState() => PersonalDetailsScreenState();
}

class PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  // var _args;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();

  late bool isEditProfile, isProfileMode;
  String name = "";

  @override
  void initState() {
    super.initState();

    // print("TokenValue => ${AppUtils.token}");
    /*if (widget.data["fromPage"] == "dashboard") {
      isEditProfile = false;
      isProfileMode = false;

      _controllerName.text = '';
      // AppUtils.userData.fname == null ? "" : AppUtils.userData.fname;
      _controllerMobile.text = ''; //AppUtils.userData.phone_number == null
      // ? ""
      //  : AppUtils.userData.phone_number;
      _controllerEmail.text = '';
      //  AppUtils.userData.email == null ? "" : AppUtils.userData.email;
      _controllerAddress.text = '';
      // AppUtils.userData.address == null ? "" : AppUtils.userData.address;
    } else {
      isEditProfile = true;
      isProfileMode = true;

      //  _controllerName.text = AppUtils.fname;
      // _controllerMobile.text = AppUtils.userData.phone_number == null
      //    ? ""
      //   : AppUtils.userData.phone_number;
      // _controllerEmail.text =
      //     AppUtils.userData.email == null ? "" : AppUtils.userData.email;
      //  _controllerAddress.text = "";
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // _args = ModalRoute.of(context).settings.arguments;
    return Container(
      //onWillPop: () => ,
      child: BlocProvider(
        create: (context) =>
            PersonalDetailsCubit(repo: BaseRepo(), accessToken: AppUtils.token),
        child: Scaffold(
          key: _globalKey,
          appBar: AppBar(
            title:Text('register')
           /* leading: widget.data["fromPage"] == "dashboard"
                ? GestureDetector(
              onTap: () {
                if (widget.data["isUpdated"]) {
                  NavigationService()
                      .navigationKey
                      .currentState;
                  //.pushNamed(dashboard);
                } else {
                  NavigationService().navigationKey.currentState!.pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(left: 18, right: 5),
                child: Text('Register'), /*SvgPicture.asset(
                        backArrowIcon,
                        color: whiteColor,
                        width: 16,
                        height: 16,
                      ),*/
              ),
            )
                : GestureDetector(
              onTap: () {
                NavigationService().navigationKey.currentState!.pop();
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 5),
                  child: Icon(Icons.arrow_back) /*()SvgPicture.asset(
                  backArrowIcon,
                  color: Color(0xffFFFFFF),
                  width: 16,
                  height: 16,
                ),*/
              ),
            ),
            elevation: 0.0,
            //  backgroundColor: kPrimaryColor,
            brightness: Brightness.dark,*/
          ),
          body: BlocConsumer<PersonalDetailsCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showLoader("Updating profile.......");
                }
                /*if (state is GetOtpLoadingState) {
                  showLoader("Uploading picture.......");
                }
                if (state is GetProfileDataState) {
                  hideLoader();
                  print("Picture updated successfully....");
                  FocusScope.of(context).requestFocus(FocusNode());
                  _globalKey.currentState!.showSnackBar(getSnackBar(
                      "Picture updated successfully", "OK", _globalKey));
                }*/
                if (state is ProfileSuccessState) {
                  hideLoader();
                //  print(result.)
                  //print("Profile Update Value -> ${state.response}");
                 /* if (widget.data["fromPage"] == "dashboard") {
                    // NavigationService().pushNamedAndRemoveUntil(dashboard);
                    NavigationService().popUntil();
                  } else {
                    // TaxiUKPrefs.instance.saveLoginStatus(true);
                    // SharedPreferenceUtils().saveAccessToken(AppUtils.token);
                    NavigationService()
                        .navigationKey
                        .currentState!;
                    // .pushNamedAndRemoveUntil(login, (route) => false);
                  }*/
                }
                if (state is ProfileErrorState) {
                  //print("error => ${state.response}");
                  hideLoader();
                  FocusScope.of(context).requestFocus(FocusNode());
                  _globalKey.currentState!.showSnackBar(
                      getSnackBar(state.response["success"], "OK", _globalKey));
                }
              },
              listenWhen: (previous, current) => previous != current,
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) =>
                  Stack(children: [

                    RegisterProfile(
                        onClick: (Map<String, dynamic> params) {
                          // NavigationService().navigationKey.currentState.pushNamed(login);
                          //context.read<PersonalDetailsCubit>().updateProfile(
                            //  params);
                        }
                    )
                  ])),
        ),
      ),
    );
  }
}
  /*Widget _mainUi() =>
      Container(
         // color: AppColors.backgroundColor,
          height: double.infinity,
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: 260,
              child: CustomPaint(
               // painter: LogoPainter(),
              ),
            ),
            SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(height: 30.0),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  margin: EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Personal Details',
                            style: TextStyle(
                              height: 1.4,
                              fontFamily: "Gilroy",
                              //color: ,
                              fontWeight: FontWeight.w700,
                              fontSize: 28.0,
                            )),
                        SizedBox(height: 14.0),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 90,
                            height: 90,
                            child: Stack(
                              children: [
                              /*  imageFile == null
                                    ? AppUtils.userData.picUrl == null
                                    ? ClipOval(
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    color: kPrimaryColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(22),
                                      child: SvgPicture.asset(
                                        userDefaultIcon,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                )
                                    : ClipOval(
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    color: kPrimaryColor,
                                    child: Image.network(
                                      "${Constants.baseUrlImage}${AppUtils
                                          .userData.picUrl}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : ClipOval(
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    color: kPrimaryColor,
                                    child: Image.file(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                isEditProfile
                                    ? Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    child: Container(
                                      margin:
                                      EdgeInsets.fromLTRB(12, 0, 0, 0),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: SvgPicture.asset(
                                          editProfile,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    onTap: () => _showPicker(),
                                  ),
                                )
                                    : Container()*/
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 18.0),
                        TextFormField(
                          textAlign: TextAlign.start,
                          controller: _controllerName,
                          textAlignVertical: TextAlignVertical.center,
                          //cursorColor: AppColors.themeGreenColor,
                          maxLines: 1,
                          maxLength: 15,
                          enabled: isEditProfile,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              //color: kPrimaryColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red),
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.green)),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(
                            //     height: 1,
                            //     fontFamily: "Gilroy",
                            //     fontSize: 16.0,
                            //     color: kPrimaryColor,
                            //     fontWeight: FontWeight.w500),
                          ),
                          style: TextStyle(
                              height: 1,
                              fontSize: 16.0,
                              //color: AppColors.themeGreenColor,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            print("Enter value :- $value");
                            name = value;
                          },
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controllerMobile,
                                enabled: false,
                                textAlignVertical: TextAlignVertical.center,
                                //cursorColor: Colors,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_rounded,
                                    //color: kPrimaryColor,
                                  ),
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.yellow)),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.yellow)),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                      height: 1,
                                      fontSize: 16.0,
                                      //color: AppColors.hintColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 16.0,
                                   // color: AppColors.themeGreenColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            isEditProfile
                                ? Row(
                              children: [
                                SizedBox(width:15,),
                              //  HorizontalGap(gap: 15),
                                InkWell(
                                  child: Icon(
                                    Icons.edit_rounded,
                                    size: 24,
                                    //color: gpsIconColor,
                                  ),
                                  onTap: () {
                                    var passArgs = {
                                      "title": "Update Phone Number",
                                      "isMobile": true,
                                      "value": _controllerMobile.text
                                          .toString()
                                          .trim(),
                                      "fromPage": widget.data["fromPage"],
                                      "accessToken": AppUtils.token
                                    };

                                    if (AppUtils.fname.isNotEmpty) {
                                      AppUtils.fname = AppUtils.fname;
                                    } else {
                                      AppUtils.fname = name;
                                    }

                                    print(
                                        "fname :: ${AppUtils
                                            .fname}, lname :: ${AppUtils
                                            .lname}");
                                    NavigationService()
                                        .navigationKey
                                        .currentState;
                                       // .pushNamed(UpdateEmailMobilePage,
                                      //  arguments: passArgs);
                                  },
                                ),
                                SizedBox(width: 8),
                              ],
                            )
                                : Container(
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controllerEmail,
                                textAlignVertical: TextAlignVertical.center,
                               // cursorColor: AppColors.themeGreenColor,
                                maxLines: 1,
                                enabled: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_rounded,
                                    //  color: kPrimaryColor
                                  ),
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow//AppColors.themeGreenColor
                                    ),
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: //AppColors.themeGreenColor
                                          Colors.yellow )),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.yellow)),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      height: 1,
                                      fontSize: 16.0,
                                      //color: AppColors.hintColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 16.0,
                                 //   color: AppColors.themeGreenColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            isEditProfile
                                ? Row(
                              children: [
                               // HorizontalGap(gap: 15),
                                InkWell(
                                  child: Icon(
                                    Icons.edit_rounded,
                                    size: 24,
                                  //  color: gpsIconColor,
                                  ),
                                  onTap: () {
                                    var passArgs = {
                                      "title": "Update Email",
                                      "isMobile": false,
                                      "value": _controllerEmail.text
                                          .toString()
                                          .trim(),
                                      "fromPage": widget.data["fromPage"],
                                      "accessToken": AppUtils.token
                                    };

                                    if (AppUtils.fname.isNotEmpty) {
                                      AppUtils.fname = AppUtils.fname;
                                    } else {
                                      AppUtils.fname = name;
                                    }

                                    print(
                                        "fname :: ${AppUtils
                                            .fname}, lname :: ${AppUtils
                                            .lname}");
                                    NavigationService()
                                        .navigationKey
                                        .currentState;
                                       // .pushNamed(UpdateEmailMobilePage,
                                  //      arguments: passArgs);
                                  },
                                ),
                                //HorizontalGap(gap: 8),
                              ],
                            )
                                : Container(
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _controllerAddress,
                          textAlignVertical: TextAlignVertical.center,
                         // cursorColor: AppColors.themeGreenColor,
                          maxLines: 1,
                          enabled: isEditProfile,
                          decoration: InputDecoration(
                            // labelStyle: TextStyle(
                            //     height: 1,
                            //     fontFamily: "Gilroy",
                            //     fontSize: 16.0,
                            //     color: AppColors.themeGreenColor,
                            //     fontWeight: FontWeight.w500),
                            prefixIcon: Icon(
                              Icons.location_on_rounded,
                             // color: kPrimaryColor,
                            ),
                            counterText: '',
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.yellow),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.yellow),
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.yellow)),
                            // labelText: 'Address',
                            hintStyle: TextStyle(
                                height: 1,
                                fontSize: 16.0,
                              //  color: AppColors.hintColor,
                                fontWeight: FontWeight.w500),
                          ),
                          style: TextStyle(
                              height: 1,
                              fontSize: 16.0,
                            //  color: AppColors.themeGreenColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        MaterialButton(
                          child: Text(isEditProfile ? "Done" : "Edit Profile"),
                          onPressed: () {
                            if (isProfileMode) {
                              isEditProfile = true;
                              String fname = _controllerName.text.toString()
                                  .trim();
                              String address =
                              _controllerAddress.text.toString().trim();

                              if (fname.isEmpty) {
                                FocusScope.of(context).unfocus();
                                _globalKey.currentState!.showSnackBar(
                                    getSnackBar(
                                        "Please enter full name", "OK",
                                        _globalKey));
                              } else {
                                check().then((internet) {
                                  if (internet != null && internet) {
                                    if (address.isNotEmpty) {
                                      var data = {
                                        "name": fname,
                                        "address": address
                                      };
                                      _globalKey.currentContext
                                          .cubit<PersonalDetailsCubit>()
                                          .updateProfile(data);
                                    } else {
                                      var data = {"name": fname};
                                      _globalKey.currentContext
                                          .cubit<PersonalDetailsCubit>()
                                          .updateProfile(data);
                                    }
                                  } else {
                                    FocusScope.of(context).unfocus();
                                    _globalKey.currentState!.showSnackBar(
                                        getSnackBar(
                                            "Please check your Internet Connection",
                                            "OK",
                                            _globalKey));
                                  }
                                });
                              }
                            } else {
                              isProfileMode = true;
                              isEditProfile = true;
                              setState(() {});
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ]),
            )
          ]));*/

  /*bool _isValidate() {
    if (_controllerName.text.isEmpty) {
      _globalKey.currentState!.showSnackBar(
          getSnackBar("Please enter full name", "OK", _globalKey));
      FocusScope.of(context).unfocus();
      return false;
    }
    return true;
  }*/

/* final imagePicker = ImagePicker();
  String _profilePicUrl;
  File imageFile;

  _imgFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      var params = FormData.fromMap({
        "type": Constants.uploadImageTypeProfileImage,
        "profile_image": await MultipartFile.fromFile(
            File(pickedFile.path).path,
            filename: "${File(pickedFile.path).path.split('/').last}"),
      });
      imageFile = File(pickedFile.path);
      check().then((internet) {
        if (internet != null && internet) {
          _globalKey.currentContext
              .cubit<PersonalDetailsCubit>()
              .updateProfilePic(params);
        } else {
          _globalKey.currentState.showSnackBar(getSnackBar(
              "Please check your Internet Connection", "OK", _globalKey));
        }
      });

      setState(() {});
    }
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      var params = FormData.fromMap({
        "type": Constants.uploadImageTypeProfileImage,
        "profile_image": await MultipartFile.fromFile(
            File(pickedFile.path).path,
            filename: "${File(pickedFile.path).path.split('/').last}"),
      });
      imageFile = File(pickedFile.path);
      check().then((internet) {
        if (internet != null && internet) {
          _globalKey.currentContext
              .cubit<PersonalDetailsCubit>()
              .updateProfilePic(params);
        } else {
          _globalKey.currentState.showSnackBar(getSnackBar(
              "Please check your Internet Connection", "OK", _globalKey));
        }
      });

      setState(() {});
    }
  }*/

/* void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }*/

/* Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    if (widget.data["fromPage"] == "dashboard") {
      if (widget.data["isUpdated"]) {
        NavigationService().navigationKey.currentState.pushNamed(dashboard);
      } else {
        NavigationService().navigationKey.currentState.pop();
      }
      return Future<bool>.value(true);
    } else {
      _globalKey.currentState.showSnackBar(
          getSnackBar("Please fill all mandatory fields", "OK", _globalKey));
      return Future<bool>.value(false);
    }
  }
}*/
//}
class RegisterProfile extends StatefulWidget {
 // const RegisterProfile({Key? key}) : super(key: key);
  final Function? onClick;
  RegisterProfile({this.onClick});

  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
 // Random random = new Random();
  //deviceId(){
  //return random.nextInt(100);}
  //int deviceid = random.nextInt(100);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _firstname = TextEditingController(text: 'amit');
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _deviceid = TextEditingController(text: 'dejiqijdij374');
  TextEditingController _deviceType = TextEditingController(text: 'ios');
  TextEditingController _password = TextEditingController(text: '123456789');
  TextEditingController _lastname = TextEditingController(text: 'singh');
  TextEditingController _email = TextEditingController(text: 'mailkk2232@gmail.com');
  TextEditingController _city  = TextEditingController(text: 'jaipur');
  TextEditingController _username = TextEditingController(text: 'dejiqiffwjd');

  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: SafeArea(
          child: _buildUI(),
        ));
  }

  Widget _buildUI() => Container(
    height: MediaQuery.of(context).size.height,
    child: Stack(
     children:[

        SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text('Enter Phone Number For Verification',
                          style: TextStyle(
                            height: 1.4,
                            //color: AppColors.themeGreenColor,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 28.0,
                          )),
                      SizedBox(height: 12),
                      //VerticalGap(gap: 12),
                      Text('A verification code will be sent to this number',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                         // color: AppColors.textColorLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 36),
                      Row(
                        children: [

                          SizedBox(width: 8),
                          Text(
                            "+44",
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                //color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                         // HorizontalGap(gap: 10),
                          Text(
                            "(0)",
                            style: TextStyle(
                                fontFamily: "Gilroy",
                              //  color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),

                          SizedBox(height: 10),
                          Expanded(
                            child: Container(
                                child: TextField(
                                  controller: _controllerMobile,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 15,
                                 // cursorColor: AppColors.themeGreenColor,
                                  decoration: InputDecoration(
                                    suffixIcon: isEditing ? IconButton(
                                      icon: Icon(Icons.close_rounded,
                                        color: Colors.grey,),
                                      onPressed: () {
                                        setState(() {
                                          _controllerMobile.text = '';
                                        });
                                      },
                                    ) : Container(
                                      width: 12,
                                      height: 12,
                                    ),
                                    counterText: '',
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(
                                        height: 1,
                                        fontFamily: "Gilroy",
                                        fontSize: 18.0,
                                       // color: textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (value){
                                    if(value.length>0){
                                      setState(() {
                                        isEditing = true;
                                      });
                                    }else{
                                      setState(() {
                                        isEditing = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontFamily: "Gilroy",
                                      height: 1,
                                      fontSize: 18.0,
                                      //color: AppColors.themeGreenColor,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ],
                      ),
                      /*TextField(
                        controller: _controllerMobile,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        // cursorColor: AppColors.themeGreenColor,
                        /*decoration: InputDecoration(
                          suffixIcon: isEditing ? IconButton(
                            icon: Icon(Icons.close_rounded,
                              color: Colors.grey,),
                            onPressed: () {
                              setState(() {
                                _controllerMobile.text = '';
                              });
                            },
                          ) : Container(
                            width: 12,
                            height: 12,
                          ),
                          counterText: '',
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              height: 1,
                              fontFamily: "Gilroy",
                              fontSize: 18.0,
                              // color: textColor,
                              fontWeight: FontWeight.w500),
                        ),*/
                        onChanged: (value){
                          if(value.length>0){
                            setState(() {
                              isEditing = true;
                            });
                          }else{
                            setState(() {
                              isEditing = false;
                            });
                          }
                        },
                        style: TextStyle(
                            fontFamily: "Gilroy",
                            height: 1,
                            fontSize: 18.0,
                            //color: AppColors.themeGreenColor,
                            fontWeight: FontWeight.w600),
                      ),
                      TextField(
                        controller: _controllerMobile,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        // cursorColor: AppColors.themeGreenColor,
                        /*decoration: InputDecoration(
                          suffixIcon: isEditing ? IconButton(
                            icon: Icon(Icons.close_rounded,
                              color: Colors.grey,),
                            onPressed: () {
                              setState(() {
                                _controllerMobile.text = '';
                              });
                            },
                          ) : Container(
                            width: 12,
                            height: 12,
                          ),
                          counterText: '',
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              height: 1,
                              fontFamily: "Gilroy",
                              fontSize: 18.0,
                              // color: textColor,
                              fontWeight: FontWeight.w500),
                        ),*/
                        onChanged: (value){
                          if(value.length>0){
                            setState(() {
                              isEditing = true;
                            });
                          }else{
                            setState(() {
                              isEditing = false;
                            });
                          }
                        },
                        style: TextStyle(
                            fontFamily: "Gilroy",
                            height: 1,
                            fontSize: 18.0,
                            //color: AppColors.themeGreenColor,
                            fontWeight: FontWeight.w600),
                      ),
                      TextField(
                        controller: _controllerMobile,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        // cursorColor: AppColors.themeGreenColor,
                        /*decoration: InputDecoration(
                          suffixIcon: isEditing ? IconButton(
                            icon: Icon(Icons.close_rounded,
                              color: Colors.grey,),
                            onPressed: () {
                              setState(() {
                                _controllerMobile.text = '';
                              });
                            },
                          ) : Container(
                            width: 12,
                            height: 12,
                          ),
                          counterText: '',
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              height: 1,
                              fontFamily: "Gilroy",
                              fontSize: 18.0,
                              // color: textColor,
                              fontWeight: FontWeight.w500),
                        ),*/
                        onChanged: (value){
                          if(value.length>0){
                            setState(() {
                              isEditing = true;
                            });
                          }else{
                            setState(() {
                              isEditing = false;
                            });
                          }
                        },
                        style: TextStyle(
                            fontFamily: "Gilroy",
                            height: 1,
                            fontSize: 18.0,
                            //color: AppColors.themeGreenColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),*/
                      SizedBox(height: 30.0),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: InkWell(
                            onTap: () {
                              if (isValidate()) {
                                widget.onClick!({
                                  'firstName': _firstname.text,/*'9818676867',*/ //_controllerMobile
                                      //.text,
                                  'mobile': _controllerMobile.text,//Constants.defaultCountryCode, /*_controllerCC.text*/
                                  'deviceId': _deviceid.text,//Constants.userTypePassenger,
                                  'deviceType': _deviceType.text,//Constants.loginTypeRegistration,
                                  'password': _password.text,
                                  'lastName': _lastname.text,
                                  'email': _email.text,
                                  'city':  _city.text,
                                  'userName': _username.text
                                });
                              }
                            },
                            //=> Navigator.pushNamed(context, "verifyphone"),
                            child: new Container(
                              height: 50.0,
                              decoration: new BoxDecoration(
                                color: Colors.blue,//Color(0xff004238),
                                //border: new Border.all(color: Colors.white, width: 2.0),
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              child: new Center(
                                child: new Text(
                                  'Next',
                                  style: new TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )),


                // )*/
           /*   ]),
        )
      ],
    ),
  )]));
  bool isValidate() {
    if (_controllerMobile.text.isEmpty) {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.showSnackBar(getSnackBar(
          'Please enter Mobile Number',
          "OK", _globalKey));
      return false;
    } else if (_controllerMobile.text.length < 10) {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.showSnackBar(getSnackBar(
          'Please enter a valid Mobile Number',
          "OK", _globalKey));
      return false;
    }
    return true;
  }
  }
*/



