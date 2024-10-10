import 'package:flutter/material.dart';
import 'package:weather_vol2/models/weather_model.dart';
import 'package:weather_vol2/models/weather_services.dart';

import 'package:weather_vol2/models/constants.dart';
import 'package:weather_vol2/widgets/weather_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WeatherModel> _weathers = [];
  String _city = '';
  bool _isloading = true; // Yükleme durumu bayrağı
  Constants myConstants = Constants();

  void _getWeatherData() async {
    _weathers = await WeatherServices().getWeatherData();
    _city = await WeatherServices().getLocation(); // Şehir adını al
    setState(() {
      _isloading = false; // Veriler yüklendiğinde yükleme bayrağı kapatılır
    });
  }

  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Eğer _isloading true ise "Yükleniyor" yazısını ya da CircularProgressIndicator göstereceğiz
    if (_isloading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'assets/get_started_image.jpg',
                    width: 40,
                    height: 40,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pin.png',
                      width: 35,
                    ),
                    const SizedBox(width: 0),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const Center(
          child:
              CircularProgressIndicator(), // Burada dönen bir yüklenme göstergesi var
          // Eğer metin istiyorsan bunun yerine Text('Yükleniyor...') yazabilirsin
        ),
      );
    }

    // Veriler geldikten sonra gösterilecek asıl ekran
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/get_started_image.jpg',
                  width: 40,
                  height: 40,
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset(
                  'assets/pin.png',
                  width: 35,
                ),
                const SizedBox(width: 0),
              ]),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _city,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1, // Liste uzunluğu
                itemBuilder: (context, index) {
                  final weather = _weathers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${weather.gun}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "${weather.tarih}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 25),
                              blurRadius: 10,
                              spreadRadius: -12,
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -40,
                              left: 20,
                              child: Image.network(weather.ikon, width: 150),
                            ),
                            Positioned(
                              bottom: 30,
                              left: 20,
                              child: Text(
                                "${weather.durum.toUpperCase()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "${double.parse(weather.derece).toInt()}°",
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            weatherItem(
                              value: weather.max,
                              text: 'Max',
                              unit: 'C',
                              imageUrl: 'assets/thermometer-plus.png',
                            ),
                            weatherItem(
                              value: weather.min,
                              text: 'Min',
                              unit: 'C',
                              imageUrl: 'assets/thermometer.png',
                            ),
                            weatherItem(
                              value: weather.nem,
                              text: 'Nem',
                              unit: '',
                              imageUrl: 'assets/humidity.png',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _weathers.length,
                          itemBuilder: (BuildContext context, int index) {
                            String today =
                                DateTime.now().toString().substring(0, 10);
                            var selectedDay = _weathers[index];
                            return GestureDetector(
                              onTap: () {
                                print(index);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.only(
                                    right: 20, bottom: 10, top: 10),
                                width: 80,
                                decoration: BoxDecoration(
                                  color: selectedDay == today
                                      ? myConstants.primaryColor
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      color: selectedDay == today
                                          ? myConstants.primaryColor
                                          : Colors.black54.withOpacity(.2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      double.parse(_weathers[index].derece)
                                              .toString() +
                                          "°",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: selectedDay == today
                                            ? Colors.white
                                            : myConstants.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Image.network(_weathers[index].ikon,
                                        width: 30),
                                    Text(
                                      _weathers[index].gun,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: selectedDay == today
                                            ? Colors.white
                                            : myConstants.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
