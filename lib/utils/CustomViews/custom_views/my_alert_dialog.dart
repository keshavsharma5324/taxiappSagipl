import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {

  MyAlertDialog({this.str, this.btn1, this.btn2, this.onClick,  this.onClick2});

  final String? str;
  final String? btn1;
  final String? btn2;
  final Function? onClick;
  final Function? onClick2;

  @override
  _MyAlertDialogState createState() => new _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {

  _getContent() => Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            widget.str.toString(),
            style: TextStyle(
                color: Color(0xff004238),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20),
        Divider(color: Color(0xff004238), height: 0.8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){widget.onClick;},
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    widget.btn1.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff004238),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: widget.btn2 != null,
                child: Container(
                    color: Color(0xff004238),
                    height: 40.0,
                    width: 0.8)),
            Visibility(
              visible: widget.btn2 != null,
              child: Expanded(
                child: InkWell(
                  onTap: (){widget.onClick2;},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      widget.btn2 == null ? '' : widget.btn2.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff004238),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => _getContent();
}
