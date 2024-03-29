import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GemStoneList extends StatelessWidget {
  const GemStoneList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          Image.asset("assets/icons/gem.png", width: 100,),
          
          Text("Ruby", style: GoogleFonts.abhayaLibre(fontSize: 40, color: Colors.red),),
        ],),
      ),
    );
  }
}