import 'package:flutter/material.dart';
import 'package:reducelah/services/leaderboard_service.dart';
import 'package:reducelah/services/point_service.dart';

class Tier {
  final int _pointsNeeded;
  final String _current;
  final String _nextTier;
  const Tier._internal(this._pointsNeeded, this._current, this._nextTier);
  toString() => _current;

  static const BRONZE = const Tier._internal(500, 'Bronze', 'Silver');
  static const SILVER = const Tier._internal(1000, 'Silver', 'Gold');
  static const GOLD = const Tier._internal(2000, 'Gold', 'Platinum');
  static const PLATINUM = const Tier._internal(3000, 'Platinum', 'Platinum');
}

class Reward extends StatelessWidget {
  final String rewardName;
  final String rewardBrand;
  final String rewardPic;
  final int rewardPoints;

  bool redeemed = false;

  Reward({this.rewardName, this.rewardBrand, this.rewardPic, this.rewardPoints, this.redeemed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: rewardName,
        child: Material(
          child: InkWell(
            onTap: (){},
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                        child: Image.asset(rewardPic, width: 120.0, fit: BoxFit.cover)
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                            rewardName,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 5,),
                        Text(
                            rewardBrand,
                            style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Text(
                            '$rewardPoints points',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(child: Image.asset('assets/icons/arrow-right.png'),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RewardsTab extends StatefulWidget {
  @override
  _RewardsTabState createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  final listRewards = [
    {"name":'1 metal straw', "brand":'ReduceLah', "pic":'assets/images/reward1.jpg', "points":200},
    {"name":'\$3 voucher', "brand": 'LiHo', "pic":'assets/images/reward2.jpg', "points":200},
    {"name":'2 curry puffs', "brand":'Oh Chang Kee', "pic":'assets/images/reward3.jpg', "points":200},
    {"name":'1 for 1 voucher', "brand":'Starbucks', "pic":'assets/images/reward4.jpg', "points":300},
    {"name":'\$5 voucher', "brand":'Dominos', "pic":'assets/images/reward5.jpg', "points":300},
    {"name":'\$5 off Grab', "brand":'Grab', "pic":'assets/images/reward6.jpg', "points":300},
  ];
  int myPoints = 222;
  int historicalPoints = 578;
  Tier myTier = Tier.SILVER;

  Future<Points> _points;

  @override
  void initState() {
    super.initState();

    _points = getPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF5),
      appBar: AppBar(
        title: Text(
          'Rewards',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          builder: (context, userSnap) {
            if (!userSnap.hasData) {
              return Container();
            }
            return StreamBuilder(
              builder: (context, pointsSnap) {
                if(!pointsSnap.hasData) {
                  return Container();
                }
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    _tierAchieved(),
                    _pointsAccumulated(pointsSnap.data.total),
                    _rewards(pointsSnap.data.redeemed),
                  ],
                );
              },
              stream: getPointsStream(userSnap.data.id),
            );
          },
        future: getMyDetails(),
      ),
    );
  }

  Widget _tierAchieved() {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 18.0),
        color: Color(0xff277aa9),
        constraints: BoxConstraints.expand(height: 134),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                'Silver', // Bronze, Silver, Gold, Platinum
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Points to ${myTier._nextTier}: ${myTier._pointsNeeded - historicalPoints}',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 13,
                    child: LinearProgressIndicator(
                      value: historicalPoints / myTier._pointsNeeded,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/icons/medal.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _pointsAccumulated(int points) {
    return Container(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      color: Colors.white,
      constraints: BoxConstraints.expand(height: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text("You have"),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(points.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
                ),
                SizedBox(
                  width: 12,
                ),
                Text('ReduceLah! Points',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewards(var list) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(0.0),
      itemCount: listRewards.length,
      itemBuilder: (BuildContext context, int index) {
        return Reward(
            rewardName: listRewards[index]['name'],
            rewardBrand: listRewards[index]['brand'],
            rewardPic: listRewards[index]['pic'],
            rewardPoints: listRewards[index]['points'],
            redeemed: new List<int>.from(list).where((l) => l == index).length > 0,
        );
      },
    );
  }
}