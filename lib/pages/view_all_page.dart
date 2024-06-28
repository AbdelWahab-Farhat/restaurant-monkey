import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/detail_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';

class ViewAllPage extends StatelessWidget {
  final  String title;
  final List<Food> foods;
  const ViewAllPage({super.key, required this.title,required this.foods});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 20,top: kToolbarHeight),
        child: Column(
          children: [
            CustomAppBar(title: title,isHaveBackButton: true,),
            const SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 220,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return _gridItemFood(context, foods[index]);
              },),
            ),
          ],
        ),
      ),
    );
  }
  Widget _gridItemFood(BuildContext context , Food food) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(food: food),)),
      child: Container(
        width: MediaQuery.sizeOf(context).width/2.1,
        height: MediaQuery.sizeOf(context).height/3,
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          clipBehavior: Clip.hardEdge,
          surfaceTintColor: Colors.white,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(food.image,height:100,fit: BoxFit.cover,),
              const SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Text(
                  food.title,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10,),
                   Text(
                    formatCategory(food.generalCategory),
                    style: const TextStyle(
                      color: subColor,
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 12,
                      child: VerticalDivider(color: Colors.black.withOpacity(0.2),width: 2,thickness: 2,)),
                  Text(
                    formatCategory(food.foodCategory),
                    style: const TextStyle(
                      color: subColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$${food.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: compColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
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
              )
            ],),
        ),
      ),
    );
  }
}
