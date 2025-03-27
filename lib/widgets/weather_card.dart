import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/main.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
import '../model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  String formatTime(int timeStamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(115, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                weather.description.toLowerCase().contains('rain') ||
                        weather.description.toLowerCase().contains('drizzle') ||
                        weather.description.toLowerCase().contains(
                          'thunderstorm',
                        )
                    ? 'assets/rain.json'
                    : weather.description.toLowerCase().contains('clear') ||
                        weather.description.toLowerCase().contains('sunny')
                    ? 'assets/sunny.json'
                    : weather.description.toLowerCase().contains('haze') ||
                        weather.description.toLowerCase().contains('cloudy') ||
                        weather.description.toLowerCase().contains('mist') ||
                        weather.description.toLowerCase().contains('scattered') ||
                    weather.description.toLowerCase().contains('few')  ||
                    weather.description.toLowerCase().contains('overcast')  ||
                    weather.description.toLowerCase().contains('broken')
                    ? 'assets/cloudy.json'
                    : 'assets/splashWel.json',

                height: 200,
                width: 200,
              ),

              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 10),

              Text(
                //to convert double temp value to single(string)
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Text(
              //   'Feels Like:${weather.feelslike}°C',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              // SizedBox(height: 10),
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       'Max Temp:${weather.tempMax}°C',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Text(
              //       'Min Temp:${weather.tempMin}°C',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Text(
              //       'Cloud:${weather.clouds}%',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //   ],
              // ),
              SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 3,
                // 2 columns
                shrinkWrap: true,
                // Important to prevent GridView from taking infinite height
                physics: const NeverScrollableScrollPhysics(),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.thermostat_outlined, color: Colors.white),
                      Text(
                        'Feels Like',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${weather.feelslike.toStringAsFixed(1)}°C',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.water_drop_outlined, color: Colors.white),
                      Text(
                        'Humidity:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${weather.humidity}%',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.air_outlined, color: Colors.white),
                      Text(
                        'Wind',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      Text(
                        '${(weather.windSpeed * 3.6).toStringAsFixed(1)}km/h',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 3,
                // 2 columns
                shrinkWrap: true,
                // Important to prevent GridView from taking infinite height
                physics: const NeverScrollableScrollPhysics(),

                children: [
                  Column(
                    children: [
                      Icon(Icons.arrow_upward_outlined, color: Colors.white),
                      Text(
                        'Max Temp',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${weather.tempMax.toStringAsFixed(1)}°C',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.arrow_downward_outlined, color: Colors.white),
                      Text(
                        'Min Temp',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${weather.tempMin.toStringAsFixed(1)}°C',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.cloud_queue_outlined, color: Colors.white),
                      Text(
                        'Clouds',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${weather.clouds}%',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                // 2 columns
                shrinkWrap: true,
                // Important to prevent GridView from taking infinite height
                physics: const NeverScrollableScrollPhysics(),

                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined, color: Colors.white),
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined, color: Colors.white),
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
