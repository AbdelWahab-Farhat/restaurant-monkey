import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/blocs/food_details_bloc.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/buttons.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'),),
      body: BlocBuilder<FoodDetailsBloc, FoodDetailsState>(
        builder: (context, state) {
          if ( state is FoodCDetailsChangedState) {
            List<Food> foods = state.cart.userCartFoods!;
            if (foods.isEmpty) {
              return const Center(child: Text('No Items Yet',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: mainColor),),);
            }
            return Column(
              children: [
                SizedBox(height: 10,),
                ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Food food = foods[index];
                    print(food.image);
                    return Container(
                      margin: const EdgeInsets.only(left: 21, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: SizeConfig.screenWidth,
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Image.network(
                              food.image,
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.title,
                                  style: const TextStyle(
                                    color: mainColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      food.foodCategory.name,
                                      style: const TextStyle(
                                        color: subColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: compColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      food.generalCategory.name,
                                      style: const TextStyle(
                                        color: subColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth!/1.55,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'lib/assets/icons/star1.png',
                                        width: 15,
                                        height: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        food.rate.toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: compColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            "Total: \$${(food.price * food.quantity).toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              color: mainColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "quantity: ${(food.quantity).toStringAsFixed(0)}",
                                            style: const TextStyle(
                                              color: subColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                               SizedBox(
                                   width: SizeConfig.screenWidth!/3.5,
                                   height: 40,
                                   child: CustomOutlinedButton(title: 'remove Item',
                                   onPressed: () {
                                     context.read<FoodDetailsBloc>().add(RemoveFromCartEvent(food: food));
                                   },))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: CustomFilledButton(title: 'total Price is \$${state.cart.countTotalPrice(foods).toStringAsFixed(0)}'),
                 ),
              ],
            );

          }
          else return SizedBox();
        },
      ),
    );
  }
}
