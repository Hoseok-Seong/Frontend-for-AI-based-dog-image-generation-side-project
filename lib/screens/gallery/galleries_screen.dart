import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/viewmodels/galleries_view_model.dart';

class GalleriesScreen extends ConsumerWidget {
  static String routeName = "/api/galleries";

  const GalleriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleriesViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <InlineSpan>[
                                TextSpan(
                                  text: '갤러리',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <InlineSpan>[
                                TextSpan(
                                  text: '다운로드/삭제',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (state.isLoading)
                        Center(child: CircularProgressIndicator())
                      else if (state.errorMessage != null)
                        Center(child: Text('Error: ${state.errorMessage}'))
                      else if (state.data?.fileData.isEmpty ?? true)
                          Center(child: Text('갤러리에 저장된 사진이 없습니다.', style: TextStyle(fontSize: 16, color: Colors.grey)))
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: state.data?.fileData.length ?? 0,
                            itemBuilder: (context, index) {
                              final base64String = state.data!.fileData[index];
                              final bytes = base64Decode(base64String);
                              return Card(
                                child: Center(
                                  child: Image.memory(
                                    bytes,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
