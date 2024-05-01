import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puppicasso/screens/main/main_screen.dart';
import 'package:puppicasso/screens/profile/profile_screen.dart';
import 'package:puppicasso/screens/picture_create/picture_create_screen.dart';
import 'package:puppicasso/screens/picture_download/picture_download_screen.dart';
import 'package:puppicasso/constants.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);
const Color kSecondaryColor = Color(0xFF979797);

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const MainScreen(),
    const PictureCreateScreen(),
    const PictureDownloadScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/notification-bell-on-svgrepo-com.svg",
              ),
              onPressed: () {
              },
            ),
          )
        ],
      ),
      body: pages[currentSelectedIndex],
      backgroundColor: kSecondaryColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home-1393-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/home-1393-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/camera-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/camera-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "사진 생성",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/gallery-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/gallery-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "갤러리",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/user-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/user-svgrepo-com.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "설정",
          ),
        ],
      ),
    );
  }
}