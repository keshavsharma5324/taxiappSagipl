
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/imagehelper.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> _checked = [];
  final List<String> newData =<String>['Cash Payment','Card Payment','Wallet','Crypto Wallet'];
  List<Image> checkboxbool =<Image>[Image.asset(rightblack),Image.asset(rightblack),Image.asset(rightblack),Image.asset(rightblack)];
  final List<IconData> iconData=<IconData>[Icons.monetization_on,Icons.payment,Icons.account_balance_wallet,Icons.savings];
  Color? checkbox;//= Colors.white;
  bool _value=false;
  init(){
    this.checkboxbool;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*SingleChildScrollView(child:
        Container(
          child:*/Column(children:[
        SizedBox(height: 60,),
        Row(children: [
          SizedBox(width: 20,),
          Icon(Icons.arrow_back,size: 30,),
          SizedBox(width: 60,),
          Text('Payment Method',style: TextStyle(fontSize: 22),),

        ],),
        SizedBox(height: 50,),

            ListView.builder(
              shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: newData.length,
                itemBuilder: (BuildContext context, int index) {
                  //var? iconData;
                  return Container(height: 70,padding: EdgeInsets.all(5),child:Card(
                      child: Padding(
                      padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 16, right: 16),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(iconData[index]),
                    Container(alignment: Alignment.topLeft,padding: EdgeInsets.all(0),
                    height: 20,width: 150,
                   // color: Colors.red[colorCodes[index]],
                    child: FlatButton(onPressed: (){if(_value==false){
                      setState(() {
                        checkbox=Colors.blue;
                      });
                    }
                    else{
                      checkbox=Colors.white;
                    }
                    // _value==false?checkbox==Colors.white:checkbox==Colors.blue;
                    setState(() {
                      //_value = !_value;
                      //checkbox= Colors.blue;
                      //checkbox = !checkbox;
                    });},child: Text('${newData[index]}'),),
                  ),
                    new Transform.scale(scale: 1.3,
                    child:IconButton(icon: checkboxbool[index],onPressed: (){
                      checkboxbool=[Image.asset(rightblack),Image.asset(rightblack),Image.asset(rightblack),Image.asset(rightblack)];
                      setState(() {
                        checkboxbool[index]=Image.asset(rightgreen);
                      });
                    },)
                      /*Checkbox(
                        value: checkboxbool[index],
                        splashRadius: 40,
                        activeColor: Colors.green,
                        shape: CircleBorder(),

                        onChanged: (bool? value) {
                          //init();
                          checkboxbool=[false,false,false,false];
                          setState(() {
                            checkboxbool[index] = value!;
                          });
                        })*/)
                    //SizedBox(width: 125,)

                  ]))));
                }
            ),
      SizedBox(height: 250,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 20), child:Container(color:kPrimaryColor,height:50,width:MediaQuery. of(context). size. width ,child: FlatButton(onPressed: (){}, child: Text('CONTINUE',style: TextStyle(color:Colors.white,fontSize: 22),))),)
      ])
     //   ),),
    );
  }
}
