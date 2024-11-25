import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furnitui/screens/checkout.dart';
import 'package:furnitui/screens/favorites.dart';
import 'package:furnitui/widgets/drawer_widget.dart';
import 'package:furnitui/widgets/category_chip_widget.dart';
import 'package:furnitui/widgets/product_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;

  // Categories
  final List<String> _categories = [
    "All",
    "Chair",
    "Table",
    "Office Desk",
    "Dining Set",
    "Coffee Table"
  ];
  String _selectedCategory = "All";

  // Products
  final List<Map<String, dynamic>> _products = [
    {
      "name": "Office Chair",
      "category": "Chair",
      "price": 199.00,
      "image": "assets/images/chair.png",
      "hasDiscount": false
    },
    {
      "name": "Dining Table",
      "category": "Table",
      "price": 149.00,
      "image": "assets/images/chair.png",
      "hasDiscount": true,
      "discountLabel": "-15%"
    },
    {
      "name": "Office Desk",
      "category": "Office Desk",
      "price": 249.00,
      "image": "assets/images/chair2.png",
      "hasDiscount": false
    },
    {
      "name": "Dining Set",
      "category": "Dining Set",
      "price": 299.00,
      "image": "assets/images/chair.png",
      "hasDiscount": false
    },
    {
      "name": "Coffee Table",
      "category": "Coffee Table",
      "price": 99.00,
      "image": "assets/images/chair2.png",
      "hasDiscount": true,
      "discountLabel": "-10%"
    },
    {
      "name": "Armchair",
      "category": "Chair",
      "price": 89.00,
      "image": "assets/images/chair.png",
      "hasDiscount": false
    },
  ];

   // Add a flag for image position in each category
  final Map<String, Map<String, dynamic>> _banners = {
    "All": {
      "image": "assets/images/chair.png",
      "text": "Get your\nSpecial sale\nup to 50%",
      "color": Colors.orange.shade50,
      "imageOnRight": false, // Image position
    },
    "Chair": {
      "image": "assets/images/chair.png",
      "text": "Stylish Chairs\nSpecial Discounts",
      "color": Colors.blue.shade50,
      "imageOnRight": true,
    },
    "Table": {
      "image": "assets/images/chair.png",
      "text": "Modern Tables\nUp to 40% Off",
      "color": Colors.green.shade50,
      "imageOnRight": false,
    },
    "Office Desk": {
      "image": "assets/images/chair.png",
      "text": "Ergonomic Desks\nFor Productivity",
      "color": Colors.purple.shade50,
      "imageOnRight": true,
    },
    "Dining Set": {
      "image": "assets/images/chair.png",
      "text": "Perfect Dining\nSets for Home",
      "color": Colors.red.shade50,
      "imageOnRight": false,
    },
    "Coffee Table": {
      "image": "assets/images/chair.png",
      "text": "Elegant Coffee\nTables On Sale",
      "color": Colors.yellow.shade50,
      "imageOnRight": true,
    },
  };

  // Get banner data for the selected category
  Map<String, dynamic> _getBannerData() {
    return _banners[_selectedCategory] ?? _banners["All"]!;
  }


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 0 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Filter products based on selected category
  List<Map<String, dynamic>> _filteredProducts() {
    if (_selectedCategory == "All") {
      return _products;
    }
    return _products
        .where((product) => product["category"] == _selectedCategory)
        .toList();
  }

  // Get banner data for the selected category

  @override
  Widget build(BuildContext context) {
  final bannerData = _getBannerData();
    final bool imageOnRight = bannerData["imageOnRight"];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _isScrolled ? const Color(0xFFDA7635) : Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Furnit",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "Ui",
              style: TextStyle(
                  color: _isScrolled ? Colors.white : const Color(0xFFDA7635),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.solidHeart,
                color: _isScrolled ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()));
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.cartShopping,
                color: _isScrolled ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()));
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.bars,
              color: _isScrolled ? Colors.white : Colors.black),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Row(
                  children: _categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: categoryChip(
                        category,
                        category == _selectedCategory,
                        () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

           // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bannerData["color"],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: imageOnRight
                      ? [
                          // Text and Button Column
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bannerData["text"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDA7635),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text(
                                        "Shop Now",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Product Image
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              bannerData["image"],
                              height: 150,
                            ),
                          ),
                        ]
                      : [
                          // Product Image
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              bannerData["image"],
                              height: 150,
                            ),
                          ),

                          // Text and Button Column
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bannerData["text"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDA7635),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text(
                                        "Shop Now",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),

            // Product Grid
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _filteredProducts().length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts()[index];
                  return productCard(context, product, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
