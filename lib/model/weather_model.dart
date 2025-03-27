import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final double feelslike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;
  final int clouds;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelslike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.clouds,
  });

  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(cityName: json['name'],
  //      // description: json['weather']['description'],
  //     description: json['weather'] != null && (json['weather'] as List).isNotEmpty
  //         ? json['weather'][0]['description'] ?? ''
  //         : '',
  //       temperature: json['main']['temp'] - 273.15,
  //    //   feelslike: json['main']['feels_like'] - 273.15,
  //       //tempMin: json['main']['temp_min'] - 273.15,
  //      // tempMax: json['main']['temp_max'] - 273.15,
  //       humidity: json['main']['humidity'],
  //       windSpeed: json['wind']['speed'],
  //       sunrise: json['sys']['sunrise'],
  //       sunset: json['sys']['sunset'],
  //     //  clouds: json['clouds']['all'],
  //   );
  // }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      //include the below code, if it is not working
      description: json['weather'] != null && (json['weather'] as List).isNotEmpty
          ? json['weather'][0]['description'] ?? ''
          : '',
      //logically i have assumed that the weather part will be a list and the API response will not be changing in the coming 1-2 years
     // description: json['weather'][0]['main'],
      // temperature: (json['main']['temp'] as num?)?.toDouble() != null
      //     ? (json['main']['temp'] as num).toDouble() - 273.15
      //     : 0.0,
      temperature: json['main']['temp'] - 273.15,
      feelslike: json['main']['feels_like'] - 273.15,
      // feelslike: (json['main']['feels_like'] as num?)?.toDouble() != null
      //   ? (json['main']['feels_like'] as num).toDouble() - 273.15
      //      : 0.0,
      tempMax: json['main']['temp_max'] - 273.15,
      // tempMax: (json['main']['temp_max'] as num?)?.toDouble() != null
      //      ? (json['main']['temp_max'] as num).toDouble() - 273.15
      //      : 0.0,

      // tempMin: (json['main']['temp_min'] as num?)?.toDouble() != null
      //     ? (json['main']['temp_min'] as num).toDouble() - 273.15
      //     : 0.0,
      tempMin: json['main']['temp_min'] - 273.15,
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
      clouds: json['clouds']['all'] ?? 0,
    );
  }
}
