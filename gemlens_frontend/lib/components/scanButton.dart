import 'package:flutter/material.dart';

import '../themes/colors.dart';

class ScanButton extends StatelessWidget {
  final void Function() onTap;
  final String icon;
   ScanButton({
    super.key,
    required this.onTap,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
      
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
                  child:  Center(
      child: Image.asset(icon, height: 50, width: 50,),
                  ),
      ),
    );
  }
}
