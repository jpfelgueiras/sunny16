import 'package:flutter/material.dart';

class ConditionSelector extends StatelessWidget {
  final Map<String, IconData> weatherIcons;
  final String? selectedCondition;
  final Function(String) onConditionSelected;

  const ConditionSelector({
    super.key,
    required this.weatherIcons,
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
          children: weatherIcons.entries.map((entry) {
            return Column(
              children: [
                IconButton(
                  icon: Icon(
                    entry.value,
                    size: 40,
                    color: selectedCondition == entry.key ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => onConditionSelected(entry.key),
                ),
                Text(
                    entry.key.replaceAll('_', ' ').split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' '),
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
