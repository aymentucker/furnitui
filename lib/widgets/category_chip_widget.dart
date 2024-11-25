import 'package:flutter/material.dart';

Widget categoryChip(String label, bool isSelected, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          onTap(); // Call the callback to update the state in the parent
        }
      },
      backgroundColor: isSelected ? const Color(0xFFDA7635) : Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      selectedColor: const Color(0xFFDA7635),
    ),
  );
}
