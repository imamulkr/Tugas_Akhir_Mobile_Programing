import 'package:aplikasi_cuaca/model/cuaca_model.dart';
import 'package:aplikasi_cuaca/services/weather_api_client.dart';
import 'package:aplikasi_cuaca/views/cuaca_sekarang.dart';
import 'package:aplikasi_cuaca/views/informasi_tambahan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Cuaca? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Pamulang");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Aplikasi Cuaca",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cuacaSekarang(Icons.wb_sunny_rounded, "${data!.temperatur}°",
                    "${data!.kota}"),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Informasi Tambahan",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xdd212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20.0,
                ),
                informasiTambahan("${data!.angin}", "${data!.tekananUdara}",
                    "${data!.kelembaban}", "${data!.dirasakan}°"),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
