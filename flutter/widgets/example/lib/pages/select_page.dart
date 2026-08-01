import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

enum DisplayScreenOffTime {
  tenSeconds,
  thirtySeconds,
  sixtySeconds,
  fiveMinutes,
  never
}

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  DisplayScreenOffTime? _selectedTime;

  final List<SelectOption<DisplayScreenOffTime>> _timeOptions = [
    DisplayScreenOffTime.tenSeconds.toSelectOption('10 seconds'),
    DisplayScreenOffTime.thirtySeconds.toSelectOption('30 seconds'),
    DisplayScreenOffTime.sixtySeconds
        .toSelectOption('1 minute', leading: Icon(Icons.abc)),
    DisplayScreenOffTime.fiveMinutes.toSelectOption('5 minutes'),
    DisplayScreenOffTime.never.toSelectOption('Never turn off'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Screen timeout',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            MechanixSelect<DisplayScreenOffTime>(
              options: _timeOptions,
              value: _selectedTime,
              onChanged: (selected) {
                setState(() {
                  _selectedTime = selected.value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
