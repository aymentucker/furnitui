import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:furnitui/utils/colors.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0; // To keep track of the step
  bool isCreditSelected = true; // Track if the credit card is selected
  String selectedAddress = "Home Address"; // Initially selected address

  // Variables for credit card input
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // Form keys
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cardFormKey = GlobalKey<FormState>();

  // Controllers for address form
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.primaryColor,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.primaryColor,
                MyColors.primaryColor.withOpacity(0.9)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Step indicator
            _buildStepIndicator(),
            Expanded(
              child: _buildStepContent(),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  /// Step content

  IconData _getStepIcon(int step) {
    switch (step) {
      case 0:
        return Icons.shopping_cart;
      case 1:
        return Icons.local_shipping;
      case 2:
        return Icons.payment;
      default:
        return Icons.check_circle;
    }
  }

  // Custom step indicator using TimelineTile
  Widget _buildStepIndicator() {
    return Container(
      height: 80,
      child: Row(
        children: [
          _buildStepTile(
            title: 'Cart',
            isFirst: true,
            isLast: false,
            isCurrent: currentStep == 0,
            isCompleted: currentStep > 0,
            index: 0,
          ),
          _buildStepTile(
            title: 'Shipping',
            isFirst: false,
            isLast: false,
            isCurrent: currentStep == 1,
            isCompleted: currentStep > 1,
            index: 1,
          ),
          _buildStepTile(
            title: 'Payment',
            isFirst: false,
            isLast: true,
            isCurrent: currentStep == 2,
            isCompleted: currentStep > 2,
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStepTile({
    required String title,
    required bool isFirst,
    required bool isLast,
    required bool isCurrent,
    required bool isCompleted,
    required int index, // Added index parameter
  }) {
    return Expanded(
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isCompleted || isCurrent
              ? MyColors.primaryColor
              : Colors.grey.shade300,
          thickness: 2,
        ),
        afterLineStyle: LineStyle(
          color: isCompleted ? MyColors.primaryColor : Colors.grey.shade300,
          thickness: 2,
        ),
        indicatorStyle: IndicatorStyle(
          height: 30,
          width: 30,
          indicator: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isCurrent
                  ? MyColors.primaryColor
                  : Colors.grey.shade300,
              boxShadow: [
                if (isCurrent || isCompleted)
                  BoxShadow(
                    color: MyColors.primaryColor.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 20)
                  : Icon(
                      _getStepIcon(index),
                      color: Colors.white,
                      size: 20,
                    ),
            ),
          ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isCurrent ? MyColors.primaryColor : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the content for each step
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildCartStep();
      case 1:
        return _buildShippingStep();
      case 2:
        return _buildPaymentStep();
      default:
        return Container();
    }
  }

  // Bottom navigation buttons
  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  currentStep -= 1;
                });
              },
              child: Text(
                'Back',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (currentStep < 2) {
                setState(() {
                  currentStep += 1;
                });
              } else {
                // Place order action
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: MyColors.primaryColor.withOpacity(0.4),
            ),
            child: Text(
              currentStep < 2 ? 'Next' : 'Place Order',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Cart Step UI with better spacing and custom colors
  Widget _buildCartStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCartItem('Minimalist Chair', 'Black', 2, 854.08,
              'assets/images/product1.png'),
          SizedBox(height: 16),
          _buildCartItem(
              'Modern Lamp', 'White', 1, 120.00, 'assets/images/product2.png'),
          SizedBox(height: 16),
          _buildCartSummary(),
        ],
      ),
    );
  }

  Widget _buildCartItem(String title, String subtitle, int quantity,
      double price, String imageAsset) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageAsset,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12), // Spacing between image and text

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.grey),
                  onPressed: () {
                    // Decrease quantity logic here
                  },
                ),
                Text(
                  quantity.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: MyColors.primaryColor),
                  onPressed: () {
                    // Increase quantity logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary() {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              '\$974.08',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              '\$20.00',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$994.08',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  // Step 2: Shipping Step UI with improved address card design
  Widget _buildShippingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildAddressCard(
              'Home Address', '269-444-6853', 'Road Number 5649 Akali', true),
          _buildAddressCard('Office Address', '259-444-6853',
              '1578 H Blog Shekh Para', false),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              _showAddressForm(
                  context, 'Add Address'); // Show form for adding address
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "Add Address",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: MyColors.primaryColor.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  // Address Card with a cleaner, professional look
  Widget _buildAddressCard(
      String title, String phone, String address, bool isSelected) {
    return Card(
      color: isSelected ? MyColors.primaryColor : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Radio(
          value: title,
          groupValue: selectedAddress,
          activeColor: isSelected ? Colors.white : Colors.black,
          onChanged: (value) {
            setState(() {
              selectedAddress = value.toString();
            });
          },
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          '$phone\n$address',
          style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.black),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon:
              Icon(Icons.edit, color: isSelected ? Colors.white : Colors.black),
          onPressed: () {
            _showAddressForm(context, 'Edit Address');
          },
        ),
      ),
    );
  }

  // Step 3: Payment Method Step UI with custom radio button and icon alignment
  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: Radio(
              value: true,
              groupValue: isCreditSelected,
              activeColor: MyColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  isCreditSelected = true;
                });
              },
            ),
            title: Text(
              'Credit or Debit Card',
              style: GoogleFonts.poppins(),
            ),
            trailing:
                Image.asset('assets/images/visa_mastercard.png', height: 30),
          ),
          if (isCreditSelected)
            _buildCardForm(), // Show card form if credit is selected
          ListTile(
            leading: Radio(
              value: false,
              groupValue: isCreditSelected,
              activeColor: MyColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  isCreditSelected = false;
                });
              },
            ),
            title: Text(
              'PayPal',
              style: GoogleFonts.poppins(),
            ),
            trailing: Image.asset('assets/images/paypal.png', height: 30),
          ),
        ],
      ),
    );
  }

  // Form for entering card details when Credit or Debit Card is selected
  Widget _buildCardForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _cardFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Preview
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardNumber.isEmpty
                        ? '**** **** **** ****'
                        : cardNumber.replaceAll(RegExp(r'\d(?=\d{4})'), '*'),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expiry Date',
                        style: GoogleFonts.poppins(color: Colors.grey.shade200),
                      ),
                      Text(
                        'CVV',
                        style: GoogleFonts.poppins(color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expiryDate.isEmpty ? 'MM/YY' : expiryDate,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cvvCode.isEmpty
                            ? '***'
                            : cvvCode.replaceAll(RegExp(r'\d'), '*'),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    cardHolderName.isEmpty
                        ? 'Card Holder Name'
                        : cardHolderName,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Card Number
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                labelStyle: GoogleFonts.poppins(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: MyColors.primaryColor),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 19,
              inputFormatters: [
                // Add input formatter to format the card number
                CardNumberInputFormatter(),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter card number';
                } else if (value.replaceAll(' ', '').length != 16) {
                  return 'Card number must be 16 digits';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
            ),
            SizedBox(height: 16),
            // Expiry Date and CVV
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      labelStyle: GoogleFonts.poppins(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyColors.primaryColor),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      // Add input formatter to format the expiry date
                      ExpiryDateInputFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expiry date';
                      } else if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                          .hasMatch(value)) {
                        return 'Enter expiry date in MM/YY format';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                     decoration: InputDecoration(
                         labelText: 'CVV',
                      hintText: 'XXX',
                      labelStyle: GoogleFonts.poppins(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyColors.primaryColor),
                      ),
                    ),
               
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CVV';
                      } else if (value.length != 3) {
                        return 'CVV must be 3 digits';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        cvvCode = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Card Holder Name
            TextFormField(
                 decoration: InputDecoration(
                     labelText: 'Card Holder Name',
                      labelStyle: GoogleFonts.poppins(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyColors.primaryColor),
                      ),
                    ),
            
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter card holder name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  cardHolderName = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to display a bottom sheet for adding or editing the address
  void _showAddressForm(BuildContext context, String action) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To make modal full screen on keyboard open
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Form(
            key: _addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: streetController,
                  decoration: InputDecoration(
                    labelText: 'Street Address',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_addressFormKey.currentState!.validate()) {
                      Navigator.pop(
                          context); // Close the bottom sheet after saving
                    }
                  },
                  child: const Text('Save Address'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: MyColors.primaryColor.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += ' ';
      formatted += digitsOnly[i];
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    if (digitsOnly.length >= 2) {
      formatted = digitsOnly.substring(0, 2) + '/';
      if (digitsOnly.length > 2) {
        formatted += digitsOnly.substring(2, digitsOnly.length);
      }
    } else {
      formatted = digitsOnly;
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
