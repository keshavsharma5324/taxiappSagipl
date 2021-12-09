
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxiapp/utils/ColorHelper.dart';

class otpScreen extends StatefulWidget {
  //const otpScreen({Key? key}) : super(key: key);

  @override
  _otpScreenState createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Phone Number',style: TextStyle(color:Colors.black),),backgroundColor: Colors.white,),
      body: Container(padding: EdgeInsets.symmetric(horizontal: 30),color: Colors.white54,
      child:Column(children: [
        SizedBox(height: 100,),
        Container(height: 300, decoration: BoxDecoration(

            border: Border.all(
              color: Colors.black12
              //color: Colors.red[500],
            ),color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
          child: Column(children: [
            SizedBox(height: 10,),
            Text('Enter the 4-digit code sent',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(' at xyz number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            Container(width:300,padding:EdgeInsets.symmetric(horizontal: 20),child:PinCodeTextField(
              length: 4,cursorColor: Colors.white,
              obscureText: false,
              animationType: AnimationType.none,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60,
                fieldWidth: 60,
                inactiveColor: Colors.grey,
                selectedColor: Colors.grey,
                activeColor: Colors.white,
                disabledColor: Colors.white,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              //enableActiveFill: true,
             // errorAnimationController: errorController,
              controller: textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  var currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              }, appContext: context,
            )),
            SizedBox(height: 20,),
            Row(children:[SizedBox(width: 30,),Text('Resend code:00:15'),]),
            SizedBox(height:20),
            Container(height: 55,color:kPrimaryColor,width: 250,child:FlatButton(onPressed: (){}, child: Text('VERIFY',style: TextStyle(color: Colors.white),)))





          ],),
        )

      ],)),
    );
  }
}
