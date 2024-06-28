import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/cubits/food_cubit/food_cubit.dart';
import 'package:mealmoneky/model/enums.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/menu/menu_detail_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/fetching_methods.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';
import 'package:mealmoneky/widgets/custom_searchbar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CustomAppBar(title: 'Menu'),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomSearchBar(),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 97,
                    height: 520,
                    decoration: const BoxDecoration(
                        color: compColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(38),
                            bottomRight: Radius.circular(38))),
                  ),
                ),
                BlocBuilder<FoodCubit, FoodState>(
                  builder: (context, state) {
                    if (state is FoodChangedState) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          manuItem(context: context, title: 'Fast-Foods', foods: state.foods,type:FoodCategory.fastFood),
                          const SizedBox(
                            height: 10,
                          ),
                          manuItem(context: context,title:'Beverages',foods:state.foods,type: FoodCategory.beverages),
                          const SizedBox(
                            height: 10,
                          ),
                          manuItem(context:context, title:'Desserts', foods:state.foods,type: FoodCategory.desserts),
                          const SizedBox(
                            height: 10,
                          ),
                          manuItem(context: context, title:'Main Courses', foods:state.foods,type: FoodCategory.mainCourse),
                          const SizedBox(
                            height: 10,
                          ),
                          manuItem(context:context ,title: 'Appetizers', foods: state.foods,type: FoodCategory.appetizers),
                        ],
                      );
                    }
                    else {
                      return Center(child: Text('Error Fatch Data'),);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget manuItem({required BuildContext context, required String title , required List<Food> foods , required FoodCategory type}) {
    List<Food> filteredItems = filterFoodCategory(foods, type);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDetailPage(food: filteredItems, hasGenCategory: false,),)),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      height: MediaQuery.sizeOf(context).height / 9,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: bigTitleStyle(),
                              ),
                              Text(
                                '${filteredItems.length} Items',
                                style: subTitleStyle(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      'lib/assets/images/food.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0),
                  heightFactor: 2.8,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        'lib/assets/icons/right-arrow.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
