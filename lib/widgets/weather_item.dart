import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.value,required this.text,required this.unit,required this.imageUrl,
  });

  final String value;
  final String text;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text , // değişcek
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xffE0E8Fb),
            borderRadius:
            BorderRadius.all(Radius.circular(15)),
          ),
          child: Image.asset(imageUrl), // değişecek
        ),
        const SizedBox(
          height: 8,
        ),
        Text(value.toString() +
            unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ) // Apı rüzgar hızını desteklemiyor
      ],
    );
  }
}