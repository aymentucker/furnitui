import 'package:flutter/material.dart';

Widget categoryChip(String label, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {},
      backgroundColor: isSelected ? const Color(0xFFDA7635) : Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      selectedColor: const Color(0xFFDA7635),
    ),
  );
}
