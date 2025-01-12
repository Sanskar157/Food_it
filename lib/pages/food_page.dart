import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:food_it/components/my_button.dart";
import "package:food_it/models/food.dart";
import "package:food_it/models/restaurant.dart";
import "package:provider/provider.dart";

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};
  FoodPage({
    super.key,
    required this.food,
  }) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Food Image
                Container(
                  height: 380,
                  child: Image.asset(
                    widget.food.imagePath,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                    top: 25,
                    bottom: 25,
                  ),
                  child: Column(children: [
                    //Food Name
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    //Food price
                    Text(
                      "₹ ${widget.food.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Food description
                    Text(
                      widget.food.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //addons

                    Text(
                      "Add-ons",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: widget.food.availableAddons.length,
                        itemBuilder: ((context, index) {
                          Addon addon = widget.food.availableAddons[index];
                          return CheckboxListTile(
                              title: Text(
                                addon.name,
                              ),
                              subtitle: Text(
                                "₹ ${widget.food.price.toString()}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              });
                        })),
                  ]),
                ),

                MyButton(
                  text: "Add to cart",
                  onTap: () => addToCart(widget.food, widget.selectedAddons),
                ),
              ],
            ),
          ),
        ),

        //backbutton
        SafeArea(
          child: Opacity(
            opacity: 0.5,
            child: Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new))),
          ),
        ),
      ],
    );
  }
}
