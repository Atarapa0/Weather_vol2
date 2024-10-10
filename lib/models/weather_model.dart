class WeatherModel {
  final String gun;
  final String tarih; // tarih tipini String yap
  final String ikon;
  final String durum;
  final String derece;
  final String min;
  final String max;
  final String gece;
  final String nem;

  WeatherModel(this.gun, this.tarih, this.ikon, this.durum, this.derece,
      this.min, this.max, this.gece, this.nem);

  WeatherModel.fromJson(Map<String, dynamic> json)
      : gun = json['day'],
        tarih = json['date'], // Burayı güncelledik
        ikon = json['icon'],
        durum = json['description'],
        derece = json['degree'],
        min = json['min'],
        max = json['max'],
        gece = json['night'],
        nem = json['humidity'];
}
