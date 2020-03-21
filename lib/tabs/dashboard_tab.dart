import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

const UserName = "Daniel";

class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  int straw = 0;
  int plasticBag = 0;
  int foodContainer = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ReduceLah!',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                    color: Color(0xFFF6FBF5),
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0.0, 1.0))
                    ]),
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Welcome back, $UserName",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 190,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This month, you have saved in total",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "20",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Image(
                        height: 24,
                        image: AssetImage("assets/icons/straw.jpg")),
                    SizedBox(width: 12),
                    Text(
                      "50",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(width: 12),
                    Image(
                        height: 24, image: AssetImage("assets/icons/bag.png")),
                    SizedBox(width: 12),
                    Text(
                      "20",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(width: 12),
                    Image(
                        height: 24,
                        image: AssetImage("assets/icons/take-away.png")),
                    SizedBox(width: 12),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6.0,
                              offset: Offset(0.0, 1.0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "1. Enable NFC on your phone.",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                height: 28.0,
                                width: 28.0,
                                child:
                                    Image.asset("assets/icons/smartphone.png"),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "2. Collect points at partnering merchants.",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                height: 28.0,
                                width: 28.0,
                                child: Image.asset("assets/icons/commerce.png"),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "3. Redeem points for attractive rewards.",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                height: 28.0,
                                width: 28.0,
                                child: Image.asset("assets/icons/gift.png"),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "4. Save the Environment!",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                height: 28.0,
                                width: 28.0,
                                child: Image.asset("assets/icons/green.png"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          // Column(children: <Widget>[
          //   Container(
          //     padding: EdgeInsets.all(8.0),
          //     color: Color(0xFFdae5ad),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Text(
          //           "This month, you have saved in total",
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 18),
          //         ),
          // ],)
          // SizedBox(height: 8.0),
          // Expanded(
          //   flex: 36,
          //   child: Container(
          //     padding: EdgeInsets.all(8.0),
          //     color: Color(0xFFdae5ad),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Text(
          //           "This month, you have saved in total",
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 18),
          //         ),
          //         Expanded(
          //           flex: 1,
          //           child: Card(
          //             child: Hero(
          //                 tag: "Straw",
          //                 child: Row(
          //                   children: <Widget>[
          //                     Expanded(
          //                       flex: 1,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child:
          //                             Image.asset("assets/icons/straw.jpg"),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       width: 8.0,
          //                     ),
          //                     Expanded(
          //                       flex: 2,
          //                       child: Text(
          //                         "$straw straws",
          //                         style: TextStyle(
          //                             color: Colors.black,
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 18),
          //                       ),
          //                     ),
          //                   ],
          //                 )),
          //           ),
          //         ),
          // SizedBox(
          //   height: 8.0,
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Card(
          //     child: Hero(
          //       tag: "Plastic Bag",
          //       child: Row(
          //         children: <Widget>[
          //           Expanded(
          //             flex: 1,
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Image.asset("assets/icons/bag.png"),
          //             ),
          //           ),
          //           SizedBox(
          //             width: 8.0,
          //           ),
          //           Expanded(
          //             flex: 2,
          //             child: Text(
          //               "$plasticBag plastic bags",
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 18),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          //         SizedBox(
          //           height: 8.0,
          //         ),
          //         Expanded(
          //           flex: 1,
          //           child: Card(
          //             child: Hero(
          //               tag: "Food Container",
          //               child: Row(
          //                 children: <Widget>[
          //                   Expanded(
          //                     flex: 1,
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Image.asset(
          //                           "assets/icons/take-away.png"),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 8.0,
          //                   ),
          //                   Expanded(
          //                     flex: 2,
          //                     child: Text(
          //                       "$foodContainer food containers",
          //                       style: TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: 18),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 8.0),
//          Expanded(
//            flex: 24,
//            child: Container(
//              padding: EdgeInsets.all(8.0),
//              color: Color(0xFF483f16),
//              constraints: BoxConstraints.expand(),
//              child: Card(
//                child: Padding(
//                  padding: const EdgeInsets.all(20.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
//                        child: Center(
//                            child: Text(
//                          "How to ReduceLah!",
//                          style: TextStyle(color: Colors.black, fontSize: 18),
//                        )),
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text("1. Enable NFC on your phone."),
//                          SizedBox(
//                            height: 28.0,
//                            width: 28.0,
//                            child: Image.asset("assets/icons/smartphone.png"),
//                          )
//                        ],
//                      ),
//                      Divider(
//                        thickness: 1.5,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text("2. Collect points at partnering merchants."),
//                          SizedBox(
//                            height: 28.0,
//                            width: 28.0,
//                            child: Image.asset("assets/icons/commerce.png"),
//                          )
//                        ],
//                      ),
//                      Divider(
//                        thickness: 1.5,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text("3. Redeem points for attractive rewards."),
//                          SizedBox(
//                            height: 28.0,
//                            width: 28.0,
//                            child: Image.asset("assets/icons/gift.png"),
//                          )
//                        ],
//                      ),
//                      Divider(
//                        thickness: 1.5,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text("4. Save the Environment!"),
//                          SizedBox(
//                            height: 28.0,
//                            width: 28.0,
//                            child: Image.asset("assets/icons/green.png"),
//                          )
//                        ],
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
