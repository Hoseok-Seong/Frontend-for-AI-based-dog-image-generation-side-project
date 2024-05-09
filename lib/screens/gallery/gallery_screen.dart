import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  static String routeName = "/gallery";

  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: 21,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.blue[100 * (index % 9 + 1)],
                                  child: Center(
                                    child: Text('Item $index'),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                    )
                  ]
              ),
            ),
          )
      ),
    );
  }
}
