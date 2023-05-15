import 'package:flutter/material.dart';

class NewCoffeeSettings extends StatefulWidget {
  const NewCoffeeSettings({super.key});

  @override
  State<NewCoffeeSettings> createState() => _NewCoffeeSettingsState();
}

class _NewCoffeeSettingsState extends State<NewCoffeeSettings> {
  double _currentSliderValue = 100;
  Color _thumbColor = Colors.brown[100] as Color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dodaj novu narudzbinu',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Jacina kafe'),
        Slider(
          value: _currentSliderValue,
          min: 100,
          max: 900,
          divisions: 100,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              _thumbColor = Colors.brown[value ~/ 100 * 100] as Color;
            });
          },
          thumbColor: _thumbColor,
          activeColor: _thumbColor,
          inactiveColor: Colors.brown[100],
        ),
      ],
    );
  }
}
