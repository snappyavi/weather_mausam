import 'package:http/http.dart' as http;
import '../model/weather_model.dart';
import 'dart:convert';

class WeatherServices {
  final String apiKey = '47b7bccc47847faf91475ec4a28628fa';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
    //  'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );

    final response = await http.get(url); //network call

    if (response.statusCode==200){
      return Weather.fromJson(json.decode(response.body));
    } else{
      throw Exception('Failed to Load Data');
    }
  }
}

// import 'package:http/http.dart' as http;
// import '../model/weather_model.dart';
// import 'dart:convert';
//
// class WeatherServices {
//   final String apiKey = '47b7bccc47847faf91475ec4a28628fa';
//
//   Future<Weather> fetchWeather(String cityName) async {
//     final url = Uri.parse(
//       'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric', // Added &units=metric
//     );
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         return Weather.fromJson(json.decode(response.body));
//       } else if (response.statusCode == 404) {
//         throw Exception('City not found');
//       } else {
//         throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Network error or API issue: $e'); // more robust error.
//     }
//   }
// }