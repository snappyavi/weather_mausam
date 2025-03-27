import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Weather? _weather;
  String _lastCity = ''; // Stroing the last search city

  //formula time for previous searches

  @override
  void initState() {
    super.initState();
    _loadLastCity(); // it Loads the last city when clicked on app
  }

  Future<void> _loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastCity =
          prefs.getString('lastCity') ??
          ''; // Load from prefs or use empty string
      _controller.text = _lastCity; // Set the controller's text
    });
    if (_lastCity.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _getWeather(); // Call _getWeather after the frame is built
      }); // Fetch weather for the last city
    }
  }

  Future<void> _saveLastCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', city);
  }

  //formula time for getting new searches

  void _getWeather() async {
    String cityName = _controller.text.trim(); // Trim whitespace
    if (cityName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a city name')));
      return; // Stop execution if city name is empty
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherServices.fetchWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false;
        _saveLastCity(cityName);
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Ensure isLoading is set to false on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: SingleChildScrollView(
            // Wrap Column with SingleChildScrollView
            child: Column(
              children: [
                Lottie.asset('assets/errorcat.json', height: 50, width: 50,),
                const SizedBox(height: 10),
                const Text('Error Fetching Data'),
              ],
            ),
          ),
        ),
      );
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                      _weather!.description.toLowerCase().contains('rain')
                  ? const LinearGradient(
                    colors: [Colors.black87, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  : _weather != null &&
                      _weather!.description.toLowerCase().contains('clear')
                  ? const LinearGradient(
                    colors: [Colors.black87, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  : const LinearGradient(
                    colors: [Colors.black87, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Row(
                  // Wrap Lottie and title in a Row
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Ensure Row takes minimal space
                  children: [
                    const Text(
                      'Mausam',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(width: 5),

                    Lottie.asset(
                      'assets/splashWel.json',
                      height: 70, // Adjust height as needed
                      width: 70, // Adjust width as needed
                    ),

                    //  //
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      // Expand TextField to fill available space
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter your Preferred City",
                          hintStyle: TextStyle(color: Colors.orangeAccent),
                          filled: true,
                          fillColor: Color.fromARGB(110, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.orangeAccent,
                          ), // Add search icon
                        ),
                        onSubmitted: (value) => _getWeather(),
                      ),
                    ),
                  ],
                ),

                // const SizedBox(width: 20),
                // ElevatedButton(
                //   onPressed: _getWeather,
                //
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.orangeAccent,
                //     foregroundColor: Colors.redAccent,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: const Text(
                //     'Get Weather',
                //     style: TextStyle(fontSize: 18, color: Colors.white),
                //   ),
                //),
                // ]
                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
