import 'package:flutter/material.dart';
import 'package:weather/pages/weather_tiles.dart';
import 'homeview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(color: Color.fromARGB(255, 38, 34, 34)),
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(Icons.folder_copy_outlined),
            ),
            onTap: () {
              WeatherTile();
            },
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(Icons.pin_drop_outlined),
            ),
            onTap: () {},
          )
        ],
      ),
      body: const HomeView(),
    );
  }
}
