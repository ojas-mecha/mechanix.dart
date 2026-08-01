import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class MechanixIconWidget extends StatefulWidget {
  const MechanixIconWidget({super.key});

  @override
  State<MechanixIconWidget> createState() => _MechanixIconWidgetState();
}

class _MechanixIconWidgetState extends State<MechanixIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconWidget(
            iconWidth: 20,
            iconHeight: 40,
            iconPath: MechanixIconImages.wifi,
          ),
          IconWidget(
            iconWidth: 30,
            iconHeight: 30,
            iconColor: Colors.blue,
            iconPath: MechanixIconImages.wifi,
          ),
          IconWidget(
            iconWidth: 40,
            iconHeight: 20,
            iconPath: MechanixIconImages.wifi,
          ),
          IconWidget.fromIconData(icon: Icon(Icons.wallet)),
          const SizedBox(height: 20),
          const Text('MechanixIcons Font:'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MechanixIcons.home, size: 28),
              SizedBox(width: 16),
              Icon(MechanixIcons.wifi, size: 28),
              SizedBox(width: 16),
              Icon(MechanixIcons.bluetooth, size: 28),
              SizedBox(width: 16),
              Icon(MechanixIcons.settings, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}
