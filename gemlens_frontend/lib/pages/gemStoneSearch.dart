import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/gemStone.dart';
import 'package:gemlens_frontend/components/gemstoneList.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GemStoneSearchPage extends StatefulWidget {
  const GemStoneSearchPage({Key? key}) : super(key: key);

  @override
  State<GemStoneSearchPage> createState() => _GemStoneSearchPageState();
}

class _GemStoneSearchPageState extends State<GemStoneSearchPage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: const CustomBottomNavigationBar(index: 2),
    appBar: AppBar(
      leading: Icon(Icons.menu),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "GemLens",
        style: GoogleFonts.dmSerifDisplay(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(216, 23, 23, 0.78),
        ),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: gemstones.map((gemstone) {
                return GemStoneList(gemstone: gemstone);
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
}
