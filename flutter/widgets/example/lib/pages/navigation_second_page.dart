import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

class NavigationSecondPage extends StatelessWidget {
  const NavigationSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MechanixNavigationBar(
          title: "Back ",
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to Home Page")),
        ));
  }
}
