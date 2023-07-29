import 'package:flutter/material.dart';
import 'package:shop.png/reusable.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cachehelper.dart';
import 'login.dart';

class Model {
  late final String image;
  late final String title;
  late final String body;
  Model({
    required this.image,
    required this.title,
    required this.body,
  });
}
  bool isLast=false;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Model> model = [
    Model(
      image: 'images/shopping.png',
      title: 'on bording screen 1',
      body: 'on bording body 1',
    ),
    Model(
      image: 'images/shopping.png',
      title: 'on bording screen 2',
      body: 'on bording body 2',
    ),
    Model(
      image: 'images/shopping.png',
      title: 'on bording screen 3',
      body: 'on bording body 3',
    ),
  ];
   var controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
               submit();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('SKIP',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 23,
                ),
                ),
              ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index)
              {
                if(index==2)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }
                else{
                  setState(() {
                    isLast=false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => item(model[index]),
              itemCount: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: model.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotWidth: 10,
                    spacing: 10,
                    expansionFactor: 4,
                  ),

                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    if(isLast)
                      {
                      submit();
                      }
                    else
                      {
                        controller.nextPage(duration: const Duration(
                          milliseconds: 500,
                        ), curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(Model model) => Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Image(image: AssetImage(model.image)),
            const SizedBox(
              height: 40,
            ),
            Text(
              model.body,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );


  void submit()
  {
    CacheHelper.saveData(
      key: 'onbording',
      value: true,
    ).then((value) {
      goTo(
        widget:  Login(),
        context: context,
      );
    });

  }
}
