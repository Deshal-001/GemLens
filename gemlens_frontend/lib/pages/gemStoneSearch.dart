import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/gemstoneList.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GemStoneSearchPage extends StatefulWidget {
  const GemStoneSearchPage({super.key});

  @override
  State<GemStoneSearchPage> createState() => _GemStoneSearchPageState();
}

class _GemStoneSearchPageState extends State<GemStoneSearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar:const CustomBottomNavigationBar(index: 2,),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                
                Spacer(),
                Icon(Icons.search, color: Colors.red, size: 40,),
              ],
            ),
            
          ),

          GemStoneList(),
          GemStoneList(),
          
        ],
      ),
    );
  }
}

