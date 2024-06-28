import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/blocs/food_details_bloc.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';

class DetailPage extends StatefulWidget {
  final Food food;

  DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                  height: SizeConfig.screenHeight!/3,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.network(widget.food.image,fit: BoxFit.fill,)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xff000000).withOpacity(0),
                      const Color(0xff000000).withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 30, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.35,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(42),
                          topLeft: Radius.circular(42))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.title,
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'lib/assets/icons/star-rating-4.png',
                          width: 120,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.food.rate} Star Ratings',
                              style: TextStyle(color: compColor, fontSize: 13),
                            ),
                            const Spacer(),
                            Text(
                              'LY. ${widget.food.price.toStringAsFixed(0)}',
                              style: bigTitleStyle(),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('  / Per Slide.'),
                          ],
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.food.des,
                          style: subTitleStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: transGrey.withOpacity(0.5),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Customize your Order',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          color: transGrey.withOpacity(0.7),
                          child: const Text(
                            '- Select the size of portion -',
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          color: transGrey.withOpacity(0.7),
                          child: const Text(
                            '- Select the ingredients -',
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Number Of Slides',
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            const Spacer(),
                            SizedBox(
                                height: 38,
                                width: 50,
                                child: CustomFilledButton(
                                  title: '+',
                                  onPressed: () {
                                    if (quantity > 99) {
                                      return;
                                    } else {
                                      setState(() {
                                        quantity++;
                                      });
                                    }
                                  },
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                height: 38,
                                width: 50,
                                child: CustomOutlinedButton(
                                  title: quantity.toString(),
                                  onPressed: null,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                height: 38,
                                width: 50,
                                child: CustomFilledButton(
                                  title: '-',
                                  onPressed: () {
                                    if (quantity <= 1) {
                                      return;
                                    } else {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  },
                                )),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 5,
                                decoration: const BoxDecoration(
                                    color: compColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(38),
                                        bottomRight: Radius.circular(38),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          38,
                                      right: 20),
                                  width: MediaQuery.of(context).size.width /
                                      1.4,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(38),
                                        topLeft: Radius.circular(38),
                                        bottomRight: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 2,),
                                      const Text('Total Price'),
                                      const SizedBox(height: 2,),
                                      SizedBox(
                                          width: SizeConfig.screenWidth,
                                          child: Center(child: Text('LY ${(quantity * widget.food.price).toStringAsFixed(0)}',style: bigTitleStyle(),))),
                                      const SizedBox(height: 1,),
                                      CustomIconButton(
                                        title: 'Add to Cart',
                                        iconImage: 'lib/assets/icons/shopping-cart.png',
                                        onPressed: () async {
                                          final Food food = Food(title: widget.food.title, des: widget.food.des, foodCategory: widget.food.foodCategory, rate: widget.food.rate, price: widget.food.price, generalCategory: widget.food.generalCategory, date: widget.food.date,quantity: quantity, image: widget.food.image);
                                          food.id = widget.food.id;
                                          context.read<FoodDetailsBloc>().add(AddToCartEvent(food: food));
                                          Navigator.pop(context);
                                        },
                                        color: compColor,
                                        buttonHeight: MediaQuery.of(context).size.height / 20,
                                        buttonWidth: MediaQuery.of(context).size.width / 2,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 20,
                left: 0,
                right: 0,
                child: const Padding(
                  padding: EdgeInsets.only(right: 20,left: 10),
                  child: CustomAppBar(isHaveBackButton: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
