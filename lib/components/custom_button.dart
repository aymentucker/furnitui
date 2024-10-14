import 'package:flutter/material.dart';
import 'package:furnitui/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isFilled;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.isFilled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isFilled ?  MyColors.primaryColor : Colors.transparent, 
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isFilled ?  MyColors.primaryColor :Colors.white),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color:  Colors.white, 
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
