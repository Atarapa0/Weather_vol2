import 'package:flutter/material.dart';
import 'package:weather_vol2/models/constants.dart';
import 'package:weather_vol2/models/weather_model.dart';
import 'package:weather_vol2/ui/home.dart';

class DetailPage extends StatefulWidget {
  final String city;
  final int detailindex;
  final List<WeatherModel> weatherDetail;


  const DetailPage({super.key, required this.city, required this.detailindex, required this.weatherDetail});

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

    int selectedIndex=widget.detailindex;

    return Scaffold(
      backgroundColor: myConstants.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: myConstants.secondaryColor,
        elevation: 0.0,
        title: Text(widget.city), //

        actions: [
          Padding(padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));// home yerine dropbar sayfasına eklenecek
              }, icon: const Icon(Icons.settings)),)
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior:  Clip.none,
        children: [
          Positioned(
              top: 10,
              left: 10,
              child: SizedBox(height: 150,
              width: 400,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:  widget.weatherDetail.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.only(right: 20),
                      width: 80,
                      decoration: BoxDecoration(
                          color: index == selectedIndex ? Colors.white : const Color(0xff9ebcf9),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.white.withOpacity(.3),
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.weatherDetail[index].derece}°C',
                          style:  TextStyle(
                            fontSize: 16,
                            color: index == selectedIndex ? Colors.blue : Colors.white,
                            fontWeight: FontWeight.w500,

                          ),),
                          Image.network(widget.weatherDetail[index].ikon,width: 40,),
                          Text(widget.weatherDetail[index].gun,
                            style:  TextStyle(
                              fontSize: 16,
                              color: index == selectedIndex ? Colors.blue : Colors.white,
                              fontWeight: FontWeight.w500,

                            ),),
                        ],
                      ),
                    );

                  }),))
        ],
      ),
    );
  }
}
