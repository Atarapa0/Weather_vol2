import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_App/models/weather_model.dart';

class WeatherServices {
  Future<String> getLocation() async {
    // Kullanıcının konumu açık mı diye kontrol ediyoruz
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Konum servisiniz kapalı");
    }

    // Kullanıcının konum izni vermiş mi kontrol ettik
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Konum izni vermemişse tekrar izin istedik
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Yine vermemişse hata döndürdük
        return Future.error("Konum izni vermelisiniz!");
      }
    }

    // Kullanıcının pozisyonunu aldık
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Kullanıcının pozisyonunda yerleşim noktasını bulduk
    final List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Yerleşim noktasını aldık
    //print(placemark);

    // Şehrimizi aldık (administrativeArea'yı city olarak alıyoruz)
    final String? city = placemark[0].administrativeArea;

    // Eğer city null ise bir hata döndürüyoruz
    if (city == null) {
      return Future.error("Bir sorun oluştu");
    }

    return city;
  }

  Future<List<WeatherModel>> getWeatherData() async {
    final String city = await getLocation();
    final String url =
        "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 4mr1Jo08ZcegA0CUsW9cm5:4gmXAOpDIFYI70sTUgFJZk",
      "content-type": "application/json"
    };

    final dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }
    final List list = response.data['result'];
    final List<WeatherModel> weatherList =
        list.map((e) => WeatherModel.fromJson(e)).toList();

    return weatherList;
  }
}
