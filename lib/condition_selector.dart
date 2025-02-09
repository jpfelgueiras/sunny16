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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weatherIcons.entries.map((entry) {
        return IconButton(
          icon: Icon(
            entry.value,
            size: 40,
            color: selectedCondition == entry.key ? Colors.blue : Colors.grey,
          ),
          onPressed: () => onConditionSelected(entry.key),
        );
      }).toList(),
    );
  }
}
