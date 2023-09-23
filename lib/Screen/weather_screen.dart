// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/Models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherModel weatherModel;
  final dio = Dio();
  bool isloading = true;
  String baseURL = "http://api.weatherapi.com/v1";
  String APIkey = "ebb121c531dc42bcb98104523232009";
  String cityName = "Sohag";

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future<void> getWeatherData() async {
    Response response = await dio.get(
        "$baseURL/forecast.json?key=$APIkey&q=$cityName&days=1&aqi=no&alerts=no");
    weatherModel = WeatherModel.fromJson(response.data);
    setState(() {});
    isloading = false;
    print(weatherModel.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 15, 15),
        title: Center(
            child: Text(
          "Weather App",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Color.fromARGB(255, 64, 64, 61),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weatherModel.cityName}',
                      style: TextStyle(
                      color: Color.fromARGB(255, 227, 220, 220),
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'updated at ${weatherModel.lastDate}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 227, 220, 220),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          "https:${weatherModel.image}",
                          height: 100,
                        ),
                        Text(
                          '${weatherModel.temp}Â°C',
                          style: TextStyle(
                            color: Color.fromARGB(255, 183, 55, 35),
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Maxtemp: ${weatherModel.maxTemp}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 227, 220, 220),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Mintemp: ${weatherModel.minTemp}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 227, 220, 220),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      '${weatherModel.weatherCondation}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 227, 220, 220),
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
