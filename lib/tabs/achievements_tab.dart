import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reducelah/services/leaderboard_service.dart';
import 'package:reducelah/services/point_service.dart';

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.8);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

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
        builder: (context, userSnap) {
          if (!userSnap.hasData) {
            return Container();
          }
          return StreamBuilder(
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
            stream: getPointsStream(userSnap.data.id),
          );
        },
        future: getMyDetails(),
      ),
    );
  }

  Widget _achievementCard(AssetImage achievementImage, bool obtained) {
    return GestureDetector(
      child: ClipShadowPath(
          clipper: _HexagonClipper(),
          shadow: BoxShadow(
              blurRadius: 0,
              offset: Offset(0, 2),
              color: obtained ? Colors.grey[200] : Colors.grey[900]),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black26)
            ]),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Straw",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87),
                  textAlign: TextAlign.start,
                ),
                Text('${num}/100',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            SizedBox(height: 14),
            LinearProgressIndicator(value: num / 100.0),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _achievementCard(AssetImage('assets/icons/prize.png'), true),
                _achievementCard(AssetImage('assets/icons/prize.png'), false),
                _achievementCard(AssetImage('assets/icons/prize.png'), false)
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _plasticBagSection(int num) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black26)
            ]),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Plastic Bag",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87),
                  textAlign: TextAlign.start,
                ),
                Text('${num}/100',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
              ],
            ),
            SizedBox(height: 14),
            LinearProgressIndicator(value: num / 100.0),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _achievementCard(AssetImage('assets/icons/prize.png'), true),
                _achievementCard(AssetImage('assets/icons/prize.png'), true),
                _achievementCard(AssetImage('assets/icons/prize.png'), false)
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _foodContainerSection(int num) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 24.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black26)
            ]),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Food Container",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87),
                  textAlign: TextAlign.start,
                ),
                Text('${num}/100',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
              ],
            ),
            SizedBox(height: 14),
            LinearProgressIndicator(value: num / 100.0),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _achievementCard(AssetImage('assets/icons/prize.png'), false),
                _achievementCard(AssetImage('assets/icons/prize.png'), false),
                _achievementCard(AssetImage('assets/icons/prize.png'), false)
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
