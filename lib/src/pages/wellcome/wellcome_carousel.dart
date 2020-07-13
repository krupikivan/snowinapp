import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/providers/welcome_provider.dart';
import 'onboard_item.dart';

class WellcomeCarousel extends StatefulWidget {
  @override
  _WellcomeCarouselState createState() => _WellcomeCarouselState();
}

class _WellcomeCarouselState extends State<WellcomeCarousel> {
  PageController controller;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                child: Consumer<WelcomeProvider>(
                    builder: (context, model, _) => model.listSlider == null
                        ? Center(child: CircularProgressIndicator())
                        : PageView(
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            controller: controller,
                            children: <Widget>[
                              OnboardItem(model: model.listSlider[0], index: 0),
                              OnboardItem(model: model.listSlider[1], index: 1),
                              OnboardItem(model: model.listSlider[2], index: 2),
                            ],
                          ))),
          ],
        ),
        bottomSheet: Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  i == _currentIndex
                      ? _buildPageIndicator(true)
                      : _buildPageIndicator(false),
              ],
            ),
          ),
        ));
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: isCurrentPage ? 16.0 : 12.0,
      width: isCurrentPage ? 16.0 : 12.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
