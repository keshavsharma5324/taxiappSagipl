import 'package:flutter/material.dart';

class MyAlertDialog2 extends StatefulWidget {

  MyAlertDialog2({this.str, this.btn1, this.btn2, this.onClick, this.onClick2});

  final String? str;
  final String? btn1;
  final String? btn2;
  final Function? onClick;
  final Function? onClick2;

  @override
  _MyAlertDialog2State createState() => new _MyAlertDialog2State();
}

class _MyAlertDialog2State extends State<MyAlertDialog2> {

  _getContent() => Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 35),
          child: Text(
            widget.str.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff004238),
                fontSize: 16,
                height: 1.3,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){widget.onClick;},
              child: Container(
                alignment: Alignment.center,
                height: 40,
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Text(
                  'YES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff004238),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            InkWell(
              onTap: (){widget.onClick2;},
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'NO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff004238),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => _getContent();
}
