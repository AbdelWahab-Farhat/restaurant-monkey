import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmoneky/pages/startUp_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: kToolbarHeight,right: 20,left: 20),
        child: Column(
          children: [
            CustomAppBar(title: 'More'),
            _moreBox('Payment Details','lib/assets/icons/income.png'),
            _moreBox('My Orders','lib/assets/icons/shopping-bag-black.png'),
            _moreBox('Notifications','lib/assets/icons/notfi.png'),
            _moreBox('Sign out','lib/assets/icons/email.png'),
            _moreBox('About Us','lib/assets/icons/info.png'),

          ],
        ),
      ),
    );
  }

  Widget _moreBox(String title,String imageIcon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Sign out') {
           FirebaseAuth.instance.signOut();
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartUpPage(),), (route) => false);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 20),
        width: SizeConfig.screenWidth!,
        height: SizeConfig.screenHeight! / 10,
        decoration: BoxDecoration(
          border: Border.all(width: 0.2 ,color: Colors.black.withOpacity(0.5)),
          color: transGrey.withOpacity(0.4),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(33),topRight: Radius.circular(33)
              ,bottomLeft: Radius.circular(10),topLeft: Radius.circular(10)
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.5),
              child: Image.asset(imageIcon,width:25,height: 25,),
            ),
            SizedBox(width: 20,),
            Text(title,style: TextStyle(color: mainColor,fontSize: 17),)
          ],
        ),
      ),
    );
  }
}
