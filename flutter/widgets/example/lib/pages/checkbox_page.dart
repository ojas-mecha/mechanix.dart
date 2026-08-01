import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  final List<bool?> _checkboxValues = [false, null, true];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Row(
              children: [
                MechanixCircleCheckbox(
                  value: _checkboxValues[index],
                  onChanged: (v) => setState(() => _checkboxValues[index] = v),
                  tristate: true,
                  activeColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
