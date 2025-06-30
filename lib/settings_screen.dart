import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Settings",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Center(child: Text('')),
    );
  }
}
