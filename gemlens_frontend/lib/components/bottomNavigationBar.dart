import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gemlens_frontend/themes/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  const CustomBottomNavigationBar({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: primaryColor,
      animationDuration: const Duration(milliseconds: 300),
      index: index == null ? 0 : index,     
      items: const <Widget>[
        Icon(Icons.home, color: Colors.white,),
        Icon(Icons.camera, color: Colors.white,),
        Icon(Icons.search,color: Colors.white,),
        
      ],
      onTap: (index) {
        //Handle button tap
        if (index == 0) {
          Navigator.pushNamed(context, '/menu');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/scan');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/search');
        }
        
    
      },
    );
  }
}
