import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApertureVerticalSlider extends StatefulWidget {
  @override
  _ApertureVerticalSliderState createState() => _ApertureVerticalSliderState();
}

class _ApertureVerticalSliderState extends State<ApertureVerticalSlider> {
  double _aperture = 2.8;
  final List<double> fStops = [1.4, 2.0, 2.8, 4.0, 5.6, 8.0, 11.0, 16.0, 22.0];

  void _onApertureChanged(double value) {
    HapticFeedback.lightImpact(); // Add haptic feedback
    setState(() {
      _aperture = fStops
          .reduce((a, b) => (value - a).abs() < (value - b).abs() ? a : b);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("f/${_aperture.toStringAsFixed(1)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: RotatedBox(
              quarterTurns: -1,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                  trackHeight: 6,
                  activeTrackColor: Colors.amber,
                  inactiveTrackColor: Colors.grey[700],
                  thumbColor: Colors.white,
                ),
                child: Slider(
                  min: 1.4,
                  max: 22.0,
                  divisions: fStops.length - 1,
                  value: _aperture,
                  onChanged: _onApertureChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
