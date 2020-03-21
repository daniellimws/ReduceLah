import 'package:flutter/material.dart';

const UserName = "Aaron";

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
      backgroundColor: Color(0xFFF6FBF5),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/gradient2.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
                child: Text(
                  "Welcome back, $UserName",
                  style: TextStyle(
                      color: Color(0xFF483f16), fontWeight: FontWeight.bold, fontSize: 22
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFdae5ad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "This month, you have saved in total",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Hero(
                          tag: "Straw",
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/icons/straw.jpg"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$straw straws",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Hero(
                          tag: "Plastic Bag",
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/icons/bag.png"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$plasticBag plastic bags",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Hero(
                          tag: "Food Container",
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/icons/take-away.png"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$foodContainer food containers",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
