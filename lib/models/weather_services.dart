import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_App/models/weather_model.dart';

class WeatherServices {
  // Kullanıcının konumunu alma metodu
  Future<String> getLocation() async {
    // Kullanıcının konum servisini kontrol etme
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Konum servisiniz kapalı");
    }

    // Konum izni kontrolü
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Konum izni almak için istek gönderme
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Konum izni vermelisiniz!");
      }
    }

    // Kullanıcının geçerli konumunu alma
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Koordinatlardan yerleşim noktası bilgilerini alma
    final List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Şehir bilgisini alma
    final String? city = placemark[0].administrativeArea;

    // Şehir bilgisi null ise hata döndürme
    if (city == null) {
      return Future.error("Bir sorun oluştu");
    }

    return city;
  }

  // Hava durumu verilerini alma metodu
  Future<List<WeatherModel>> getWeatherData() async {
    try {
      // Kullanıcının konumundan şehir bilgisini alma
      final String city = await getLocation();

      // API URL'sini oluşturma
      final String url =
          "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";

      // .env dosyasından API anahtarını alma
      final String apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

      // API için gerekli başlıkları hazırlama
      final Map<String, dynamic> headers = {
        "authorization": "apikey $apiKey",
        "content-type": "application/json"
      };

      // Dio ile API'ye istek gönderme
      final dio = Dio();
      final response = await dio.get(url, options: Options(headers: headers));

      // Yanıt kodunu kontrol etme
      if (response.statusCode != 200) {
        return Future.error("Hava durumu verisi alınamadı");
      }

      // JSON verisinden WeatherModel listesi oluşturma
      final List list = response.data['result'];
      final List<WeatherModel> weatherList =
      list.map((e) => WeatherModel.fromJson(e)).toList();

      return weatherList;
    } catch (e) {
      // Herhangi bir hata durumunda hata mesajı döndürme
      return Future.error("Bir sorun oluştu: $e");
    }
  }
}