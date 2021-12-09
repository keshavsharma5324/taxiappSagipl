import 'dart:ui';
/*import 'package:avatar_glow/avatar_glow.dart';
// import '../custom_views/avtar_glow.dart';
import 'package:booking_package/models/response/location_bean.dart';
import 'package:customer/utils/app_colors.dart';
import 'package:customer/utils/constants.dart';*/
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxiapp/Model/response/location_bean.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../custom_views/custom_button.dart';
import 'my_text.dart';

class WaitingDialog extends StatefulWidget {
  final LocationBean? fromLocationBean;
  final LocationBean? toLocationBean;
  final Function? onCancelClick;
  final Function? onClickGpsIcon;

  WaitingDialog(
      {this.fromLocationBean,
      this.toLocationBean,
      this.onCancelClick,
      this.onClickGpsIcon});

  @override
  _WaitingDialogState createState() => _WaitingDialogState();
}

class _WaitingDialogState extends State<WaitingDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 25, left: 20, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // NavigationService().goBack();
                          },
                          child: SvgPicture.asset(
                            '${Constants.baseAssetPathBooking}back_icon.svg',
                            color: AppColors.themeGreenColor,
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.themeRedColor,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 7,
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Color(0XFF2D6159),
                                      width: 1,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 13),
                                    height: 7,
                                    width: 7,
                                    color: AppColors.themeGreenColor,
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: widget.fromLocationBean!.address,
                                        maxLines: 1,
                                        color: AppColors.themeGreenColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(height: 5),
                                    Divider(
                                      thickness: 1.0,
                                      color: AppColors.themeGreenColor,
                                      height: 1.5,
                                    ),
                                    SizedBox(height: 20),
                                    MyText(
                                        text: widget.toLocationBean!.address,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        color: AppColors.themeGreenColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(height: 5),
                                    Divider(
                                      thickness: 1.0,
                                      color: AppColors.themeGreenColor,
                                      height: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: AvatarGlow(
                  glowColor: Color(0xFD1082E3),
                  endRadius: 150.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Container(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      widget!.onClickGpsIcon!();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          color: Colors.white),
                      child: Icon(
                        Icons.location_searching_rounded,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: CustomButton(
                        color: AppColors.themeGreenColor,
                        label: 'Cancel Booking',
                        onClick: () {
                          widget!.onCancelClick!();
                        }),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
