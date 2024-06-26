import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  void updateIndex(int newIndex, WidgetRef ref) {
    state = newIndex;
    switch (newIndex) {
      case 0:
        ref.read(mainViewModelProvider.notifier).fetchData();
        break;
      case 1:
        ref.read(pictureCreateViewModelProvider.notifier).fetchData();
        break;
      case 2:
        ref.read(galleriesViewModelProvider.notifier).fetchData();
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
      ref.read(mainViewModelProvider.notifier).fetchData();
    });
  }

  final List<Widget> pages = [
    const MainScreen(),
    const PictureCreateScreen(),
    const GalleriesScreen(),
    ProfileScreen()
  ];

  // Future<bool> _onWillPop() async {
  //   return await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('앱을 종료하시겠습니까?'),
  //       content: const Text('앱을 종료하시려면 "예"를 누르세요.'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text('아니요'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text('예'),
  //         ),
  //       ],
  //     ),
  //   ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    final currentSelectedIndex = ref.watch(tabIndexProvider);

    return WillPopScope(
      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('뒤로 버튼을 한 번 더 누르면 종료합니다.'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
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
            ref.read(tabIndexProvider.notifier).updateIndex(index, ref);
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
