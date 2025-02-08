import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ApertureDial extends StatefulWidget {
  @override
  _ApertureDialState createState() => _ApertureDialState();
}

class _ApertureDialState extends State<ApertureDial> {
  double _aperture = 2.8;
  final List<double> fStops = [1.4, 2.0, 2.8, 4.0, 5.6, 8.0, 11.0, 16.0, 22.0];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Aperture: f/${_aperture.toStringAsFixed(1)}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 1.4,
              maximum: 22,
              interval: 1.4,
              showLabels: true,
              showTicks: true,
              labelsPosition: ElementsPosition.outside,
              axisLineStyle: AxisLineStyle(thickness: 10),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: _aperture,
                  enableAnimation: true,
                  needleColor: Colors.red,
                  knobStyle: KnobStyle(color: Colors.black),
                  onValueChanged: (double value) {
                    setState(() {
                      _aperture = value;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
