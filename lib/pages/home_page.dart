import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mealmoneky/blocs/food_details_bloc.dart';
import 'package:mealmoneky/cubits/account_user_cubit/account_user_cubit.dart';
import 'package:mealmoneky/cubits/food_cubit/food_cubit.dart';
import 'package:mealmoneky/model/account_user.dart';
import 'package:mealmoneky/model/enums.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/detail_page.dart';
import 'package:mealmoneky/pages/menu/menu_detail_page.dart';
import 'package:mealmoneky/pages/view_all_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/fetching_methods.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';
import 'package:mealmoneky/widgets/custom_searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AccountUserCubit>().getUser();
    context.read<FoodCubit>().getFood();
    context.read<FoodDetailsBloc>().initFoodCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: BlocBuilder<AccountUserCubit, AccountUserState>(
                  builder: (context, state) {
                    if (state is AccountUserChangedState) {
                      if (state.accountUser != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppBar(title: 'Good morning!'),
                            Padding(
                              padding: const EdgeInsets.only(left:21),
                              child: Text('\t\t${state.accountUser!.name.capitalizeFirst}',style: TextStyle(color: compColor,fontSize: 20),),
                            )
                          ],
                        );
                        }
                      }
                      return CustomAppBar(title: 'Good morning !');
                  },
                ),
              ),
              const SizedBox(height: 20),
              const CustomSearchBar(),
              const SizedBox(height: 20),
              _buildGeneralCategory(context),
              const SizedBox(height: 20),
              _containerHomeBox('Popular foods', () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewAllPage(
                        title: 'Popular Food',
                        foods: context.read<FoodCubit>().foods);
                  },
                ));
              }),
              const SizedBox(height: 20),
              BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodChangedState) {
                    return _restaurantsContainerPopularFoods(
                        context, state.foods);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 20),
              Divider(
                color: subColor.withOpacity(0.2),
              ),
              _containerHomeBox('Most Popular Food', () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewAllPage(
                        title: 'Most Popular Food',
                        foods:
                            mostPopularFood(context.read<FoodCubit>().foods));
                  },
                ));
              }),
              const SizedBox(height: 20),
              BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodChangedState) {
                    return _restaurantsContainerMostFood(
                        context, mostPopularFood(state.foods));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _containerHomeBox('Recent Items', () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewAllPage(
                        title: 'Recent Items',
                        foods: resentItems(context.read<FoodCubit>().foods));
                  },
                ));
              }),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodChangedState) {
                    return _restaurantsContainerRecentItems(
                        context, resentItems(state.foods));
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

  Widget _containerHomeBox(String title, void Function()? onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: mainColor),
          ),
          const Spacer(),
          // TODO: ADD VIEW ALL METHOD
          GestureDetector(
            onTap: onTap,
            child: const Text(
              'View all',
              style: TextStyle(fontSize: 14, color: compColor),
            ),
          )
        ],
      ),
    );
  }

//horizontal
  Widget _restaurantsContainerRecentItems(
      BuildContext context, List<Food> foods) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Food food = foods[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food: food),)),
          child: Container(
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
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
                          const SizedBox(
                            width: 5,
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
    );
  }

  Widget _restaurantsContainerMostFood(BuildContext context, List<Food> foods) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height / 4,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Food food = foods[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food: food),)),
            child: Container(
              margin: const EdgeInsets.only(left: 20, bottom: 10),
              width: width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          food.image,
                          height: height / 7.5,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
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
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatCategory(food.foodCategory),
                            style: const TextStyle(
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
                            formatCategory(food.generalCategory),
                            style: const TextStyle(
                              color: subColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '4.9',
                            style: TextStyle(
                              color: compColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'lib/assets/icons/star1.png',
                            width: 15,
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _restaurantsContainerPopularFoods(
      BuildContext context, List<Food> foods) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          Food food = foods[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food:food),)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Image.network(
                    food.image,
                    height: height / 3.8,
                    width: width,
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

  // null for now only
  Widget _buildGeneralCategory(BuildContext context) {
    List<GeneralCategory> categories =
        GeneralCategory.values.map((item) => item).toList();
    List<String> categoriesImages = [
      'lib/assets/images/offers.png',
      'lib/assets/images/sriLankan.png',
      'lib/assets/images/italian.png',
      'lib/assets/images/indian.png',
    ];

    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String item = categories[index].name;
          String imageItem = categoriesImages[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDetailPage(food: filterGeneralCate(context.read<FoodCubit>().foods, categories[index]), hasGenCategory: true,),)),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Image.asset(imageItem, width: 80, height: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
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
