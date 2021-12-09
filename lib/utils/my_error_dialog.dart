import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class MyErrorDialog extends StatefulWidget {
      MyErrorDialog({this.str, this.onClick});

  final String? str;
  final Function? onClick;

  @override
  _MyErrorDialogState createState() => new _MyErrorDialogState();
}

class _MyErrorDialogState extends State<MyErrorDialog> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Container(
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
                  color: AppColors.hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 20),
          Divider(color: AppColors.textColorLight, height: 0.8),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: InkWell(
              onTap: ()=>widget.onClick,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "OK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.hintColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      height: 40,
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
