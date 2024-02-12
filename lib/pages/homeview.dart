import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'weathericon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  String _temperature = '';
  String humidity = '';
  String _city = '';
  final FocusNode _focusNode = FocusNode();
  bool _isTextFieldActive = false;
  String data = '';
  String wind = '';
  String rain = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isTextFieldActive = _focusNode.hasFocus;
      });
    });
  }

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });
    final apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(apiUrl));
    final responseData = json.decode(response.body);
    setState(() {
      _isLoading = false;
      if (responseData['main'] != null) {
        _temperature = '${responseData['main']['temp']}°C';
        humidity = '${responseData['main']['humidity']}%';
        _city = responseData['name'];
        data = responseData['weather'][0]['description'];
        wind = '${responseData['wind']['speed']} m/s';
        rain = '${responseData['rain']['1h']} cm';
      } else {
        _temperature = 'N/A';
        humidity = 'N/A';
        data = 'N/A';
        wind = 'N/A';
        rain = 'N/A';
        _city = 'City not found';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                if (!_isTextFieldActive) {
                  _focusNode.unfocus();
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 64, 207, 232),
                      Color.fromARGB(255, 249, 251, 251)
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: _focusNode,
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Enter region',
                              filled: true,
                              fillColor: _isTextFieldActive
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  )),
                            ),
                            onTap: () {
                              setState(() {
                                _isTextFieldActive = true;
                              });
                            },
                            onTapOutside: (event) => setState(() {
                              _isTextFieldActive = false;
                            }),
                          ),
                        ),
                        if (_isLoading)
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await fetchWeather(_searchController.text);
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'City: $_city',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: WeatherIcon(weatherCondition: data),
                    ),
                    const Text(
                      'Current Weather',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Temperature: $_temperature',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Humidity: $humidity',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rain: $rain',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Wind: $wind',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Description: $data',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
