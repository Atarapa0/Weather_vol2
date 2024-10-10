import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:weather_vol2/models/constants.dart';
import 'package:weather_vol2/models/weather_model.dart';
import 'package:weather_vol2/ui/home.dart';
import 'package:weather_vol2/widgets/weather_item.dart';

class DetailPage extends StatefulWidget {
  final String city;
  final int detailindex;
  final List<WeatherModel> weatherDetail;

  const DetailPage(
      {super.key,
      required this.city,
      required this.detailindex,
      required this.weatherDetail});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<WeatherModel> weathersDetail = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    int selectedIndex = widget.detailindex;

    return Scaffold(
      backgroundColor: myConstants.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: myConstants.secondaryColor,
        elevation: 0.0,
        title: Text(widget.city), //

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Home())); // home yerine dropbar sayfasına eklenecek
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 10,
              left: 10,
              child: SizedBox(
                height: 150,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.weatherDetail.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(right: 20),
                        width: 80,
                        decoration: BoxDecoration(
                            color: index == selectedIndex
                                ? Colors.white
                                : const Color(0xff9ebcf9),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.white.withOpacity(.3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.weatherDetail[index].derece}°C',
                              style: TextStyle(
                                fontSize: 16,
                                color: index == selectedIndex
                                    ? Colors.blue
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.network(
                              widget.weatherDetail[index].ikon,
                              width: 40,
                            ),
                            Text(
                              widget.weatherDetail[index].gun,
                              style: TextStyle(
                                fontSize: 16,
                                color: index == selectedIndex
                                    ? Colors.blue
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      width: size.width * .7,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 25),
                              blurRadius: 5,
                              spreadRadius: -10,
                            )
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -40,
                            left: 20,
                            child: Image.network(
                              widget.weatherDetail[selectedIndex].ikon,
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                widget.weatherDetail[selectedIndex].durum
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        widget.weatherDetail[selectedIndex].max,
                                    text: 'Max',
                                    unit: '°',
                                    imageUrl: 'assets/thermometer-plus.png',
                                  ),
                                  WeatherItem(
                                    value:
                                        widget.weatherDetail[selectedIndex].min,
                                    text: 'Min',
                                    unit: '°',
                                    imageUrl: 'assets/thermometer.png',
                                  ),
                                  WeatherItem(
                                    value:
                                        widget.weatherDetail[selectedIndex].nem,
                                    text: 'Nem',
                                    unit: '',
                                    imageUrl: 'assets/humidity.png',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${double.parse(widget.weatherDetail[selectedIndex].derece).toInt()}°",
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 250,
                      left: 20,
                      child: SizedBox(
                        height: 200,
                        width: size.width * .9,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.weatherDetail.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            String selectedDay =
                                widget.weatherDetail[index].tarih;
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 5),
                              height: 80,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: myConstants.secondaryColor
                                          .withOpacity(.1),
                                      spreadRadius: 5,
                                      blurRadius: 20,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectedDay,
                                      style: const TextStyle(
                                        color: Color(0xff6696f5),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${double.parse(widget.weatherDetail[selectedIndex].max).toInt()}°",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          '/',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${double.parse(widget.weatherDetail[selectedIndex].min).toInt()}°",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          widget.weatherDetail[index]
                                              .ikon,
                                          width: 30,
                                        ),
                                        Text(widget
                                            .weatherDetail[index].durum
                                            .toUpperCase())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
