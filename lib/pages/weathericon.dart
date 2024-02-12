import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String weatherCondition;
  final double size;

  WeatherIcon({required this.weatherCondition, this.size = 150});

  IconData _getIconData(String condition) {
    if (condition.toLowerCase().contains('sunny') ||
        condition.toLowerCase().contains('clear')) {
      return Icons.wb_sunny;
    } else if (condition.toLowerCase().contains('cloud')) {
      return Icons.cloud;
    } else if (condition.toLowerCase().contains('wind') ||
        condition.toLowerCase().contains('haze')) {
      return Icons.cloud_queue;
    } else if (condition.toLowerCase().contains('rain')) {
      return Icons.thunderstorm;
    }

    return Icons.cloud; // Default icon for unknown weather condition
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIconData(weatherCondition),
      size: size,
      color: const Color.fromARGB(
          255, 255, 255, 255), // You can change the color of the icon as needed
    );
  }
}
