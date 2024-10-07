import 'package:flutter/material.dart';
import 'package:weather_vol2/models/weather_model.dart';
import 'package:weather_vol2/models/weather_services.dart';

import 'package:weather_vol2/models/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WeatherModel> _weathers = [];
  String _city = '';
  Constants myConstants = Constants();

  void _getWeatherData() async {
    try {
      _weathers = await WeatherServices().getWeatherData();
      _city = await WeatherServices().getLocation(); // Şehir adını al
    } catch (e) {
      print(e);
    }
    setState(() {});
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
                const SizedBox(width: 0),// buraya dropdown koyulacak koyulan dropdown sabit bir label olacak o label ile seçim ekranına gidilecek
                // seçim ekranında seçilen şehirler Home ekranında görünecek dropdowm dan da geçiş sağlanacak
                //sabıt bir de anlık konum acılacak eğer konum kapalıysa otomatık istanbul ayarlanacak
                //Ekstradan eğer konum kapalıysa pop up şeklinde uyarıya bakılacak
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
            // Weather verilerini listeleyelim
            Expanded(
              child: ListView.builder(
                itemCount: _weathers.length, // Liste uzunluğu
                itemBuilder: (context, index) {
                  final weather = _weathers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${weather.gun}", // Gün ve tarih verisi
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "${weather.tarih}", // Tarih bilgisi
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 25), // Gölgenin konumu
                              blurRadius: 10, // Gölgenin yayılması
                              spreadRadius: -12
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                                top: -40,
                                left: 20,
                                child: Image.network(weather.ikon, width: 150)
                            ),
                            Positioned(
                                bottom: 30,
                                left: 20,
                                child: Text("${weather.durum.toUpperCase()}", style: const TextStyle(
                                  color: Colors.white,
                                fontSize: 20,
                                ),),
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
                                        "${double.parse(weather.derece).toInt()}°", // Tam sayı olarak yazdırma
                                        style: TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()..shader = linearGradient
                                        ),
                                      ),
                                    ),


                                  ],
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text('Rqüzgar',style: TextStyle(
                                  color: Colors.black54,
                                ),),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E8Fb),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Image.asset('assets/windsock.png'),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text("km/s", style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)// Apı rüzgar hızını desteklemiyor
                              ],
                            ),
                          ],
                        ),
                      ),

                      //iki container i ayırmaya yarıyor
                      const SizedBox(
                        height: 120,
                      ),

                      /////dk 51 de kaldım onu ayarlama lazım








                      /*Image.network(weather.ikon, width: 100),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "${weather.durum.toUpperCase()} \n ${weather.derece}°",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      /*Text(
                        "Sıcaklık: ${weather.degree}°C", // Sıcaklık verisi
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),*/

                      const SizedBox(height: 10),*/

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
