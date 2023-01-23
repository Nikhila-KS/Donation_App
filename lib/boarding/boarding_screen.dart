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
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(margin: const EdgeInsets.fromLTRB(32, 60, 32, 32),
            child: Image.asset(slide.image, fit: BoxFit.contain,),
          ),
        ),
        const SizedBox(height: 60,),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            slide.heading,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 28,
              fontFamily: 'Bebas_Neue',
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 140,),
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
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  height: 50,
                  width: 300,
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
                                builder: (context) =>
                                    LoginScreen()));
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'Spartan',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

