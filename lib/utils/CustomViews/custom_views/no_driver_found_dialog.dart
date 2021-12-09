//import 'package:booking_package/models/response/location_bean.dart';
//import 'package:booking_package/models/response/master_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxiapp/Model/response/location_bean.dart';
import 'package:taxiapp/service/navigation_service.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../custom_views/custom_button.dart';

import 'my_text.dart';
/*import 'package:customer/utils/constants.dart';
import 'package:customer/utils/app_colors.dart';
import 'package:customer/utils/my_extentions.dart';
import 'package:customer/service/navigation_service.dart';
import 'package:customer/ui/customviews/my_error_dialog.dart';
import 'package:customer/route/route_constant.dart';*/

class NoDriverFoundDialog extends StatefulWidget {
  final Function? onTryAgain;
  final Function? onCancelRide;
  final LocationBean? fromLocationBean;
  final LocationBean? toLocationBean;

  NoDriverFoundDialog({
      this.fromLocationBean,
      this.toLocationBean,
      this.onTryAgain,
      this.onCancelRide
      });

  @override
  _NoDriverFoundDialogState createState() => _NoDriverFoundDialogState();
}

class _NoDriverFoundDialogState extends State<NoDriverFoundDialog> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                padding:
                    EdgeInsets.only(top: 15, bottom: 25, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        NavigationService().popUntil();
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // margin: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.zero,
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 25, left: 20, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: MyText(
                              text: 'Sorry no driver found at this location',
                              color: AppColors.themeGreenColor,
                              textAlign: TextAlign.center,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                label: 'Try Again',
                                onClick: () {
                                  widget!.onTryAgain!();

                                },
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: CustomButton(
                                color: AppColors.greyButtonBackgroundColor,
                                label: 'Cancel Ride',
                                onClick: () {
                                  widget!.onCancelRide!();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}