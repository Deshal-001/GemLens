import 'package:flutter/material.dart';
import 'package:gemlens_frontend/themes/colors.dart';


class MenuButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData icon;
  final Color color;

  const MenuButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(text, style: TextStyle(color: Colors.white)),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
