import 'package:countries/main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
class Splash extends StatefulWidget {
  //const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  initState(){
    super.initState();
    _navigateHome();
  }

  _navigateHome()async{
    await Future.delayed(Duration(seconds: 5),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var screenheight = queryData.size.height;
    var screenwidth = queryData.size.width;
    return Scaffold(
      backgroundColor: HexColor("E0E5EC"),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Container(
            width: screenwidth,
            height: screenheight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/Countries.png'),
                NeumorphicText(
                  "Countries!" ,
                  //"Country",
                  textStyle: NeumorphicTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    decoration: TextDecoration.none
                  ),
                  textAlign: TextAlign.left,
                  style: NeumorphicStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
