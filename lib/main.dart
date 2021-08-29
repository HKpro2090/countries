import 'package:countries/splash.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:countries/src/providers/db_provider.dart';
import 'package:countries/src/providers/country_api_provider.dart';

void main() => runApp(Countries());


class Countries extends StatelessWidget {
  //const Countries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Countries',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //MyHomePage({Key? key}) : super(key: key);
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var screenheight = queryData.size.height;
    var screenwidth = queryData.size.width;
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 0),
      child: Scaffold(
        //backgroundColor: NeumorphicTheme.baseColor(context),
        backgroundColor: HexColor("E0E5EC"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenheight*0.05,horizontal: screenwidth*0.04),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.menu,size: 20),
                      onPressed: () {},
                    ),
                    Container(
                      width: 230,
                      height: 40,
                      /*decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black),
                            left: BorderSide(width: 1.0, color: Colors.black),
                            right: BorderSide(width: 1.0, color: Colors.black),
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          )
                      ),*/
                      child: NeumorphicText(
                        'Home',
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          depth: 10,
                          color: Colors.black,
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.refresh_outlined,size: 20),
                      onPressed: () async {
                        await _loadFromApi();
                      },
                    ),
                  ],
                ),
                Container(
                  width: 390,
                  height: 686,
                  /*decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0,color: Colors.black),
                      left: BorderSide(width: 1.0,color: Colors.black),
                      right: BorderSide(width: 1.0,color: Colors.black),
                      bottom: BorderSide(width: 1.0,color: Colors.black),
                    ),
                  ),*/
                  child: isLoading?
                  Center(child: CircularProgressIndicator(),)
                  : _buildEmployeeListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _loadFromApi() async {
    isLoading = true;

    var apiProvider = CountryApiProvider();
    await apiProvider.getAllCountries();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
  }
  _buildEmployeeListView()  {
    return FutureBuilder(
      future: DBProvider.db.getallregion(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        else {
          return Container(
            width: 390,
            height: 686,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ListView.builder(itemBuilder: (context,index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        height: 150,
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                            shadowLightColor: HexColor("#FFFFFF"),
                            shadowDarkColor: HexColor("#A3B1C6"),
                            color: HexColor("#E0E5EC"),
                            intensity: 0.9,
                            border: NeumorphicBorder(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                width: 1
                            ),
                          ),
                          child: Center(
                            child: NeumorphicText(
                              "${snapshot.data[index+index+1]['region']}",
                              //"Country",
                              textStyle: NeumorphicTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder:(context) => RegionPage(snapshot.data[index+index+1]['region'])));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        height: 150,
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            shadowLightColor: HexColor("#FFFFFF"),
                            shadowDarkColor: HexColor("#A3B1C6"),
                            color: HexColor("#E0E5EC"),
                            intensity: 0.9,
                            border: NeumorphicBorder(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                width: 1
                            ),
                          ),
                          child: Center(
                            child: NeumorphicText(
                              "${snapshot.data[index+index+2]['region']}",
                              //"Country",
                              textStyle: NeumorphicTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder:(context) => RegionPage(snapshot.data[index+index+2]['region'])));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              ,itemCount: snapshot.data.length~/2,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          );
        }
      },
    );
  }
}

