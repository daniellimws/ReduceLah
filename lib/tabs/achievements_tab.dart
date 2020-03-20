import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reducelah/services/point_service.dart';

class AchievementsTab extends StatefulWidget {
  @override
  _AchievementsTabState createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {

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
          'Achievements',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        builder: (context, pointsSnap) {
          if(!pointsSnap.hasData) {
            return Container();
          }

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _strawSection(pointsSnap.data.straw),
                _plasticBagSection(pointsSnap.data.bag),
                _foodContainerSection(pointsSnap.data.container)
              ],
            ),
          );
        },
        future: _points,
      ),
    );
  }

  Widget _achievementCard(AssetImage achievementImage) {
    return GestureDetector(
      child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image(image: achievementImage, width: 65),
          )),
      onTap: () async {
        ByteData imageBytes = await rootBundle.load(achievementImage.assetName);
        await Share.file('ReduceLah Achievement', 'achievement.png',
            imageBytes.buffer.asUint8List(), 'image/png',
            text:
                'I\'ve unlocked the achievement "Rejected 10 straws" on ReduceLah!');
      },
    );
  }

  Widget _strawSection(int num) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Straw",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.start,
              ),
              Text(num.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(value: num/100.0),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png'))
            ],
          ),
        ],
      ),
    );
  }

  Widget _plasticBagSection(int num) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Plastic Bag",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.start,
              ),
              Text(num.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(value: num / 100.0),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png'))
            ],
          ),
        ],
      ),
    );
  }

  Widget _foodContainerSection(int num) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Food Container",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.start,
              ),
              Text(num.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(value: num / 100.0),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png')),
              _achievementCard(AssetImage('assets/icons/prize.png'))
            ],
          ),
        ],
      ),
    );
  }
}
