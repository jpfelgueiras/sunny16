import 'package:flutter/material.dart';

class ApertureSlider extends StatelessWidget {
  final List<double> apertureValues;
  final int sliderValue;
  final Function(int) onApertureSelected;

  const ApertureSlider({
    super.key,
    required this.apertureValues,
    required this.sliderValue,
    required this.onApertureSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Aperture",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: apertureValues.length,
                  itemBuilder: (context, index) {
                    if ((index - sliderValue).abs() > 1) {
                      return Container(
                          width: 80); // Empty space for non-adjacent values
                    }
                    return GestureDetector(
                      onTap: () => onApertureSelected(index),
                      child: Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: Text(
                          "f/${apertureValues[index]}",
                          style: TextStyle(
                            fontSize: sliderValue == index ? 24 : 18,
                            color: sliderValue == index
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
