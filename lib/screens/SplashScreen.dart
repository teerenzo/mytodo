import 'package:flutter/material.dart';
import 'package:mytodo/screens/HomePage.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _duration().then((value) =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return HomePage();
    }))
    );
    super.initState();
  }
  Future<bool> _duration() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return true;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      color: HexColor("#495D69"),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset('images/IB_logo.png',width: 50,height: 50,)

          ],
        ),
      ),
    );
  }
}
