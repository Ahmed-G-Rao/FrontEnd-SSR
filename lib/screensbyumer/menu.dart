import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final String description;
  final double price;

  MenuItem(this.name, this.description, this.price);
}

class MenuCategory {
  final String name;
  final List<MenuItem> items;

  MenuCategory(this.name, this.items);
}

class MenuScreenU extends StatefulWidget {
  const MenuScreenU({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreenU> {
  final List<MenuCategory> categories = [
    MenuCategory(
      'Appetizers',
      [
        MenuItem('Nachos', 'Tortilla chips with cheese and salsa', 6.99),
        MenuItem(
            'Wings', 'Spicy chicken wings with blue cheese dressing', 8.99),
        MenuItem('Fries', 'Crispy french fries with ketchup', 3.99),
      ],
    ),
    MenuCategory(
      'Entrees',
      [
        MenuItem('Burger', 'Juicy beef burger with lettuce and tomato', 10.99),
        MenuItem('Pasta', 'Spaghetti with marinara sauce and meatballs', 12.99),
        MenuItem('Steak', 'Grilled sirloin steak with mashed potatoes', 15.99),
      ],
    ),
    MenuCategory(
      'Desserts',
      [
        MenuItem(
            'Cheesecake', 'Creamy cheesecake with graham cracker crust', 5.99),
        MenuItem('Ice Cream', 'Vanilla ice cream with chocolate sauce', 3.99),
      ],
    ),
  ];

  int _selectedIndex = 0;

  List<Widget> _buildCategoryButtons() {
    return categories
        .map((category) => TextButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = categories.indexOf(category);
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: _selectedIndex == categories.indexOf(category)
                    ? Colors.white
                    : Colors.grey[700], backgroundColor: _selectedIndex == categories.indexOf(category)
                    ? Colors.blue
                    : Colors.transparent,
              ),
              child: Text(category.name),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Show cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildCategoryButtons(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories[_selectedIndex].items.length,
              itemBuilder: (context, index) {
                final item = categories[_selectedIndex].items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    // TODO: Add item to order
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
