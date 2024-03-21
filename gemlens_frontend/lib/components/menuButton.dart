import 'package:flutter/material.dart';
import 'package:gemlens_frontend/themes/colors.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData icon;
  const MenuButton({Key? key, required this.text, required this.onTap,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,style: TextStyle(color:  Colors.white),),
            const SizedBox(width: 15),    
            Icon( icon, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
