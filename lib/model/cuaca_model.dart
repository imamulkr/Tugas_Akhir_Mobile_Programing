class Cuaca {
  String? kota;
  double? temperatur;
  double? angin;
  int? kelembaban;
  double? dirasakan;
  int? tekananUdara;

  Cuaca(
      {this.kota,
      this.temperatur,
      this.angin,
      this.kelembaban,
      this.dirasakan,
      this.tekananUdara});

  Cuaca.fromJson(Map<String, dynamic> obj) {
    kota = obj["name"];
    temperatur = obj["main"]["temp"];
    angin = obj["wind"]["speed"];
    tekananUdara = obj["main"]["pressure"];
    kelembaban = obj["main"]["humidity"];
    dirasakan = obj["main"]["feels_like"];
  }
}
