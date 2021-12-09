
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxiapp/Model/master_response.dart';
import 'package:taxiapp/Model/response/location_bean.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/my_error_dialog.dart';
import 'package:taxiapp/utils/my_extentions.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../custom_views/custom_button.dart';
import 'my_text.dart';

class BookNowDialog extends StatefulWidget {
  final List<MasterBean>? list;
  final Function? onClickBookNow;
  final Function? onClickPreBook;
  final Function? onClickSource;
  final Function? onClickDest;
  final Function? onClickGpsIcon;
  final LocationBean? fromLocationBean;
  final LocationBean? toLocationBean;

  BookNowDialog(
      {this.list,
      this.fromLocationBean,
      this.toLocationBean,
      this.onClickBookNow,
      this.onClickPreBook,
      this.onClickSource,
      this.onClickDest,
      this.onClickGpsIcon});

  @override
  _BookNowDialogState createState() => _BookNowDialogState();
}

class _BookNowDialogState extends State<BookNowDialog> {
  PanelController _panelController = PanelController();

  var _arrowIcon = 'arrow_up.svg';

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
                        NavigationService().goBack();
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
                                InkWell(
                                  onTap: () {
                                    widget.onClickSource!();
                                  },
                                  child: MyText(
                                      text: widget.fromLocationBean!.address.toString(),
                                      maxLines: 1,
                                      color: AppColors.themeGreenColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  thickness: 1.0,
                                  color: AppColors.themeGreenColor,
                                  height: 1.5,
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    widget.onClickDest!();
                                  },
                                  child: MyText(
                                      text: widget.toLocationBean!.address.toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      color: AppColors.themeGreenColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
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
                InkWell(
                  onTap: () {
                    widget.onClickGpsIcon!();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 35),
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.zero,
                  elevation: 10,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SlidingUpPanel(
                          onPanelClosed: () {
                            setState(() {
                              _arrowIcon = 'arrow_up.svg';
                            });
                          },
                          onPanelOpened: () {
                            setState(() {
                              _arrowIcon = 'arrow_down.svg';
                            });
                          },
                          controller: _panelController,
                          body: Container(
                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          )),
                          header: Container(height: 245, color: Colors.blue),
                          minHeight: 165,
                          maxHeight: 245,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          panel: Container(
                            padding:
                                EdgeInsets.only(top: 15, left: 20, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                            text: 'Choose your ride',
                                            color: AppColors.themeGreenColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                        InkWell(
                                            onTap: () {
                                              if (!_panelController
                                                  .isPanelOpen) {
                                                  _panelController.open();

                                              } else {

                                                  _panelController.close();

                                              }
                                            },
                                            child: SvgPicture.asset(
                                                '${Constants.baseAssetPathBooking}$_arrowIcon')),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 115,
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: widget.list!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            _buildListItem(index)),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _showDialog();
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    // '${Constants.baseAssetPathBookingPng}marker_a.png',
                                                    '${Constants.baseAssetPathBooking}manage_card.svg',
                                                    width: 12,
                                                    height: 12),
                                                SizedBox(width: 5.0),
                                                MyText(
                                                  text: 'In App Payment',
                                                  color: AppColors
                                                      .textColorGreyLight,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(width: 5.0),
                                                _unSelected(),
                                              ],
                                            ),
                                          ),
                                          MyText(
                                            text: 'Default Payment',
                                            color: AppColors.textColorGreyLight,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors
                                                      .themeGreenColor),
                                              height: 12,
                                              width: 12,
                                              alignment: Alignment.center,
                                              child: MyText(
                                                  text: '£',
                                                  fontSize: 7,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(width: 5.0),
                                          MyText(
                                            text: 'Cash Payment',
                                            color: AppColors.textColorGreyLight,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(width: 5.0),
                                          _selected()
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: MyText(
                                        text:
                                            'No additional charges for larger London Taxis.\n(Meter price applies)',
                                        color: AppColors.themeGreenColor,
                                        textAlign: TextAlign.center,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                          )),
                      Container(
                        padding:
                            EdgeInsets.only(bottom: 25, left: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                label: 'Book Now',
                                onClick: () {
                                  var index = widget.list!.indexWhere(
                                      (element) => element.isSelected == true);
                                  if (index == -1) {
                                    'Please select atleast one Ride'.showToast;
                                  } else {
                                    widget!.onClickBookNow!({
                                      'pickup_latitude':
                                          widget.fromLocationBean!.latitude,
                                      //'51.51413515001933',
                                      'pickup_longitude':
                                          widget.fromLocationBean!.longitude,
                                      //'-0.09864961346725916',
                                      'pickup_address':
                                          widget.fromLocationBean!.address,
                                      'pickup_address_type': '',
                                      'drop_latitude':
                                          widget.toLocationBean!.latitude,
                                      //'51.51413515001933',
                                      'drop_longitude':
                                          widget.toLocationBean!.longitude,
                                      //'-0.09864961346725916',
                                      'drop_address':
                                          widget.toLocationBean!.address,
                                      'drop_address_type': '',
                                      'payment_mode':
                                          Constants.paymentMethodCash,
                                      'taxi_model': widget.list![index].id,
                                      //'1',
                                      // 'distance': '12345',
                                      // 'time': '123',
                                      'booking_type':
                                          Constants.bookingTypeInstant
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: CustomButton(
                                color: AppColors.greyButtonBackgroundColor,
                                label: 'Pre Book',
                                onClick: () {
                                  var index = widget.list!.indexWhere(
                                      (element) => element.isSelected == true);
                                  if (index == -1) {
                                    'Please select atleast one Ride'.showToast;
                                  } else {
                                    widget!.onClickPreBook!({
                                      'pickup_latitude':
                                          widget.fromLocationBean!.latitude,
                                      'pickup_longitude':
                                          widget.fromLocationBean!.longitude,
                                      'pickup_address':
                                          widget.fromLocationBean!.address,
                                      'pickup_address_type': '',
                                      'drop_latitude':
                                          widget.toLocationBean!.latitude,
                                      'drop_longitude':
                                          widget.toLocationBean!.longitude,
                                      'drop_address':
                                          widget.toLocationBean!.address,
                                      'drop_address_type': '',
                                      'payment_mode':
                                          Constants.paymentMethodCash,
                                      'taxi_model': widget.list![index].id,
                                      'booking_type':
                                          Constants.bookingTypePreBook
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) => Row(
        children: [
          InkWell(
            onTap: () {
              int selectedIndex = widget.list
                  !.indexWhere((element) => element.isSelected == true);
              setState(() {
                if (selectedIndex != -1)
                  widget.list![selectedIndex].isSelected = false;
                widget.list![index].isSelected = true;
              });
            },
            child: Container(
              width: 120,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Image.network(
                            "${Constants.baseUrlImage}${widget.list![index].image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        MyText(
                            maxLines: 1,
                            text: widget.list![index].model.toString(),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                                text: widget.list![index].noOfPassenger.toString(),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0),
                            Icon(Icons.person,
                                color: AppColors.themeGreenColor, size: 12),
                            Icon(Icons.airline_seat_recline_normal,
                                color: AppColors.themeGreenColor, size: 12),
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.list![index].isSelected,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: _selected())),
                    replacement: Container(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget _unSelected() => Container(
      //padding: EdgeInsets.fromLTRB(58, 5, 0, 0),
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
            color: Color(0xff707070), //(0xffF5F5F5),
            width: 1),
      ));

  Widget _selected() => Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: Color(0xff07D11B),
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white, //(0xffF5F5F5),
              width: 1),
          // borderRadius: BorderRadius.circular(35),
        ),
        child: Icon(
          Icons.check,
          size: 10,
          color: Colors.white,
        ),
      );

  void _showDialog() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(0.0),
            content: MyErrorDialog(
              str: 'This Section is under Development',
              onClick: () {
                Navigator.of(context).pop();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ));
      });
}
