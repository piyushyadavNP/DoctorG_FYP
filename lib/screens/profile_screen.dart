import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/common/alert_info.dart';
import 'package:doctor/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../common/text_style.dart';
import 'package:flutter/material.dart';

import '../common/card_design.dart';
import '../common/custom_clipper.dart';
import '../common/tabbar_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  String? profileImageLocation;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    scrollController;
    getProfileImage();
    TabController tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future getProfileImage() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        profileImageLocation = value["profileImage"].toString();
      });
      log(profileImageLocation!);
    });
  }

  @override
  void dispose() {
    scrollController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        height: 150,
                        color: card,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Circleavatar(
                  top: 60,
                  left: 160,
                  radius: 40,
                  iconChild: GestureDetector(
                    child: ClipOval(
                      child: profileImageLocation == null
                          ? const Icon(Icons.person)
                          : Image.network(
                              profileImageLocation!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    onTap: () {
                      imgFromGallery(context);
                    },
                  ),
                ),
                Circleavatar(
                  top: 50,
                  left: 40,
                  radius: 20,
                  iconChild: IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Circleavatar(
                  top: 50,
                  right: 40,
                  radius: 20,
                  iconChild: IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Piyush Yadav",
              style: AppTextStyle.headline2,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Joined in 2022",
              style: AppTextStyle.subtitle1,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Welcome!",
                    style: AppTextStyle.headline3,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const CommonSingleCard(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Recent history",
                        style: AppTextStyle.headline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const CommonTabbar(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future imgFromGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    const destination = 'files/';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child(fileName);
      final dbRef = FirebaseFirestore.instance.collection('users');
      await ref.putFile(_photo!).then((p0) {
        ref.getDownloadURL().then(
            (value) => dbRef.doc(user!.uid).update({"profileImage": value}));
        AlertInfo(message: "Profile Pic Uploaded Successfully")
            .showInfo(context);
      });
    } catch (e) {
      log("Error In Uploading Profile Pic");
      AlertInfo(message: "Error WHile Uploading").showInfo(context);
    }
  }
}

class Circleavatar extends StatelessWidget {
  double? top;
  double? left;
  double? right;
  double? radius;
  Widget? iconChild;

  Circleavatar({
    Key? key,
    required this.iconChild,
    this.left,
    this.right,
    required this.radius,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: white, width: 2),
          color: Colors.white,
        ),
        child: CircleAvatar(
          radius: radius,
          child: iconChild,
        ),
      ),
    );
  }
}
