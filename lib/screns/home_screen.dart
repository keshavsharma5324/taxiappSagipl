
/*import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final String topback = 'assets/svg/Icon material-menu.svg';
  final String metamask = 'assets/png/Group 2261.png';
  final String coinbase = 'assets/png/Rectangle 1183.png';
  //final String facebookLogo = 'assets/png/facebook.png';
  var dollar =new String.fromCharCodes(new Runes('\u0024'));
  bool paypal =false;
  bool ccodc= false;
  bool cww =false;
  bool osy =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child:Container(height: MediaQuery.of(context).size.height,color: Colors.black,child: Stack(children: [

      // Positioned(top: 173,left: 77,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      // Positioned(top: 173,left: 258,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      Positioned(top: 60,left: 201,child: Container(height: 10,width: 10,color: Colors.white)),//Color(0xff11A1B27),))
      SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(color: Colors.black,width: MediaQuery.of(context).size.width-30,height: 50,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                SvgPicture.asset(
                topback,
                //semanticsLabel: 'Acme Logo'
            ),//Icon(Icons.books,color: Colors.white,),
              //SizedBox(width: 30,),
              Text('PlatoBlockchain',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
             // SizedBox(width:10),
              CircleAvatar(
                  backgroundColor: Color(0xff04A1FF),
                  radius: 10,
                  child: Text('P',style: TextStyle(color: Colors.white,fontSize: 12),)//Icon(Icons.check,size: 16,color: Colors.white,),
              ),
              // ClipOval(child: Text('i',style: TextStyle(color: Colors.white),),)
            ],),),
          ),
          Container(width: MediaQuery.of(context).size.width,height: 1,color: Color(0xff1A1B27),),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            SizedBox(width: 15,),
            Text('Watchlist',style: TextStyle(color: Colors.white//(0xffA1A4C1)
              ,fontSize: 16,fontWeight: FontWeight.w400,),),
            //Text('Plato Connect',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,))
          ],),

          SizedBox(height: 10,),
          Container(padding: EdgeInsets.symmetric(horizontal: 20),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Color(0xff1A1B27)),width: MediaQuery.of(context).size.width-30,height: 84,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            //SizedBox(width: 10,),
            SvgPicture.asset(
              topback,
              //semanticsLabel: 'Acme Logo'
            ),
           SizedBox(width: 15,),
           Column(children: [
             SizedBox(height: 25,),
             Text('Bitcoin',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
             SizedBox(height: 10,),
             Text('BTC',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1)),),
           ],),
           SizedBox(width: MediaQuery.of(context).size.width/10,),
            SvgPicture.asset(
              topback,
              //semanticsLabel: 'Acme Logo'
            ),
            SizedBox(width: MediaQuery.of(context).size.width/10,),
            SizedBox(width: MediaQuery.of(context).size.width/10+10,),
            Column(children: [
              SizedBox(height: 25,),
              Text('Rs 55,99555.00',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.white),),
              SizedBox(height: 10,),
              Text('+0.73%',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1)),),
            ],),

           // Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),



          ],)),
          SizedBox(height: 30,),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            SizedBox(width: 15,),
            Text('Watchlist',style: TextStyle(color: Colors.white//(0xffA1A4C1)
              ,fontSize: 16,fontWeight: FontWeight.w400,),),
            //Text('Plato Connect',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,))
          ],),
          SizedBox(height: 10,),
          Container(padding: EdgeInsets.only(left:15),height: 159,width: 149,child:ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,
            padding: const EdgeInsets.all(8),itemBuilder: (BuildContext context, int index) {
            Container(height: 159,149,child:)
            },)),
          paypal?
          Container(width:MediaQuery.of(context).size.width-30,height:187,color: Color(0xff1A1B27),child:Column(mainAxisAlignment: MainAxisAlignment.start,children: [
            Row(children: [SizedBox(width: 10 ,
            ),
              Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                IconButton(icon:Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,),onPressed: (){
                  setState(() {
                    paypal=!paypal;
                  });
                },)


              ],))
            ],),
            Row(children: [SizedBox(width: 10 ,
            ),
              //Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              // Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
              // Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,)
              Container(color: Colors.black,width: MediaQuery.of(context).size.width-50,height:47,child: TextField(
                decoration: InputDecoration(prefixText: '    ',hintText:'VPA/ UPI ID (eg 12345@upi)',hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1))),
              ),)

              // ],))
            ],),
            SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 10,),
              Container(padding: EdgeInsets.symmetric(horizontal: 35),width: MediaQuery.of(context).size.width-50,decoration: BoxDecoration( color: Color(0xff04a1ff),borderRadius: BorderRadius.all(Radius.circular(5))),height: 50,child:
              TextButton(onPressed: (){
                setState(() {
                  //Navigator.push(context, new MaterialPageRoute(builder: (__) => new verifyEmail()));

                  // Here you can write your code for open new view
                });
              },child: Center(child:Text('Pay ${dollar}40.00',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),),),),
            ],)

          ],)):Container(padding: EdgeInsets.symmetric(horizontal: 10),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Color(0xff1A1B27)),width: MediaQuery.of(context).size.width-30,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            //SizedBox(width: 10,),
            Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
            IconButton(icon:Icon(Icons.keyboard_arrow_down,color: Colors.white,),onPressed: (){
              setState(() {
                paypal=!paypal;
              });
            }),


          ],)),
          SizedBox(height: 20,),
          ccodc?Container(width:MediaQuery.of(context).size.width-30,height:248,color: Color(0xff1A1B27),child:Column(mainAxisAlignment: MainAxisAlignment.start,children: [
            Row(children: [SizedBox(width: 10 ,
            ),
              Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text('Credit or Debit Card',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                IconButton(icon:Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,),onPressed: (){
                  setState(() {
                    ccodc=!ccodc;
                  });
                },)


              ],))
            ],),
            Row(children: [SizedBox(width: 10 ,
            ),
              //Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              // Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
              // Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,)
              Container(color: Colors.black,width: MediaQuery.of(context).size.width-50,height:46,child: TextField(
                decoration: InputDecoration(prefixText: '    ',hintText:'Card Number',hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1))),
              ),)

              // ],))
            ],),
            SizedBox(height: 15,),
            Row(children: [SizedBox(width: 10 ,
            ),
              //Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              // Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
              // Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,)
              Container(color: Colors.black,width: MediaQuery.of(context).size.width/2-30,height:46,child: TextField(
                decoration: InputDecoration(prefixText: '    ',hintText:'MM/YY',hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1))),
              ),),
              SizedBox(width: 10,),
              Container(color: Colors.black,width: MediaQuery.of(context).size.width/2-30,height:46,child: TextField(
                decoration: InputDecoration(prefixText: '    ',hintText:'CVV',hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1))),
              ),),

              // ],))
            ],),
            SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 10,),
              Container(padding: EdgeInsets.symmetric(horizontal: 35),width: MediaQuery.of(context).size.width-50,decoration: BoxDecoration( color: Color(0xff04a1ff),borderRadius: BorderRadius.all(Radius.circular(5))),height: 50,child:
              TextButton(onPressed: (){
                setState(() {
                  //Navigator.push(context, new MaterialPageRoute(builder: (__) => new verifyEmail()));

                  // Here you can write your code for open new view
                });
              },child: Center(child:Text('Pay ${dollar}40.00',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),),),),
            ],)

          ],)):
          Container(padding: EdgeInsets.symmetric(horizontal: 10),color: Color(0xff1A1B27),width: MediaQuery.of(context).size.width-30,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            //SizedBox(width: 10,),
            Text('Credit or Debit Card',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
            IconButton(icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),onPressed: (){setState(() {
              ccodc =! ccodc;
            });},)


          ],)),
          SizedBox(height: 20,),
          cww?Container(width:MediaQuery.of(context).size.width-30,height:430,color: Color(0xff1A1B27),child:Column(mainAxisAlignment: MainAxisAlignment.start,children: [
            Row(children: [SizedBox(width: 10 ,
            ),
              Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text('Connect with wallet',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                IconButton(icon:Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,),onPressed: (){
                  setState(() {
                    cww=!cww;
                  });
                },)


              ],))
            ],),
            Container(height: 1,width: MediaQuery.of(context).size.width-50,color: Color(0xff252732),),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text('By connecting your wallet, you agree to our Terms',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1),),),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text('of Services and our Privacy Policy',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1),),),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(metamask),
            ),
            SizedBox(height: 10,),
           /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(walletconnect),
            ),*/
            SizedBox(height: 10,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(coinbase)
            ),
            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('New to Ethereum?',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),)],),
            SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('Learn more about wallets',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 14,fontWeight: FontWeight.w400),)],)
            /* Row(children: [SizedBox(width: 10 ,
            ),
              //Container(width: MediaQuery.of(context).size.width-30-20,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
               // Text('Paypal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
               // Icon(Icons.keyboard_arrow_up_sharp,color: Colors.white,)
                Container(color: Colors.black,width: MediaQuery.of(context).size.width-50,height:47,child: TextField(
                  decoration: InputDecoration(prefixText: '    ',hintText:'VPA/ UPI ID (eg 12345@upi)',hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1))),
                ),)

             // ],))
            ],),*/
            /* SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 10,),
              Container(padding: EdgeInsets.symmetric(horizontal: 35),width: MediaQuery.of(context).size.width-50,decoration: BoxDecoration( color: Color(0xff04a1ff),borderRadius: BorderRadius.all(Radius.circular(5))),height: 50,child:
              TextButton(onPressed: (){
                setState(() {
                  //Navigator.push(context, new MaterialPageRoute(builder: (__) => new verifyEmail()));

                  // Here you can write your code for open new view
                });
              },child: Center(child:Text('Pay ${dollar}40.00',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),),),),
            ],)*/

          ],)):
          Container(padding: EdgeInsets.symmetric(horizontal: 10),color: Color(0xff1A1B27),width: MediaQuery.of(context).size.width-30,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            //SizedBox(width: 10,),
            Text('Connect with wallet',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
            IconButton(icon:Icon(Icons.keyboard_arrow_down,color: Colors.white,),onPressed: (){
              setState(() {
                cww =!cww;
              });
            },)


          ],)),
          SizedBox(height: 30,),
          Container(width: MediaQuery.of(context).size.width-30,height: 2,color: Color(0xff1A1B27),),
          SizedBox(height: 30,),
          osy?Padding(padding: EdgeInsets.symmetric(horizontal: 15),child:Container(color:Color(0xff1A1B27),height: 382,width: MediaQuery.of(context).size.width-30,child: Column(children: [
            Container(color: Color(0xff1F202D),height: 45,width: MediaQuery.of(context).size.width-30,padding: EdgeInsets.symmetric(horizontal: 20),child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text('Order Summary',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white),),
              CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 12,
                  child: IconButton(padding: EdgeInsets.all(0),icon:Icon(Icons.keyboard_arrow_up_sharp,size:20,color: Colors.white,),onPressed: (){setState(() {
                    osy =! osy;
                  });},
                  ))
            ],
            ),),
            Container(padding: EdgeInsets.symmetric(horizontal: 20),height: 120,width:MediaQuery.of(context).size.width-30 ,child:Column(
                children:[ SizedBox(height: 18,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Product',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    Text('Plato Connect',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400,))
                  ],),
                  SizedBox(height: 17,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Subtotal',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400,))
                  ],),
                  SizedBox(height: 17,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Total',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400,))
                  ],),
                  SizedBox(height: 18,),
                ]),),
            Center(child: Container(color: Color(0xff1F202D),height: 2,width: MediaQuery.of(context).size.width-30-40,)),
            Container(padding: EdgeInsets.symmetric(horizontal: 20),height: 150,width:MediaQuery.of(context).size.width-30 ,child:Column(
                children:[ SizedBox(height: 17,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Recurring Totals',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    //Text('Plato Connect',style: TextStyle(color: Colors.white,))
                  ],),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Subtotal',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400,))
                  ],),
                  SizedBox(height: 17,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Recurring Total',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400,))
                  ],),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    Text('First Renewal- October 9,2021',style: TextStyle(color: Color(0xffA1A4C1),fontSize: 12,fontWeight: FontWeight.w400,),),
                    // Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,))
                  ],),
                  SizedBox(height: 8,),
                ]),),
            Center(child: Container(color: Color(0xff1F202D),height: 2,width: MediaQuery.of(context).size.width-30-40,)),
            Container(padding: EdgeInsets.symmetric(horizontal: 20),height: 50,width:MediaQuery.of(context).size.width-30 ,child:Column(mainAxisAlignment: MainAxisAlignment.center,
                children:[ Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text('Order Total',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400,),),
                  Text('${dollar}40.00/ month',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400,))
                ],),])),
            // SizedBox(height: 30,)


          ],),)):Container(padding: EdgeInsets.symmetric(horizontal: 10),color: Color(0xff1A1B27),width: MediaQuery.of(context).size.width-30,height: 60,child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            //SizedBox(width: 10,),
            Text('Order Summary',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
            IconButton(icon:Icon(Icons.keyboard_arrow_down,color: Colors.white,),onPressed: (){
              setState(() {
                osy=!osy;
              });
            }),


          ],)),

          osy?Column(
            children: [
              SizedBox(height: 30,),
              Row(children: [
                SizedBox(width: 15,),
                Text('Your personal will be used to process your order, support',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1)),),
                SizedBox(width: 15,),

              ],),
              SizedBox(height: 5,),
              Row(children: [
                SizedBox(width: 15,),
                Text('your experience throughout this website, and for other purposes',style: TextStyle(letterSpacing: -0.35,fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1)),),
                SizedBox(width: 15,),



              ],),
              SizedBox(height: 5,),
              Row(children: [
                SizedBox(width: 15,),
                Text('described in our privacy policy.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffA1A4C1)),),
                SizedBox(width: 15,),



              ],),
              SizedBox(height: 30,),

            ],
          ):Text('')







        ],),
      ),
      cww?Positioned(top: 595,left: 60,child:Text('Coinbase',style: TextStyle(fontSize:14,fontWeight: FontWeight.w400,color: Colors.white ),)):Text('')//Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      // Positioned(top: 335,left: 75,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      //  Positioned(top: 417,left: 98,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      // Positioned(top: 497,left: 46,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      //  Positioned(top: 497,left: 243,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      // Positioned(top: 577,left: 99,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),
      //  Positioned(top: 577,left: 277,child:Icon(Icons.star,size: 8,color: Color(0xff04A1FF),)),

    ],),)

    ));
  }
}*/
