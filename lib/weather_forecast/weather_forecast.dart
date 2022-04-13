import 'package:flutter/material.dart';
// import 'package:quizapp/parsing_json/json_parsing.dart';
// import 'package:quizapp/parsing_json/json_parsing_map.dart';
import 'package:quizapp/weather_forecast/model/weather_forecast_model.dart';
import 'package:quizapp/weather_forecast/network/network.dart';

class WeatherForecasr extends StatefulWidget {
  const WeatherForecasr({ Key? key }) : super(key: key);

  @override
  State<WeatherForecasr> createState() => _WeatherForecasrState();
}

class _WeatherForecasrState extends State<WeatherForecasr> {

  late Future<WeatherForecastModel> weatherObjects;
  String _cityName = 'Mumbai';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherObjects = Network().getWeatherForecast(cityname: _cityName);

    weatherObjects.then((value)  {
      print(value.city!.country);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
      ),
      
      
    );
  }
}