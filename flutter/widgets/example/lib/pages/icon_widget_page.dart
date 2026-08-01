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
          IconWidget.fromIconData(icon: Icon(Icons.wallet))
        ],
      ),
    );
  }
}
