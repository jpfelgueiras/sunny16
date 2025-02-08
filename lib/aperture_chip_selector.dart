import 'package:flutter/material.dart';

class ApertureChipSelector extends StatefulWidget {
  @override
  _ApertureChipSelectorState createState() => _ApertureChipSelectorState();
}

class _ApertureChipSelectorState extends State<ApertureChipSelector> {
  final List<double> apertures = [
    1.4,
    2.0,
    2.8,
    4.0,
    5.6,
    8.0,
    11.0,
    16.0,
    22.0
  ];
  double _selectedAperture = 2.8;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: apertures.map((fStop) {
        return ChoiceChip(
          label: Text("f/$fStop"),
          selected: _selectedAperture == fStop,
          onSelected: (bool selected) {
            setState(() {
              _selectedAperture = fStop;
            });
          },
        );
      }).toList(),
    );
  }
}
