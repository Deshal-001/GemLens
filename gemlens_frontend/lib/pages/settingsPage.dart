import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(index: 0),
      body: Center(
        child: FloatingActionButton(onPressed: () {
          
        }, backgroundColor: Colors.red,
      ),)
    );
  }
}