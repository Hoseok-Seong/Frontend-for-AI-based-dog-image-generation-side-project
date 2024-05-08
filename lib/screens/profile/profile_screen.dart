import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
                                  onPressed: (){},
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
                          press: () => {},
                        ),
                        ProfileMenu(
                          text: "이용권",
                          icon: "assets/icons/coupon-discount-gift-svgrepo-com.svg",
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "알림",
                          icon: "assets/icons/bell-svgrepo-com.svg",
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "고객센터",
                          icon: "assets/icons/headphones-head-set-chat-live-support-svgrepo-com.svg",
                          press: () {},
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