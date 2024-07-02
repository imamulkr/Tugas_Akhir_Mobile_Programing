import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelompok 5 Mobile Programming',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tugas Kelompok 5 Mobile Programming'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _temperature = 0.0;
  int _humidity = 0;
  double _wind = 0.0;
  double _visibility = 0.0;
  String _date = DateFormat('d MMMM yyyy').format(DateTime.now());
  bool _isLoading = true;

  List<dynamic> _hourlyWeather = [];
  List<dynamic> _dailyWeather = [];

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    const apiKey = 'd6831890fb819621251711e2f1f2ca48';
    const city = 'Jakarta';
    const countryCode = 'ID';
    final apiUrl =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city,$countryCode&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _hourlyWeather = data['list'];
        _dailyWeather = data['list']
            .where((element) =>
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    element['dt'] * 1000,
                    isUtc: true)) ==
                '12:00')
            .toList();

        setState(() {
          _temperature = data['list'][0]['main']['temp'];
          _humidity = data['list'][0]['main']['humidity'];
          _wind = data['list'][0]['wind']['speed'];
          _visibility = data['list'][0]['visibility'] / 1000;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF86a9e6),
                Color(0xFF6072d9),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 64.0),
                    _buildMainWeather(),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -100),
                child: _buildForecastCard(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Jakarta, Indonesia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainWeather() {
    return Column(
      children: [
        Text(
          '$_temperature°',
          style: const TextStyle(
            fontSize: 164,
            fontWeight: FontWeight.bold,
            letterSpacing: -8,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -110),
          child: Image.asset(
            'assets/image/cloud.png',
            width: 250,
            height: 250,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -110),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: -10,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Card(
              color: Colors.white,
              shadowColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherDetail(
                      icon: CupertinoIcons.wind,
                      value: '$_wind km/h',
                      label: 'Wind',
                    ),
                    _buildWeatherDetail(
                      icon: CupertinoIcons.drop,
                      value: '$_humidity%',
                      label: 'Humidity',
                    ),
                    _buildWeatherDetail(
                      icon: CupertinoIcons.eye,
                      value: '$_visibility km',
                      label: 'Visibility',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30.0,
          color: const Color(0xFF91ace6),
        ),
        const SizedBox(height: 12.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildForecastCard() {
    return Card(
      color: Colors.white,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Today',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 16),
            _buildHourlyForecast(),
            const SizedBox(height: 16),
            _buildDailyForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _hourlyWeather.length,
        itemBuilder: (context, index) {
          final hourlyData = _hourlyWeather[index];
          final temperature = hourlyData['main']['temp'];
          final icon = hourlyData['weather'][0]['icon'];
          final time = DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
              hourlyData['dt'] * 1000,
              isUtc: true,
            ),
          );

          return _buildForecastCardItem(
            temperature: temperature,
            icon: icon,
            label: time,
          );
        },
      ),
    );
  }

  Widget _buildDailyForecast() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dailyWeather.length,
        itemBuilder: (context, index) {
          final dailyData = _dailyWeather[index];
          final temperature = dailyData['main']['temp'];
          final icon = dailyData['weather'][0]['icon'];
          final date = DateFormat('EEE').format(
            DateTime.fromMillisecondsSinceEpoch(
              dailyData['dt'] * 1000,
              isUtc: true,
            ),
          );

          return _buildForecastCardItem(
            temperature: temperature,
            icon: icon,
            label: date,
          );
        },
      ),
    );
  }

  Widget _buildForecastCardItem({
    required double temperature,
    required String icon,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 2,
