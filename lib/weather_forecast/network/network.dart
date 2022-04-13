

import 'dart:convert';

import 'package:http/http.dart';

import '../model/weather_forecast_model.dart';
import '../util/forecast_util.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast({required String cityname}) async {
    // var finalUrl = 'api.openweathermap.org/data/2.5/forecast/daily?q=' + cityname + ' &units=metric&cnt=7&appid=' + Util.appId;
    // var finalUrl = 'api.openweathermap.org/data/2.5/forecast/daily?q=' + cityname + '&units=imperial&cnt=7&appid=' + Util.appId;
    var finalUrl = 'api.openweathermap.org/data/2.5/forecast/daily?q=' + cityname + '&units=imperial&cnt=7&appid=' + Util.appId;
    print(finalUrl + 'print url');


    final response = await get(Uri.parse(finalUrl));
    
    print('Url: ${Uri.encodeFull(finalUrl)}');

    if(response.statusCode == 200) {
      print('${response.body}');
      return WeatherForecastModel.fromJson(json.decode(response.body)); 
    } else {
      throw Exception('Error getting weather forecast');
    }
  }
}