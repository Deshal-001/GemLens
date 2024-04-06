import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/helpWidget.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:gemlens_frontend/themes/fonts.dart';
import 'package:google_fonts/google_fonts.dart';



class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     //   backgroundColor: Colors.white, // Changed AppBar color to white
        elevation: 0,
        title: Text(
          "Help & Support",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Changed text color to black
          ),
        ),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(
      //  index: 0,
      //),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: CarouselSlider(
                    items: [0, 1, 2, 3].map((i) {
                      return HelpWidget(i: i);
                    }).toList(),
                    options: CarouselOptions(
                      height: 500,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

