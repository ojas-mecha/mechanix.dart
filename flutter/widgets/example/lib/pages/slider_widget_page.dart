import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class MechanixSliderPage extends StatefulWidget {
  const MechanixSliderPage({super.key});

  @override
  State<MechanixSliderPage> createState() => _MechanixSliderPageState();
}

class _MechanixSliderPageState extends State<MechanixSliderPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          MechanixSlider.bar(
            initialValue: 0.6,
            leftIcon: IconWidget.fromIconData(
              icon: Icon(Icons.volume_up),
            ),
            onChanged: (value) {
              print('Volume changed to: $value');
            },
          ),
          MechanixSlider.dot(
            initialValue: 0.6,
            leftIcon: IconWidget.fromIconData(icon: Icon(Icons.volume_up)),
            onChanged: (value) {
              print('Volume changed to: $value');
            },
          ),
          MechanixSlider.bar(
            initialValue: 0.6,
            leftIcon: IconWidget.fromIconData(icon: Icon(Icons.volume_up)),
            theme: MechanixSliderThemeData(
              iconColor: Colors.white,
              iconSize: 24.0,
              activeColor: const Color(0xFF3283E8),
              inactiveColor: const Color(0xFF404040),
            ),
            onChanged: (value) {
              print('Volume changed to: $value');
            },
          ),
          MechanixSlider.dot(
            initialValue: 0.4,
            leftIcon: IconWidget.fromIconData(icon: Icon(Icons.brightness_6)),
            theme: MechanixSliderThemeData(
              iconColor: Colors.orange,
              iconSize: 20.0,
              activeColor: Colors.orange,
              inactiveColor: const Color(0xFF404040),
            ),
            onChanged: (value) {
              print('Brightness changed to: $value');
            },
          ),
          MechanixSlider.bar(
            initialValue: 0.8,
            leftIcon: IconWidget.fromIconData(icon: Icon(Icons.speed)),
            theme: MechanixSliderThemeData(
              iconColor: Colors.green,
              activeColor: Colors.green,
              inactiveColor: const Color(0xFF404040),
            ),
            onChanged: (value) {
              print('Speed changed to: $value');
            },
          ),
          MechanixSlider.bar(
            initialValue: 0.5,
            theme: MechanixSliderThemeData(
              activeColor: const Color(0xFF3283E8),
              inactiveColor: const Color(0xFF404040),
            ),
            onChanged: (value) {
              print('Value changed to: $value');
            },
          )
        ],
      ),
    );
  }
}
