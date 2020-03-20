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

    _fadeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int arg = ModalRoute.of(context).settings.arguments;
    _fadeController.forward();
    return Scaffold(
      backgroundColor: Color(0xFFF4FAF3),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      arg == 1
                          ? 'Rejected plastic bag!'
                          : arg == 2
                              ? 'Rejected straw!'
                              : arg == 3
                                  ? 'Rejected container!'
                                  : 'Rejected plastic waste!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Thanks for making the world a better place!',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
