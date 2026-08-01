import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Elevated Buttons Section
        const Text(
          "Elevated Buttons",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            MechanixElevatedButton(
              onPressed: () {},
              label: 'Default',
            ),
            const SizedBox(width: 12),
            MechanixElevatedButton(
              onPressed: () {},
              label: 'Colored',
              backgroundColor: Colors.blue,
            ),
            const SizedBox(width: 12),
            MechanixElevatedButton(
              onPressed: () {},
              label: 'Rounded',
              backgroundColor: Colors.blue,
              borderRadius: 50.0,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 24),

        // Outlined Buttons Section
        const Text(
          "Outlined Buttons",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            MechanixOutlinedButton(
              onPressed: () {},
              label: 'Default',
            ),
            const SizedBox(width: 12),
            MechanixOutlinedButton(
              onPressed: () {},
              label: 'Colored',
              borderColor: Colors.blue,
            ),
            const SizedBox(width: 12),
            MechanixOutlinedButton(
              onPressed: () {},
              label: 'Rounded',
              borderRadius: 50.0,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 24),

        // Text Buttons Section
        const Text(
          "Text Buttons",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            MechanixTextButton(
              onPressed: () {},
              label: 'Default',
            ),
            const SizedBox(width: 12),
            MechanixTextButton(
              onPressed: () {},
              label: 'Colored',
              textColor: Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
