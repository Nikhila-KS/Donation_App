import 'package:donation_app_igdtuw/screens/editprofile.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'slide.dart';

class BoardingPage extends StatefulWidget {

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  @override
  void initState(){
    _currentPage = 0;
    _slides = [
      Slide("assets/pic3.jpg","Making your \nhelping-out journey \neasier"),
      Slide("assets/pichand.jpg","It takes YOU \nto make hope possible"),
      Slide("assets/mars.png","Inspiring greatness, \none gift at a time"),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  List<Widget> _buildSlides()
  {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide)
  {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(w*.01, h*0.05, w*.01, h*0.01),
            child: Image.asset(slide.image, fit: BoxFit.contain,),
          ),
        ),
        SizedBox(height: h * .01),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: w * .001,),
          child: Text(
            slide.heading,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: w * 0.04,
              fontFamily: 'Bebas_Neue',
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        SizedBox(height: h * .17),
      ],
    );
  }
  void _handlingOnPageChanged(int page)
  {
    setState(() => _currentPage = page);
  }

  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for(int i = 0; i < _slides.length; i++){
      row.children.add(_buildPageIndicatorItem(i));
      if(i != _slides.length -1) {
        row.children.add(const SizedBox(
          width: 12,
        ));
      }
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index)
  {
    return Container(
      width: index == _currentPage ? 8 : 5,
      height: index == _currentPage? 8 : 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _currentPage
              ? const Color.fromRGBO(136, 144, 178, 1)
              : const Color.fromRGBO(206, 209, 223, 1)
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            children: _buildSlides(),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(
                  height: h * .035,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                  height: h*.07,
                  width: w*.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orange.shade900
                      ],
                    ),
                  ),
                  child: OutlinedButton(
                    onPressed: (){},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>LoginScreen()));
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'Spartan',
                        ),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

