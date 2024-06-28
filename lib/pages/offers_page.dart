import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/cubits/food_cubit/food_cubit.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/detail_page.dart';
import 'package:mealmoneky/pages/view_all_page.dart';

import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/fetching_methods.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: CustomAppBar(
                  title: 'Latest Offers',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Find discounts, Offers special\nmeals and more!',
                  style: subTitleStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: CustomFilledButton(
                  title: 'Check All  Offers',
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllPage(
                            title: 'Offers',
                            foods: offerFoods(context.read<FoodCubit>().foods)),
                      )),
                  buttonWidth: MediaQuery.sizeOf(context).width / 2.7,
                  buttonHeight: 29,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodChangedState) {
                    return _offerRestaurantsBuilder(
                        context, offerFoods(state.foods));
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _offerRestaurantsBuilder(BuildContext context, List<Food> foods) {


    return SizedBox(
      width: SizeConfig.screenWidth,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          Food food = foods[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food: food),)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Image.network(
                    food.image,
                    height: SizeConfig.screenHeight! / 3.8,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.cover,
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
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/icons/star1.png',
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              food.rate.toStringAsFixed(1),
                              style: const TextStyle(
                                color: compColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Café',
                              style: TextStyle(
                                color: subColor,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
