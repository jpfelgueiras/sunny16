import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ApertureGlassmorphicSlider extends StatefulWidget {
  @override
  _ApertureGlassmorphicSliderState createState() =>
      _ApertureGlassmorphicSliderState();
}

class _ApertureGlassmorphicSliderState
    extends State<ApertureGlassmorphicSlider> {
  double _aperture = 2.8;
  final List<double> fStops = [1.4, 2.0, 2.8, 4.0, 5.6, 8.0, 11.0, 16.0, 22.0];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassmorphicContainer(
        width: 300,
        height: 100,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.1)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("f/${_aperture.toStringAsFixed(1)}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Slider(
              min: 1.4,
              max: 22,
              divisions: fStops.length - 1,
              value: _aperture,
              activeColor: Colors.orange,
              label: "f/${_aperture.toStringAsFixed(1)}",
              onChanged: (value) {
                setState(() {
                  _aperture = fStops.reduce(
                      (a, b) => (value - a).abs() < (value - b).abs() ? a : b);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
