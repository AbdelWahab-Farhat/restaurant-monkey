import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealmoneky/cubits/account_user_cubit/account_user_cubit.dart';
import 'package:mealmoneky/model/account_user.dart';
import 'package:mealmoneky/model/address.dart';
import 'package:mealmoneky/services/services.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  File? file;
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BlocBuilder<AccountUserCubit, AccountUserState>(
        builder: (context, state) {
          if (state is AccountUserChangedState) {
            final user = state.accountUser;
            if (user != null) {
              return Container(
                margin: const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: 'Profile',
                    ),
                    SizedBox(
                      height: screenHeight / 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        file = await getImageFile();
                        context.read<AccountUserCubit>().emit(AccountUserOnUpDateState(accountUser: user));
                      },
                      child: _avatarWidget(user.userImage, file),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _editProfileWidget(context, state.accountUser!),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _infoBoxWidget(screenWidth, screenHeight, user.name, 'Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    _infoBoxWidget(screenWidth, screenHeight, user.phoneNumber, 'Phone Number'),
                    const SizedBox(
                      height: 20,
                    ),
                    _infoBoxWidget(screenWidth, screenHeight, formatAddress(user.address, 3), 'Address'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          } else if (state is AccountUserOnUpDateState) {
            var user = state.accountUser;
            return Container(
              margin: const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: 'Profile',
                    ),
                    SizedBox(
                      height: screenHeight / 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        file = await getImageFile();
                        context.read<AccountUserCubit>().onUpdateAccountUser(user);
                      },
                      child: _avatarWidget(user.userImage, file),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _editInfoBoxWidget(screenWidth, screenHeight, user.name, 'Name', controllerName, user, context),
                    const SizedBox(
                      height: 20,
                    ),
                    _editInfoBoxWidget(screenWidth, screenHeight, user.phoneNumber, 'Phone Number', controllerPhone, user, context),
                    const SizedBox(
                      height: 20,
                    ),
                    _editInfoBoxWidget(screenWidth, screenHeight, formatAddress(user.address, 3), 'Address', null, user, context),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFilledButton(
                      title: 'Save Change',
                      onPressed: () async {
                        user.name = controllerName.text.trim();
                        user.phoneNumber = controllerPhone.text.trim();
                        if (file != null) {
                          context.read<AccountUserCubit>().emit(AccountUserLoadingState());
                          user.userImage = await AppServices().changeImageFileToNetwork(file!, user);
                        }
                        context.read<AccountUserCubit>().updateAccountUser(user);
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (state is AccountUserLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: compColor,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<File?> getImageFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return null;
    } else {
      return File(pickedImage.path);
    }
  }

  Widget _infoBoxWidget(double screenWidth, double screenHeight, String text, String hint) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.only(left: 20, right: 15, top: 5),
      width: screenWidth,
      height: screenHeight / 14.6,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        color: transGrey.withOpacity(0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: subTitleStyle(),
          ),
          Text(
            text,
            maxLines: 1,
            softWrap: true,
            style: const TextStyle(color: mainColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _editInfoBoxWidget(double screenWidth, double screenHeight, String text, String hint, TextEditingController? controller,
      AccountUser user, BuildContext context) {
    if (controller != null) {
      controller.text = text.trim();
    }
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.only(left: 20, right: 15, top: 5),
      width: screenWidth,
      height: screenHeight / 13,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        color: transGrey.withOpacity(0.6),
      ),
      child: controller == null
          ? GestureDetector(
        onTap: () async {
          final Position position = await AppServices.determinePosition();
          GeoCode geoCode = GeoCode(apiKey: APIKEY);
          final address = await geoCode.reverseGeocoding(latitude: position.latitude, longitude: position.longitude);
          if (address == null) {
            return;
          }
          UserAddress addressUser = UserAddress(country: address.countryName!, cityName: address.city!, streetAddress: address.streetAddress!);
          user.address = addressUser;
          context.read<AccountUserCubit>().onUpdateAccountUser(user);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$hint (click To change)",
                style: const TextStyle(fontSize: 11, color: subColor),
              ),
              SizedBox(height: 3),
              Center(
                child: Text(
                  text,
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(color: mainColor, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10, bottom: 5),
              border: InputBorder.none,
              labelText: hint,
              labelStyle: subTitleStyle(),
              suffixIcon: const Icon(
                Icons.edit,
                color: compColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _avatarWidget(String? imageUrl, File? file) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: file != null
              ? FileImage(file)
              : imageUrl != null && imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : const AssetImage('lib/assets/images/avatar.png') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65),
                ),
              ),
              child: const Center(
                child: Icon(Icons.photo_camera_outlined, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editProfileWidget(BuildContext context, AccountUser user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.edit,
          color: compColor,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            context.read<AccountUserCubit>().emit(AccountUserOnUpDateState(accountUser: user));
          },
          child: const Text(
            'Edit Profile',
            style: TextStyle(color: compColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
