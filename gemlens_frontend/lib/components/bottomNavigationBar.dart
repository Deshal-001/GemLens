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
      height: 60,
      backgroundColor: Colors.transparent,
      color: Colors.blueGrey,
      buttonBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      index: index == null ? 0 : index,     
      items: const <Widget>[
        Icon(Icons.home, color: Colors.black,),
        Icon(Icons.camera, color: Colors.black,),
        Icon(Icons.search,color: Colors.black,),
       
      ],
      onTap: (index) {
        //Handle button tap
        switch(index) {
          case 0:
            Navigator.pushNamed(context, '/menu');
            break;
          case 1:
            Navigator.pushNamed(context, '/scan');
            break;
          case 2:
            Navigator.pushNamed(context, '/search');
            break;
         
        }
      },
    );
  }
}