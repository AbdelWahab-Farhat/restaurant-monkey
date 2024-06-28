import 'package:flutter/material.dart';
import 'package:mealmoneky/pages/startUp_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingPage extends StatelessWidget {
  PageController controller = PageController();
   OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children:  [
                _pageViewItem(context,'Find Food You Love',
                    'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
                  'lib/assets/images/on-boarding-1.png'
                ),
                _pageViewItem(context,'Fast Delivery',
                    'Fast food delivery to your home,\n office wherever you are',
                'lib/assets/images/on-boarding-2.png'
                ),
                _pageViewItem(context,'Live Tracking',
                    'Real time tracking of your food on the app once you placed the order\n',
                'lib/assets/images/on-boarding-3.png'
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            effect: const SlideEffect(
              activeDotColor: compColor
            ),
            controller: controller, count: 3,
          ),
          const SizedBox(height: 40,),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child:  CustomFilledButton(title: 'Next',onPressed: () {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
              if (controller.page == 2  ) {
                  Navigator.pushNamed(context, 'startup');
                }
              },
              ),),
           SizedBox(height: MediaQuery.sizeOf(context).height/17,),
        ],
      ),
    );
  }
  
  Widget _pageViewItem(BuildContext context ,String title , String subTitle , String image) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.sizeOf(context).width/1.5,
                height: MediaQuery.sizeOf(context).height/1.8,
                child: Image.asset(image,)),
            const SizedBox(height: 20,),
            Text(title,style: bigTitleStyle(),textAlign: TextAlign.center ),
            const SizedBox(height: 20,),
            Text(subTitle, style: subTitleStyle(),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

