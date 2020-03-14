import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class NFCDetectedPage extends StatefulWidget {
  @override
  _NFCDetectedPageState createState() => _NFCDetectedPageState();
}

class _NFCDetectedPageState extends State<NFCDetectedPage>
    with SingleTickerProviderStateMixin {
  AnimationController _fadeController;
  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fadeController.forward();
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: FlareActor('assets/animations/Earth.flr',
                    color: Colors.green,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: 'Stroke'),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You refused to use a plastic bag!\n\nThanks for making the world a better place!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
