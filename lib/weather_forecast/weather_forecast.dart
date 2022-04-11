import 'package:flutter/material.dart';

class WeatherForecasr extends StatefulWidget {
  const WeatherForecasr({ Key? key }) : super(key: key);

  @override
  State<WeatherForecasr> createState() => _WeatherForecasrState();
}

class _WeatherForecasrState extends State<WeatherForecasr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
      ),
      
    );
  }
}