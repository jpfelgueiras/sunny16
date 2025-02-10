import 'package:flutter/material.dart';

class ConditionSelector extends StatelessWidget {
  final Map<String, Map<String, dynamic>> weatherData;
  final String? selectedCondition;
  final Function(String) onConditionSelected;

  const ConditionSelector({
    super.key,
    required this.weatherData,
    required this.selectedCondition,
    required this.onConditionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Condition",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weatherData.entries.map((entry) {
            return Column(
              children: [
                IconButton(
                  icon: Icon(
                    entry.value['icon'],
                    size: 40,
                    color: selectedCondition == entry.key ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => onConditionSelected(entry.key),
                ),
                Text(
                  entry.key.replaceAll('_', ' '),
                  style: TextStyle(
                    color: selectedCondition == entry.key ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
