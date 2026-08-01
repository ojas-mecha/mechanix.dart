import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MechanixElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MechanixAlertDialog(
                    title: "Are you absolutely sure?",
                    message:
                        "This action cannot be undone. This will permanently delete your account and remove your data.",
                    primaryLabel: "Delete",
                    onPrimaryPressed: () {
                      Navigator.pop(context);
                      // delete logic
                    },
                    secondaryLabel: "Cancel",
                    onSecondaryPressed: () => Navigator.pop(context),
                  ),
                );
              },
              label: 'Delete Alert',
              backgroundColor: Colors.red,
            ),
            const SizedBox(height: 12.0),
            MechanixElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MechanixAlertDialog(
                    title: "Move files to another folder?",
                    message:
                        "Your files will be moved to another folder, you can retrieve them later.",
                    primaryLabel: "Confirm",
                    onPrimaryPressed: () {
                      Navigator.pop(context);
                      // move logic
                    },
                    secondaryLabel: "Cancel",
                    onSecondaryPressed: () => Navigator.pop(context),
                    primaryColor: Colors.white,
                    primaryButtonTextColor: Colors.black,
                  ),
                );
              },
              label: 'Confirm Alert',
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 12.0),
            MechanixElevatedButton(
              onPressed: () {
                showMechanixBottomAlert(
                  context: context,
                  title: "Are you absolutely sure?",
                  message:
                      "This action cannot be undone. This will permanently delete your account and remove your data.",
                  primaryLabel: "Delete",
                  onPrimaryPressed: () {
                    // delete logic
                  },
                  secondaryLabel: "Cancel",
                  onSecondaryPressed: () {
                    // cancel logic
                  },
                );
              },
              label: 'Bottom Delete Alert',
              backgroundColor: Colors.red,
            ),
            const SizedBox(height: 12.0),
            MechanixElevatedButton(
              onPressed: () {
                showMechanixBottomAlert(
                  context: context,
                  title: "Move files to another folder?",
                  message:
                      "Your files will be moved to another folder, you can retrieve them later.",
                  primaryLabel: "Confirm",
                  onPrimaryPressed: () {
                    // delete logic
                  },
                  secondaryLabel: "Cancel",
                  onSecondaryPressed: () {},
                  primaryColor: Colors.white,
                  primaryButtonTextColor: Colors.black,
                );
              },
              label: 'Bottom Confirm Alert',
              backgroundColor: Colors.blue,
            ),
          ],
        );
      },
    );
  }
}
