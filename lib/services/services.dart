

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:location/location.dart' as loc;
import 'package:mealmoneky/model/account_user.dart';

class AppServices {

  // Get Location
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Instance of the location plugin
    loc.Location location =  loc.Location();

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

// ···
  Future<File?> getImageFile() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image.
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return null;
    } else {
      return File(pickedImage.path);
    }
  }

  Future<String> changeImageFileToNetwork(File file,AccountUser user) async {
    final storage = FirebaseStorage.instance;
    final Reference storageReference = storage.ref().child('users_images/${file.uri.pathSegments.last}');

    final UploadTask uploadTask = storageReference.putFile(file);

    // انتظر حتى ينتهي الرفع
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  }


