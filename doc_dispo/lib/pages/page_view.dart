import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:flutter/material.dart';

class IntroPageView extends StatefulWidget
{
  @override
  IntroPageViewState createState() => IntroPageViewState();
}

class IntroPageViewState extends State<IntroPageView>
{
  int currentPageView = -1;

  @override
  void initState() {
    super.initState();
    currentPageView = 0;
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: colorWidget,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50,),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/navigation", (Route<dynamic> route) => false);
              },
              child: const Text(
                "Passer",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
            child: PageView(
              controller: controller,
              children: [
                pageViewElement(img_url_1,title_1, texte_1, context),
                pageViewElement(img_url_2,title_2, texte_2, context),
                pageViewElement(img_url_3,title_3, texte_3, context),
              ],
              onPageChanged: (value){
                setState(() {
                  currentPageView = value;
                });
              },

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              indicatorPageView(currentPageView, 0),
              indicatorPageView(currentPageView, 1),
              indicatorPageView(currentPageView, 2),
            ],
          ),


        ],

      ),
    );

  }

}