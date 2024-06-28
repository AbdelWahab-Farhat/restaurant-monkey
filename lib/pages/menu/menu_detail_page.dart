import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/detail_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';
import 'package:mealmoneky/widgets/custom_searchbar.dart';

class MenuDetailPage extends StatelessWidget {
  final List<Food> food;
  final bool hasGenCategory;
  const MenuDetailPage({super.key, required this.food, required this.hasGenCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            Padding(
               padding: const EdgeInsets.only(right: 20,left: 20),
               child: food.isEmpty?CustomAppBar(isHaveBackButton: true,):CustomAppBar(
                title: hasGenCategory?formatCategory(food.first.generalCategory):formatCategory(food.first.foodCategory),
                isHaveBackButton: true,
                           ),
             ),
            const SizedBox(
              height: 20,
            ),
            const CustomSearchBar(),
            const SizedBox(
              height: 20,
            ),
            if (food.isNotEmpty)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: food.length,
                itemBuilder: (context, index) {
                  return menuDetailItem(context, food[index]);
              },),
            )
            else
              const Center(child: Text('There is No Items In this Category.'),)
          ],
        ),
      ),
    );
  }
  
  Widget menuDetailItem(BuildContext context , Food food) {
    return  GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food: food),)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.9,
          decoration: BoxDecoration(

          ),
          child: Stack(
            children: [
              Image.network(
                food.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.9,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xff000000),
                        const Color(0xff000000).withOpacity(0),
                      ],
                    ),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom:10,right: 20,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height/ 37,
                        ),
                         Text(
                          food.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5,),
                            Image.asset(
                              'lib/assets/icons/star1.png',
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(width: 5),
                             Text(
                              food.rate.toStringAsFixed(2),
                              style: TextStyle(
                                color: compColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 10),
                             Text(
                              '${food.price.toStringAsFixed(2)} LYD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: compColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                             Text(
                              formatCategory(food.generalCategory),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
