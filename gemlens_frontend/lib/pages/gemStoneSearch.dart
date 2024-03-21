import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';

class GemStoneSearchPage extends StatefulWidget {
  const GemStoneSearchPage({super.key});

  @override
  State<GemStoneSearchPage> createState() => _GemStoneSearchPageState();
}

class _GemStoneSearchPageState extends State<GemStoneSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(index: 2,),
    );
  }
}