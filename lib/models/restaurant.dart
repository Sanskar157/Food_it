import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_it/models/cart_item.dart';
import 'package:food_it/models/food.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //burgers
    Food(
        name: "Classic Cheeseburger",
        description:
            "A delicious patty with melted cheddar cheese, lettuce, tomato and a hint of onion and pickle",
        imagePath: "assets/burgers/download.jpg",
        price: 159,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 20),
          Addon(name: "French Fries and Coke", price: 100),
          Addon(name: "Extra Chicken", price: 80),
        ]),

    Food(
        name: "Avocado Bun Burger",
        description: "Tasty burger with low carbs ,Great for fitness freaks",
        imagePath: "assets/burgers/avocado-bun-burgers-11a-700x567.jpg",
        price: 159,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra avocado", price: 40),
          Addon(name: "French Fries and Coke", price: 100),
          Addon(name: "Extra Veggies", price: 80),
        ]),

    Food(
        name: "Spooky Burger",
        description: "Burgers for kids",
        imagePath: "assets/burgers/images.jpg",
        price: 159,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "French Fries and Coke", price: 100),
          Addon(name: "Extra Veggies", price: 80),
        ]),

    //salads
    Food(
        name: "Italian Salad",
        description:
            "An Italian salad typically features fresh ingredients like tomatoes, mozzarella cheese, basil, and olives, drizzled with olive oil and balsamic vinegar for a flavorful and refreshing dish",
        imagePath: "assets/salads/Big-Italian-Salad-760x983.jpg",
        price: 159,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "French Fries and Coke", price: 100),
          Addon(name: "Extra Veggies", price: 80),
        ]),

    Food(
        name: "Greek Yogurt Chicken Salad ",
        description:
            "Greek yogurt chicken salad combines tender chunks of chicken with Greek yogurt, along with crisp vegetables and flavorful herbs and spices",
        imagePath: "assets/salads/Greek-Yogurt-Chicken-Salad.jpg",
        price: 159,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "French Fries and Coke", price: 200),
          Addon(name: "Extra Chicken", price: 100),
        ]),

    Food(
        name: "Healthy Cobb Salad",
        description:
            "A Cobb salad is a mix of greens topped with grilled chicken, bacon, hard-boiled eggs, avocado, tomatoes, blue cheese, and vinaigrette, providing a hearty and flavorful meal.",
        imagePath: "assets/salads/healthy-cobb-salad-steps-sq-026.jpg",
        price: 159,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "French Fries and Coke", price: 200),
          Addon(name: "Extra Chicken", price: 100),
        ]),

    Food(
        name: "Grilled Chicken Salad",
        description:
            "A grilled chicken salad features tender, charred chicken breast atop a bed of crisp lettuce, paired with an array of fresh vegetables, fruits, nuts, and a tangy dressing, creating a satisfying and nutritious meal.",
        imagePath: "assets/salads/Greek-Yogurt-Chicken-Salad.jpg",
        price: 159,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "French Fries and Coke", price: 200),
          Addon(name: "Extra Chicken", price: 100),
        ]),

    //sides
    Food(
        name: "Garlicbread ",
        description:
            "Garlic bread is sliced bread topped with garlic butter, toasted until crispy, serving as a flavorful side dish.",
        imagePath: "assets/sides/garlicbread.jpg",
        price: 120,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra Butter", price: 135),
        ]),

    Food(
        name: "French Fries",
        description:
            "French fries are crispy strips of deep-fried potatoes served with sauce and mayonnaise",
        imagePath: "assets/sides/Homemade-French-Fries_8.jpg",
        price: 100,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Large size", price: 80),
        ]),

    Food(
        name: "Mexican Corn",
        description:
            "Mexican corn is corn on the cob with mayo, cheese, chili powder, lime, and cilantro",
        imagePath: "assets/sides/Mexican-street-corn-elotes-on-plate.jpg",
        price: 100,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra spicy", price: 30),
        ]),

    Food(
        name: "Cheesy French Fries",
        description:
            "French fries are crispy strips of deep-fried potatoes with cheese",
        imagePath: "assets/sides/Screen+Shot+2022-07-10+at+11.12.30+AM.jpg",
        price: 120,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra cheese", price: 20),
        ]),

    //drinks
    Food(
        name: "Coke",
        description: "Chilled and refreshing",
        imagePath: "assets/drinks/coke.jpg",
        price: 40,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Large Coke", price: 60),
        ]),

    Food(
        name: "Virgin Mojito",
        description:
            "A tasty drink made with muddled mint leaves, lime juice, simple syrup, and soda water",
        imagePath: "assets/drinks/mojito.webp",
        price: 40,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Large size", price: 60),
        ]),
  ];
  //  getters

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  // operations

  //user cart
  final List<CartItem> _cart = [];
  //delivery address
  String _deliveryAddress = 'Dubai';

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if food items are the same
      bool isSameFood = item.food == food;
      //check if the list of selected addons are the same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(
        food: food,
        selectedAddons: selectedAddons,
      ));
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (_cart[cartIndex] != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
      notifyListeners();
    }
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  // Helpers

  //generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} X ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");

      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln('----------');
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "₹${price.toStringAsFixed(2)}";
  }

  // format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }

  //update delivery address
  void updateDelAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }
}