class RegionPage extends StatelessWidget {
  //const RegionPage({Key? key}) : super(key: key);
  RegionPage(this.regionselected);
  var regionselected = "";

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var screenheight = queryData.size.height;
    var screenwidth = queryData.size.width;
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 0),
      child: Scaffold(
        //backgroundColor: NeumorphicTheme.baseColor(context),
        backgroundColor: HexColor("E0E5EC"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenheight*0.05,horizontal: screenwidth*0.04),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.arrow_back_rounded,size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: 230,
                      height: 40,
                      /*decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black),
                            left: BorderSide(width: 1.0, color: Colors.black),
                            right: BorderSide(width: 1.0, color: Colors.black),
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          )
                      ),*/
                      child: NeumorphicText(
                        regionselected,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          depth: 10,
                          color: Colors.black,
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.refresh_outlined,size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
                FutureBuilder(
                  future: DBProvider.db.countriesinregion("'"+regionselected+"'"),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      return Container(
                        width: 390,
                        height: 686,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: ListView.builder(itemBuilder: (context,index){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 350,
                                    height: 110,
                                    child: NeumorphicButton(
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.convex,
                                        shadowLightColor: HexColor("#FFFFFF"),
                                        shadowDarkColor: HexColor("#A3B1C6"),
                                        color: HexColor("#E0E5EC"),
                                        intensity: 0.9,
                                        border: NeumorphicBorder(
                                            color: Color.fromRGBO(255, 255, 255, 0.2),
                                            width: 1
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width:50,height: 50,child: SvgPicture.network(snapshot.data[index]['flag'],width: 50,height: 50,)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 225,
                                                  child: NeumorphicText(
                                                      "${snapshot.data[index]['name']}" ,
                                                      //"Country",
                                                      textStyle: NeumorphicTextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    textAlign: TextAlign.left,

                                                    ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: NeumorphicText(
                                                    "${snapshot.data[index]['capital']}" ,
                                                    //"Country",
                                                    textStyle: NeumorphicTextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder:(context) => CountryPage(snapshot.data[index]['name'])));
                                        },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                            ,itemCount: snapshot.data.length,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountryPage extends StatelessWidget {
  //const RegionPage({Key? key}) : super(key: key);
  CountryPage(this.countryselected);
  var countryselected = "";


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var screenheight = queryData.size.height;
    var screenwidth = queryData.size.width;
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 0),
      child: Scaffold(
        //backgroundColor: NeumorphicTheme.baseColor(context),
        backgroundColor: HexColor("E0E5EC"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenheight*0.05,horizontal: screenwidth*0.04),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.arrow_back_rounded,size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: 230,
                      height: 40,
                      /*decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black),
                            left: BorderSide(width: 1.0, color: Colors.black),
                            right: BorderSide(width: 1.0, color: Colors.black),
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          )
                      ),*/
                      child: NeumorphicText(
                        countryselected,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          depth: 10,
                          color: Colors.black,
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.concave,
                        shadowLightColor: HexColor("#FFFFFF"),
                        shadowDarkColor: HexColor("#A3B1C6"),
                        color: HexColor("#E0E5EC"),
                        intensity: 0.9,
                        border: NeumorphicBorder(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            width: 1
                        ),
                      ),
                      child: Icon(Icons.refresh_outlined,size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
                FutureBuilder(
                  future: DBProvider.db.countrydetails("'"+countryselected+"'"),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      return Container(
                        width: 390,
                        height: 686,
                        child: ListView.builder(itemBuilder: (context,index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Neumorphic(
                                  child: Container(
                                    width: 198,
                                    height: 130,
                                    child: SvgPicture.network(snapshot.data[index]['flag']),
                                  ),
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    shadowLightColor: HexColor("#FFFFFF"),
                                    shadowDarkColor: HexColor("#A3B1C6"),
                                    color: HexColor("#E0E5EC"),
                                    intensity: 0.9,
                                    border: NeumorphicBorder(
                                        color: Color.fromRGBO(255, 255, 255, 0.2),
                                        width: 1
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Neumorphic(
                                      child: Container(
                                        width: 170,
                                        height: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              NeumorphicText(
                                                "Nearby Countries" ,
                                                //"Country",
                                                textStyle: NeumorphicTextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
                                        shadowLightColor: HexColor("#FFFFFF"),
                                        shadowDarkColor: HexColor("#A3B1C6"),
                                        color: HexColor("#E0E5EC"),
                                        intensity: 0.9,
                                        border: NeumorphicBorder(
                                            color: Color.fromRGBO(255, 255, 255, 0.2),
                                            width: 1
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Neumorphic(
                                      child: Container(
                                        width: 170,
                                        height: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              NeumorphicText(
                                                "Languages" ,
                                                //"Country",
                                                textStyle: NeumorphicTextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
                                        shadowLightColor: HexColor("#FFFFFF"),
                                        shadowDarkColor: HexColor("#A3B1C6"),
                                        color: HexColor("#E0E5EC"),
                                        intensity: 0.9,
                                        border: NeumorphicBorder(
                                            color: Color.fromRGBO(255, 255, 255, 0.2),
                                            width: 1
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                          ,itemCount: snapshot.data.length,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}