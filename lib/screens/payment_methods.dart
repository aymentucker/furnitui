import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnitui/utils/colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, String>> _paymentMethods = [
    {"title": "Visa **** 1234", "iconPath": "assets/icons/visa.png"},
    {"title": "MasterCard **** 5678", "iconPath": "assets/icons/mastercard.png"},
    {"title": "PayPal john.doe@gmail.com", "iconPath": "assets/icons/paypal.png"},
  ];

  int _selectedIndex = 0; // Default selected payment method

  void _addPaymentMethod() {
    String? selectedType;
    String? cardNumber;
    String? expiryDate;
    String? cvv;
    String? email;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Add Payment Method",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dropdown for selecting payment type
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: "Payment Type"),
                    value: selectedType,
                    items: [
                      DropdownMenuItem(
                        value: "Visa",
                        child: Text("Visa"),
                      ),
                      DropdownMenuItem(
                        value: "MasterCard",
                        child: Text("MasterCard"),
                      ),
                      DropdownMenuItem(
                        value: "PayPal",
                        child: Text("PayPal"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  if (selectedType == "Visa" || selectedType == "MasterCard") ...[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        hintText: "e.g., 1234 5678 9012 3456",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        cardNumber = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Expiry Date",
                        hintText: "MM/YY",
                      ),
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {
                        expiryDate = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "CVV",
                        hintText: "e.g., 123",
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      onChanged: (value) {
                        cvv = value;
                      },
                    ),
                  ] else if (selectedType == "PayPal") ...[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "PayPal Email",
                        hintText: "e.g., john.doe@gmail.com",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedType == "PayPal" && email != null) {
                      setState(() {
                        _paymentMethods.add({
                          "title": "$selectedType $email",
                          "iconPath": "assets/icons/paypal.png",
                        });
                      });
                      Navigator.pop(context);
                    } else if ((selectedType == "Visa" || selectedType == "MasterCard") &&
                        cardNumber != null &&
                        expiryDate != null &&
                        cvv != null) {
                      setState(() {
                        _paymentMethods.add({
                          "title": "$selectedType **** ${cardNumber!.substring(cardNumber!.length - 4)}",
                          "iconPath": selectedType == "Visa"
                              ? "assets/icons/visa.png"
                              : "assets/icons/mastercard.png",
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Add",
                    style: GoogleFonts.poppins(color: MyColors.primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Payment Methods",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Add Payment Method Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addPaymentMethod,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: MyColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  "Add Payment Method",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Methods Section
            Text(
              "Your Payment Methods",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Payment Method List
            ..._paymentMethods.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> method = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPaymentMethodCard(
                  method["title"]!,
                  method["iconPath"]!,
                  isSelected: index == _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              );
            }).toList(),

            const SizedBox(height: 30),

            // Manage Section
            Text(
              "Manage",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildManageOption("Set Default Payment Method", Icons.settings, () {
              // Set Default Payment Method logic
            }),
            _buildManageOption("Remove Payment Method", Icons.delete, () {
              if (_paymentMethods.isNotEmpty) {
                setState(() {
                  _paymentMethods.removeAt(_selectedIndex);
                  _selectedIndex = 0; // Reset to first method
                });
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    String title,
    String iconPath, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.primaryColor.withOpacity(0.1) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? MyColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? MyColors.primaryColor : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: MyColors.primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildManageOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: MyColors.primaryColor),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
