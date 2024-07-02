import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:aplikasi_cuaca/model/cuaca_model.dart';

class WeatherApiClient {
  Future<Cuaca>? getCurrentWeather(String? lokasi) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$lokasi&appid=edba38a31b59b3f443caf5d8049959e4&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Cuaca.fromJson(body).kota);
    return Cuaca.fromJson(body);
  }
}
