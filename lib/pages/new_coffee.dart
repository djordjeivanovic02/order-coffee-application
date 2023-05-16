import 'package:flutter/material.dart';

class NewCoffeeSettings extends StatefulWidget {
  const NewCoffeeSettings({super.key});

  @override
  State<NewCoffeeSettings> createState() => _NewCoffeeSettingsState();
}

class _NewCoffeeSettingsState extends State<NewCoffeeSettings> {
  double _currentSliderValue = 100;
  Color _thumbColor = Colors.brown[100] as Color;
  int _sugarCount = 0;
  bool milk = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Dodaj novu narudzbinu',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Jacina kafe',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Slider(
                value: _currentSliderValue,
                min: 100,
                max: 900,
                divisions: 8,
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
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Kocke secera',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_sugarCount > 0) {
                            _sugarCount--;
                          }
                        });
                      },
                      color: Colors.brown[500],
                      icon: const Icon(
                        Icons.remove,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    _sugarCount.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.brown[500]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _sugarCount++;
                        });
                      },
                      color: Colors.brown[500],
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Mleko',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Checkbox(
                  focusColor: Colors.amber,
                  checkColor: Colors.brown[500],
                  fillColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.brown[100] as Color;
                    } else {
                      return Colors.grey;
                    }
                  }),
                  value: milk,
                  onChanged: (value) {
                    setState(() {
                      milk = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: () {
                print("${_currentSliderValue ~/ 100} $_sugarCount $milk");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.brown[100],
              ),
              child: Text(
                'Sacuvaj izmene',
                style: TextStyle(
                  color: Colors.brown[500],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
