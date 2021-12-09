import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:customer/utils/app_colors.dart';

import '../../app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Color? color;
  final Function? onClick;

  CustomButton({@required this.label, this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color!= null ? color: AppColors.themeGreenColor
        ,
      ),
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: color!= null ? color: AppColors.themeGreenColor,
          height: 45,
          child: Text(label!,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ))),
      onPressed: (){onClick;},
    );
  }
}
