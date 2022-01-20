import 'package:countrytest/models/country.dart';
import 'package:countrytest/services/country_service.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  static const Color mainColorLight = Color(0xFFf8519c);
  Color changeColorLightness(Color color) =>
      HSLColor.fromColor(color).withLightness(0.93).toColor();
//Initial Height and Width for the transparent container
  double _height = 0;
  double _width = 0;
  //Initial Country and Initial Flag
  String _countryName = "Tunisia";
  String _countryFlag = "TN";

  late Future<List<Country>> countriesList;
  @override
  void initState() {
    //Get the countries from the API
    countriesList = CountryService().getCountries();
    super.initState();
  }

  void callContainer() {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
  }

  void returnToSecondScreen(String name, String flag) {
    setState(() {
      _height = 0;
      _width = 0;
      //Change the country and the flag
      _countryName = name;
      _countryFlag = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: changeColorLightness(
          mainColorLight) /*mainColorLight.withOpacity(0.8)*/,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top:
                    _height == 0 ? MediaQuery.of(context).size.height / 2 : 100,
                left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Flag
                Flag.fromString(
                  _countryFlag,
                  borderRadius: 8,
                  fit: BoxFit.cover,
                  height: 45,
                  width: 70,
                ),
                //Country Name
                GestureDetector(
                  onTap: callContainer,
                  child: Container(
                    width: 250,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        _countryName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Container(
              child: FutureBuilder(
                future: countriesList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Country>> snapshot) {
                  List<Country>? countries = snapshot.data;
                  if (snapshot.hasData) {
                    //Building the list of countries
                    return Padding(
                      padding: const EdgeInsets.only(top: 170.0),
                      child: ListView.builder(
                          itemCount: countries!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 23.0, left: 100.0),
                              child: Row(
                                children: [
                                  //Flag
                                  Flag.fromString(
                                    countries[index].iso2,
                                    height: 30,
                                    width: 60,
                                  ),
                                  //Country Name
                                  GestureDetector(
                                    onTap: () {
                                      returnToSecondScreen(
                                          countries[index].name,
                                          countries[index].iso2);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 3.0),
                                      width: 150,
                                      height: 30,
                                      color: Colors.white,
                                      child: Center(
                                        child: Text(
                                          countries[index].name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return const SizedBox(
                      height: 70,
                      width: 70,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        colors: [Colors.grey],
                        strokeWidth: 2,
                      ),
                    );
                  }
                },
              ),
              height: _height,
              width: _width,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
}
