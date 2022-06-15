import 'package:flutter/material.dart';
import 'package:untitled9/allScreens/login_screen/login_page.dart';
import 'package:untitled9/splash_page/components/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  final PageController _pageView = PageController(initialPage: 0);
  List<Map<dynamic, String>> splashData = [
    {"image": "assets/images/splash_1.png", "text": "Hello", "title": "hello"},
    {"image": "assets/images/splash_2.png", "text": "Hii", "title": "hii"},
    {"image": "assets/images/splash_3.png", "text": "Good", "title": "good"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageView,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"].toString(),
                      title: splashData[index]["text"].toString(),
                      text: splashData[index]["title"].toString()),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentPage == 2
                            ? Text("")
                            : TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text("Skip"),
                              ),
                        MaterialButton(
                          onPressed: () {
                            _pageView.nextPage(
                                duration: Duration(microseconds: 100),
                                curve: Curves.easeIn);

                            if (currentPage == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }
                          },
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          child: currentPage == 2
                              ? Text("Get Started")
                              : Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                          shape: currentPage == 2 ? Border() : CircleBorder(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(microseconds: 100),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 5,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.amber : Colors.black45,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
