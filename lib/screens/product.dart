import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnitui/components/custom_button.dart';
import 'package:furnitui/utils/colors.dart';


class ProductScreen extends StatefulWidget {
  final String imageTag; // Unique tag for the Hero widget
  final Color selectedColor; // You can pass additional data like selectedColor if needed

  const ProductScreen({
    Key? key,
    required this.imageTag,
    required this.selectedColor,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Map for image and corresponding color
  final Map<Color, String> colorImageMap = {
    Colors.brown: 'assets/images/product1.png',
    Colors.black54: 'assets/images/product2.png',
    Colors.grey: 'assets/images/product3.png',
  };

  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfaf4ef), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Furnit",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Ui",
              style: TextStyle(
                color: Color(0xFFDA7635),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.circleArrowLeft, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.cartShopping, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Hero animation
            Container(
              color: const Color(0xFFfaf4ef), // Light beige background for product area
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Hero(
                    tag: widget.imageTag, // Use the same tag passed from HomeScreen
                    child: Image.asset(
                      colorImageMap[selectedColor]!,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
           
            // Color Options
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 100.0, end: 100.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: MyColors.primaryColor),
                  color: const Color.fromARGB(165, 247, 237, 228),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Color",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            _colorOption(Colors.brown, selectedColor == Colors.brown),
                            _colorOption(Colors.black54, selectedColor == Colors.black54),
                            _colorOption(Colors.grey, selectedColor == Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Space between color option and details
            
            // Product Details Section
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Colors.white, // White background for details section
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 5),
                        Text(
                          "4.8",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Title and Pricing
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Modern Elegance Bookcase Shelf.",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "\$499.00",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "\$529.00",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[100],
                    ),
                    const SizedBox(height: 10),

                    // Description Section
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Elevate your space with the Modern Elegance Bookcase Shelf. This versatile piece offers ample storage with sleek, open shelves, perfect for displaying books and decor. Crafted from high-quality engineered wood, its clean lines and contemporary design add style to any room.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[100],
                    ),
                    const SizedBox(height: 10),

                    // Material Information
                    const Text(
                      "Material:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Engineered wood with a laminate finish",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: 
          // Buy Now Button
          CustomButton(
            text: "Buy Now",
            isFilled: true,
            onPressed: () {},
          ),
      ),
    );
  }

  Widget _colorOption(Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color; // Update the selected color
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: CircleAvatar(
          radius: isSelected ? 12 : 10,
          backgroundColor: color,
          child: isSelected
              ? const CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
