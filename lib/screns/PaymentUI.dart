
import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentUI extends StatefulWidget {
  const PaymentUI({Key? key}) : super(key: key);

  @override
  _PaymentUIState createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  final List<String> newData =<String>['Cash Payment','Card Payment','Wallet','Crypto Wallet'];
  Color? checkbox;//= Colors.white;
  bool _value=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SingleChildScrollView(
      child: Container(height: 200,width:MediaQuery. of(context). size. width ,child:
      Column(children: [
        SizedBox(height: 60,),
        Row(children: [
          SizedBox(width: 20,),
          Icon(Icons.arrow_back,size: 30,),
          SizedBox(width: 60,),
          Text('Payment Method',style: TextStyle(fontSize: 22),),

        ],),
        SizedBox(height: 50,),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32, bottom: 32, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                             /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  //    builder: (_) => Welcome()
                                  ));*/
                            },
                            child: Text(
                              newData[index],
                              //'Note Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                          /*Text(
                            newData[index]['text'],
                            //'Note Text',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),*/
                        ],
                      ),
                      //SizedBox(width: 20),
                     /* Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(newData[index]['img']),
                      ),*/
                      Container(
                        width: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: checkbox),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value
                              ? Icon(
                            Icons.check,
                            size: 20.0,
                            color: Colors.white,
                          )
                              : Icon(
                            Icons.check_box_outline_blank,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: newData == null ? 0 : newData.length,
          ),
        Container(child:FlatButton(onPressed: (){
          if(_value==false){
            setState(() {
              checkbox=Colors.blue;
            });
          }
          else{
            checkbox=Colors.white;
          }
         // _value==false?checkbox==Colors.white:checkbox==Colors.blue;
          setState(() {
            _value = !_value;
            //checkbox= Colors.blue;
            //checkbox = !checkbox;
          });
        },child: Row(children: [
          Icon(CupertinoIcons.money_dollar),
          SizedBox(width: 40,),
          Text('Cash Payment',style: TextStyle(fontSize: 18),),
          SizedBox(width: 100,),
          Container(
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: checkbox),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: _value
                  ? Icon(
                Icons.check,
                size: 20.0,
                color: Colors.white,
              )
                  : Icon(
                Icons.check_box_outline_blank,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          ),


        ],),))
      ],)),
    ));
  }
}
