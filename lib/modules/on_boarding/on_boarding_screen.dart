import 'package:flutter/material.dart';
import 'package:shop/modules/login/loginScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });

}


class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/on_boarding_1.png',
      title: 'On Boading Title 1',
      body: 'On Boading Body 1',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_2.png',
      title: 'On Boading Title 2',
      body: 'On Boading Body 2',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_3.png',
      title: 'On Boading Title 3',
      body: 'On Boading Body 3',
    ),
  ];


  var boardingController = PageController();

  bool lastPage = false;

  void submitOnboarding()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value)
        {
          navigateAndRemove(context, LoginScreen());
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submitOnboarding,
            text: 'Skip'
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => BuildBoardItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardingController,
                onPageChanged: (index) {
                  if(index == boarding.length-1)
                    {
                      setState(() {
                        lastPage = true;
                      });
                      print('lasssst');
                    } else {
                      setState(() {
                        lastPage = false;
                      });
                      print('not lasssst');
                    }
                },
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            Row(
              children: [
               SmoothPageIndicator(
                 controller: boardingController,
                 count: boarding.length,
                 effect: ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   activeDotColor: defaultColor,
                   dotHeight: 10,
                   dotWidth: 10,
                   expansionFactor: 4,
                   spacing: 5.0,
                 ),
               ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(lastPage) {
                      submitOnboarding();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(
                          // milliseconds: 700,
                          seconds: 1,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget BuildBoardItem(BoardingModel list) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(list.image),
      ),
    ),
    sizedBoxHeight,
    Text(
      list.title,
      style: TextStyle(
        fontSize: 20.0,
      ),
    ),
    sizedBoxHeight,
    Text(
      list.body,
      style: TextStyle(
        fontSize: 16.0,
      ),
    ),
    sizedBoxHeight,
  ],
);
