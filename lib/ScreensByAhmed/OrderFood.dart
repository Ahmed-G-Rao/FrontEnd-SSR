import 'package:flutter/material.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final List<MenuItem> _menuItems = [
    MenuItem(name: 'Burger', price: 5.99),
    MenuItem(name: 'Pizza', price: 8.99),
    MenuItem(name: 'Fries', price: 2.99),
    MenuItem(name: 'Salad', price: 4.99),
  ];

  final Map<String, int> _orderItems = {};

  double get totalAmount {
    return _menuItems.fold(0,
        (total, item) => total + (item.price * (_orderItems[item.name] ?? 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final itemName = item.name;
                final itemCount = _orderItems[itemName] ?? 0;

                return ListTile(
                  title: Text('$itemName x $itemCount'),
                  subtitle:
                      Text('\$${(item.price * itemCount).toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _orderItems.update(itemName, (value) => value + 1,
                                ifAbsent: () => 1);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (itemCount > 1) {
                              _orderItems.update(
                                  itemName, (value) => value - 1);
                            } else {
                              _orderItems.remove(itemName);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Flexible(
            flex: 4,
            child: Column(
              children: [
                const Text('Order Summary',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: _orderItems.length,
                    itemBuilder: (context, index) {
                      final itemName = _orderItems.keys.toList()[index];
                      final itemCount = _orderItems[itemName]!;
                      final itemPrice = _menuItems
                          .firstWhere((item) => item.name == itemName)
                          .price;

                      return ListTile(
                        title: Text('$itemName x $itemCount'),
                        subtitle: Text(
                            '\$${(itemPrice * itemCount).toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _orderItems.remove(itemName);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total: \$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Place Order'),
                    onPressed: () {
                      // TODO: Implement order placement logic
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}
