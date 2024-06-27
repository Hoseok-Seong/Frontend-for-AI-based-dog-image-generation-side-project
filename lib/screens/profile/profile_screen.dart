import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppicasso/services/logout_service.dart';
import 'package:puppicasso/viewmodels/main_view_model.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends ConsumerWidget {
  static String routeName = "/profile";

  final LogoutService _logoutService = LogoutService();

  ProfileScreen({super.key});

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

  void showSubscriptionInfoDialog(BuildContext context, MainState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.card_membership, color: Colors.blue),
            const SizedBox(width: 8),
            const Text("이용권 정보", style: TextStyle(color: Colors.blue)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "사용 중인 이용권",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              state.data?.subscriptionName ?? "N/A",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "생성한 사진 수",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              state.data?.usedGenerateCount.toString() ?? "0",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "남은 생성 횟수",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              state.data?.leftGenerateCount.toString() ?? "0",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.email, color: Colors.blue),
            const SizedBox(width: 8),
            const Text("고객센터", style: TextStyle(color: Colors.blue)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "문의사항은",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "shsshs0125@naver.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "으로 문의해주세요.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ProfilePic(),
                                    const SizedBox(width: 10),
                                    RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <InlineSpan>[
                                          TextSpan(
                                            text: '사용자 1님',
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    await _logoutService.logout(context);
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/icons/log-out-1-svgrepo-com.svg",
                                    width: 30,
                                    height: 30,
                                  ),
                                )
                              ],
                            ),
                        ),
                        const SizedBox(height: 20),
                        ProfileMenu(
                          text: "사용자 정보",
                          icon: "assets/icons/user-svgrepo-com.svg",
                          press: () {

                          },
                        ),
                        ProfileMenu(
                          text: "이용권",
                          icon: "assets/icons/coupon-discount-gift-svgrepo-com.svg",
                          press: () {
                            showSubscriptionInfoDialog(context, state);
                          },
                        ),
                        ProfileMenu(
                          text: "알림",
                          icon: "assets/icons/bell-svgrepo-com.svg",
                          press: () {
                            showCustomDialog(context, "알림", "아직 준비중인 서비스입니다.");
                          },
                        ),
                        ProfileMenu(
                          text: "고객센터",
                          icon: "assets/icons/headphones-head-set-chat-live-support-svgrepo-com.svg",
                          press: () {
                            showContactDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}