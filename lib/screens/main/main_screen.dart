import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/screens/init_screen.dart';
import 'package:puppicasso/viewmodels/main_view_model.dart';
import 'dart:convert';
import 'dart:typed_data';

class MainScreen extends ConsumerWidget {
  static String routeName = "/api/main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainViewModelProvider);
    final viewModelNotifier = ref.read(mainViewModelProvider.notifier);

    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (viewModel.errorMessage != null) {
      return Center(child: Text('Error: ${viewModel.errorMessage}'));
    } else if (viewModel.data == null) {
      return Center(child: Text('No data'));
    } else {
      final data = viewModel.data!;
      return Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
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
                  child: Column(
                    children: [
                      const Text(
                        textAlign: TextAlign.center,
                        "Puppicasso는 반려견을 위한 다양한 컨셉의 AI 프로필 사진을 제공하는 서비스입니다",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(tabIndexProvider.notifier).updateIndex(context, 1, ref);
                        },
                        child: Text("지금 바로 사진 생성하기"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '회원 등급: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.gradeName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '사용 중인 이용권: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.subscriptionName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '생성한 사진 수: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.usedGenerateCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '남은 생성 횟수: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.leftGenerateCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.8,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "최근 생성한 사진",
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(tabIndexProvider.notifier).updateIndex(context, 2, ref);
                                },
                                child: const Text(
                                  "갤러리로 이동하기",
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          data.imageUrls.isEmpty
                              ? const Center(
                                child: Text(
                                  "아직 생성한 사진이 없습니다.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                              : Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // children: data.fileData.map((base64Image) {
                                //   Uint8List imageBytes = base64Decode(base64Image);
                                //   return ClipOval(
                                //     child: Image.memory(
                                //       imageBytes,
                                //       width: 50,
                                //       height: 50,
                                //       fit: BoxFit.cover,
                                //     ),
                                //   );
                                // }).toList(),
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: data.imageUrls.map((imageUrl) {
                                  return ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(), // 로딩 중 표시
                                      ),
                                      errorWidget: (context, url, error) => Center(
                                        child: Icon(Icons.error, color: Colors.red), // 에러 표시
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     ClipOval(
                          //       child: Image.asset(
                          //         "assets/images/splash_image1.webp",
                          //         width: 50,
                          //         height: 50,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     ClipOval(
                          //       child: Image.asset(
                          //         "assets/images/splash_image2.webp",
                          //         width: 50,
                          //         height: 50,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     ClipOval(
                          //       child: Image.asset(
                          //         "assets/images/splash_image3.webp",
                          //         width: 50,
                          //         height: 50,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     ClipOval(
                          //       child: Image.asset(
                          //         "assets/images/splash_image1.webp",
                          //         width: 50,
                          //         height: 50,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     ClipOval(
                          //       child: Image.asset(
                          //         "assets/images/splash_image2.webp",
                          //         width: 50,
                          //         height: 50,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
