import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:puppicasso/screens/gallery/galleries_screen.dart';
import 'package:puppicasso/screens/main/main_screen.dart';
import 'package:puppicasso/screens/profile/profile_screen.dart';
import 'package:puppicasso/screens/picture_create/picture_create_screen.dart';
import 'package:puppicasso/constants.dart';
import 'package:puppicasso/viewmodels/galleries_view_model.dart';
import 'package:puppicasso/viewmodels/main_view_model.dart';
import 'package:puppicasso/viewmodels/picture_create_view_model.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);
const Color kSecondaryColor = Color(0xFF979797);

class TabIndexNotifier extends StateNotifier<int> {
  TabIndexNotifier() : super(0);

  void updateIndex(BuildContext context, int newIndex, WidgetRef ref) {
    state = newIndex;
    switch (newIndex) {
      case 0:
        ref.read(mainViewModelProvider.notifier).fetchData(context);
        break;
      case 1:
        ref.read(pictureCreateViewModelProvider.notifier).fetchData(context);
        break;
      case 2:
        ref.read(galleriesViewModelProvider.notifier).fetchData(context);
        break;
      case 3:
        break;
    }
  }
}

final tabIndexProvider = StateNotifierProvider<TabIndexNotifier, int>((ref) {
  return TabIndexNotifier();
});

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {

  DateTime? currentBackPressTime;

  void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mainViewModelProvider.notifier).fetchData(context);
    });
  }

  final List<Widget> pages = [
    const MainScreen(),
    const PictureCreateScreen(),
    const GalleriesScreen(),
    ProfileScreen()
  ];

  Future<bool> onWillPop(){

    DateTime now = DateTime.now();

    if(currentBackPressTime == null || now.difference(currentBackPressTime!)
        > const Duration(seconds: 2))
    {
      currentBackPressTime = now;
      const msg = "'뒤로'버튼을 한 번 더 누르면 종료됩니다.";

      Fluttertoast.showToast(msg: msg);
      return Future.value(false);
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final currentSelectedIndex = ref.watch(tabIndexProvider);

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
                  showCustomDialog(context, "알림", "아직 준비중인 서비스입니다.");
                },
              ),
            )
          ],
        ),
        body: IndexedStack(
          index: currentSelectedIndex,
          children: pages,
        ),
        backgroundColor: kSecondaryColor,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            ref.read(tabIndexProvider.notifier).updateIndex(context, index, ref);
          },
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
      ),
    );
  }
}
