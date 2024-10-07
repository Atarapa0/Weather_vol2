import 'package:flutter/material.dart';
import 'package:weather_vol2/models/weather_model.dart';
import 'package:weather_vol2/models/weather_services.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<WeatherModel> _weathers = [];

  void _getWeatherData() async {
    _weathers = await WeatherServices().getWeatherData();
    setState(() {});
  }

  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}




/*
Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png',width: 20,),
                  const SizedBox(width: 4,),
                  DropdownButton(
                      value: location,
                      icon: const Icon(Icons.keyboard_arrow_down)
                      items: cities.map((String location){
                        //videonun 34. dakikasında kaldım


                      }), onChanged: onChanged)
              )

              DropdownButton(
                      value: location,
                      icon: const Icon(Icons.keyboard_arrow_down)
                      items: cities.map((String location){
                        //videonun 34. dakikasında kaldım


                      }), onChanged: onChanged)
                      */



/*
import 'package:flutter/material.dart';
import 'package:untitled/models/weather_model.dart';
import 'package:untitled/models/weather_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WeatherModel> _weathers = [];

  void _getWeatherData() async {
    _weathers = await WeatherServices().getWeatherData();
    setState(() {});
  }

  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _weathers.length,
          itemBuilder: (context, index) {
            final WeatherModel weather = _weathers[index];
            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(weather.ikon, width: 100),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: Text(
                      " ${weather.gun}\n  "
                      "${weather.durum.toUpperCase()} ${weather.derece}°",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Min: ${weather.min} °"),
                          Text("Max: ${weather.max} °"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Gece: ${weather.gece} °"),
                          Text("Nem: ${weather.nem} °"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

 */