import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg2.jpeg'),
            fit: BoxFit.cover,
            opacity: .5),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(w*.02, h*0.05, w*.02, h*0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 25,),
                      Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.fromLTRB(w*.01, 0, w*0.04, 0),
                          child: const Image(
                            image: AssetImage('assets/logo_icon.png'),
                          )),
                      Column(
                        children: const [
                          Text('Donation App',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text('By CBIGDTUW',
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(fontSize: 17, color: Colors.white))
                        ],
                      )
                    ],
                  )),
              Divider(
                height: h * 0.01,
                thickness: h * .003,
                indent: w * .05,
                endIndent: w * .05,
                color: Colors.white,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(w*.03, h*.03, w*.03, h*.01),

                  child: const Text('ABOUT US',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold))),
              Divider(
                height: 0,
                thickness: h * .005,
                indent: w * .30,
                endIndent: w * .30,
                color: Colors.deepOrangeAccent,
              ),
              Container(

                  padding: EdgeInsets.fromLTRB(w*.03, h*.02, w*.03, h*.02),
                  child: const Text(
                      'Donation App By IGDTUW is an app that simplify the donation process .Our aim is to make all the information related to recent and upcoming college drives accessible in one place, hence allowing easy search and increasing participation .',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ))),
                      
                        Container(
                  padding: EdgeInsets.fromLTRB(w*.02, h*.04, w*.02, h*.01),
                  child: const Text('OUR TEAM',

              Container(
                  padding: EdgeInsets.fromLTRB(w*.02, h*.04, w*.02, h*.01),
                  child: Text('OUR TEAM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold))),
              Divider(
                height: 0,
                thickness: h * .006,
                indent: w * .30,
                endIndent: w * .30,
                color: Colors.deepOrangeAccent,
              ),
              Container(
                height: h*.30,
                padding: EdgeInsets.fromLTRB(w*.02, h*.02, w*.02, h*.02),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    makeItem(
                     image: 'assets/Founders/PoojaGera.jpg',
                        title: 'Pooja Gera Founder',
                        url: Uri.parse('https://www.linkedin.com/in/pooja-gera')),
                    makeItem(
                        image: 'assets/Founders/Nishtha Goyal.jpeg',
                        title: 'Nishtha Goyal Founder',
                        url: Uri.parse('https://www.linkedin.com/in/nishtha0801/')),
                    makeItem(
                        image: 'assets/Founders/Gaurisha R Srivastava.jpg',
                        title: 'Gaurisha R Shrivastava Founder',
                        url: Uri.parse('https://www.linkedin.com/in/gaurisha-r-srivastava/')),
                    makeItem(
                        image: 'assets/Founders/Abhigya Verma.jpg',
                        title: 'Abhigya Verma Founder',
                        url: Uri.parse('https://www.linkedin.com/in/abhigya02/')),
                    makeItem(
                        image: 'assets/profile_photos/JhanveeKhola.jpg',
                        title: 'Jhanvee Khola Developer',
                        url: Uri.parse('https://www.linkedin.com/in/jhanvee-khola/')),
                    makeItem(
                        image: 'assets/profile_photos/Nikhila.jpeg',
                        title: 'Nikhila K S Developer',
                        url: Uri.parse('https://www.linkedin.com/in/know-nikhila-k-s')),
                    makeItem(
                        image: 'assets/profile_photos/NikitaGarg.jpeg',
                        title: 'Nikita Garg Developer',
                        url: Uri.parse('https://www.linkedin.com/in/nikita-garg-819800220')),
                    makeItem(
                        image: 'assets/profile_photos/NikitaMedhi.jpeg',
                        title: 'Nikita Medhi Developer',
                        url: Uri.parse('https://www.linkedin.com/in/nikita-medhi-6aa899239/')),
                    makeItem(
                        image: 'assets/profile_photos/sehaj.jpeg',
                        title: 'Sehaj Developer',
                        url: Uri.parse('https://www.linkedin.com/in/sehaj-kapoor-4bbb6020b')),
                    makeItem(
                        image: 'assets/profile_photos/Shreel Trivedi.jpg',
                        title: 'Shreel Trivedi Developer',
                        url: Uri.parse('https://www.linkedin.com/in/shreel-trivedi-932993207')),
                    makeItem(
                        image: 'assets/profile_photos/Shuchita.jpeg',
                        title: 'Shuchita Bhutani Developer',
                        url:Uri.parse('hhttps://www.linkedin.com/in/shuchita-bhutani-69b882200')),
                    makeItem(
                        image: 'assets/profile_photos/Simran.jpeg',
                        title: 'Simran Joon Developer',
                        image: 'assets/Founders_PoojaGera.jpg',
                        title: 'Pooja Gera (Founder)',
                        url: Uri.parse('https://www.linkedin.com/in/pooja-gera')),
                    makeItem(
                        image: 'assets/Founders_Nishtha Goyal.jpeg',
                        title: 'Nishtha Goyal (Founder)',
                        url: Uri.parse('https://www.linkedin.com/in/nishtha0801/')),
                    makeItem(
                        image: 'assets/Founders_Gaurisha R Srivastava.jpg',
                        title: 'Gaurisha R Shrivastava (Founder)',
                        url: Uri.parse('https://www.linkedin.com/in/gaurisha-r-srivastava/')),
                    makeItem(
                        image: 'assets/Founders_Abhigya Verma.jpg',
                        title: 'Abhigya Verma (Founder)',
                        url: Uri.parse('https://www.linkedin.com/in/abhigya02/')),
                    makeItem(
                        image: 'assets/profile_photos/JhanveeKhola.jpg',
                        title: 'Jhanvee Khola (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/jhanvee-khola/')),
                    makeItem(
                        image: 'assets/profile_photos/Nikhila.jpeg',
                        title: 'Nikhila K S (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/know-nikhila-k-s')),
                    makeItem(
                        image: 'assets/profile_photos/NikitaGarg.jpeg',
                        title: 'Nikita Garg (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/nikita-garg-819800220')),
                    makeItem(
                        image: 'assets/profile_photos/NikitaMedhi.jpeg',
                        title: 'Nikita Medhi (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/nikita-medhi-6aa899239/')),
                    makeItem(
                        image: 'assets/profile_photos/sehaj.jpeg',
                        title: 'Sehaj (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/sehaj-kapoor-4bbb6020b')),
                    makeItem(
                        image: 'assets/profile_photos/Shreel Trivedi.jpg',
                        title: 'Shreel Trivedi (Developer)',
                        url: Uri.parse('https://www.linkedin.com/in/shreel-trivedi-932993207')),
                    makeItem(
                        image: 'assets/profile_photos/Shuchita.jpeg',
                        title: 'Shuchita Bhutani (Developer)',
                        url:Uri.parse('hhttps://www.linkedin.com/in/shuchita-bhutani-69b882200')),
                    makeItem(
                        image: 'assets/profile_photos/Simran.jpeg',
                        title: 'Simran Joon (Developer)',

                        url:Uri.parse('http://www.linkedin.com/in/simranjoon')),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeItem(
    {required String image, required String title, required Uri url}) {
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () async {
                if (await launchUrl(url)) {
                  launchUrl(url);
                } else {
                  throw "Could not launch $url";
                }
              },
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )),
    ),
  );
}