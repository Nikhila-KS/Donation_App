import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_app_igdtuw/screens/profileview.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'home_screen.dart';
import 'navbar.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home> {
  // Home({Key? key}) : super(key: key);
  int activeIndex = 0;
  final _firestoreInstance = FirebaseFirestore.instance;
  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  final List _names = [];
  final List _date =[];
  int index = 0;
  final screens = [
    Home(),
    HomeScreen(),
    viewprofile(),
  ];

  fetchCarousel() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("drives").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image_url"],
        );
      }
      for (int i = 0; i < qn.docs.length; i++) {
        _names.add(
          qn.docs[i]["name"],
        );
        _date.add(
          qn.docs[i]["date"].toDate().toString()
        );
      }
    });

    return qn.docs;
  }

  //final _controller = PageController();
  @override
  void initState() {
    fetchCarousel();
    super.initState();
  }
  Widget buildImage(String urlImages, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    color: Colors.grey,
    child: Image.network(
      urlImages,
      fit: BoxFit.cover,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              const SizedBox(
                height: 60.0,
              ),
              Container(
                // width: 100.00,
                  height: 100.00,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: new DecorationImage(
                      image: AssetImage('assets/donationquote.jpeg'),
                      fit: BoxFit.fitHeight,
                    ),
                  )
              ),
              SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Drives',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight:FontWeight.w600,
                    color: Color(0xFFE64A19),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: CarouselSlider(
                      items: _carouselImages
                          .map((item) => Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 900,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),),
                            child: Stack(children: <Widget>[
                              Image.network(item,
                                fit: BoxFit.fitWidth,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        _names[_carouselImages.indexOf(item)],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _date[_carouselImages.indexOf(item)],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          height: 700,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {
                              _dotPosition = val;
                            });
                          })),
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              DotsIndicator(
                dotsCount:
                _carouselImages.isEmpty ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.orange,
                  color: Colors.orange.withOpacity(0.5),
                  spacing: const EdgeInsets.all(2),
                  activeSize: const Size(8, 8),
                  size: const Size(6, 6),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gallery',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE64A19),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                children:  [
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg')),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://imgmedia.lbb.in/media/2019/10/5da42de32790344dc8bfd964_1571040739720.jpg'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://imgstaticcontent.lbb.in/lbbnew/wp-content/uploads/sites/1/2015/12/soundofhope.jpg'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://www.ilead.net.in/ADMIN/IMAGES/OTH/Diwali%20Donation%20Drive%20by%20iLEAD_05.jpeg'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://files.globalgiving.org/pfil/33994/pict_featured_jumbo.jpg?t=1528214213000'),
                  ),

                  // StaggeredGridTile.count(
                  //   crossAxisCellCount: 1,
                  //   mainAxisCellCount: 1,
                  //   child: Image.network('https://feelandshare.org/wp-content/uploads/2020/02/donation-food-old-age-home-prem-daan.jpg'),
                  // ),
                  //last line
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://i0.wp.com/vacommunityhealth.org/wp-content/uploads/2019/03/older-adults-hands.jpg?ssl=1'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Image.network('https://cdn.storymirror.com/cover/original/zcmxjoy4.jpg'),
                  ),
                  // StaggeredGridTile.count(
                  //   crossAxisCellCount: 1,
                  //   mainAxisCellCount: 1,
                  //   child: Image.network('https://cimages.milaap.org/milaap/image/upload/v1588908914/production/images/campaign/170084/donation_for_elderly_oldage-home_helpageindia_umtdww_1588908920.jpg'),
                  // ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://i.pinimg.com/originals/11/8b/ab/118baba7f634ef7552e729e6c34cdbe1.jpg'),
                  ),

                  //last line
                  //new line
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://www.mlive.com/resizer/OmVHJKajc3WlOdpdL94OPkbpFJs=/1280x0/smart/advancelocal-adapter-image-uploads.s3.amazonaws.com/image.mlive.com/home/mlive-media/width2048/img/entertainmentnow_impact/photo/toysfortotsjpg-727ada738afa5d4e.jpg'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://files.globalgiving.org/pfil/14514/pict_large.jpg?m=1374317932000'),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Image.network('https://static.toiimg.com/thumb/60320646/12938292_1003371776420893_2177797670633486735_n.jpg?width=1200&height=900'),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
      //

    );

  }
}

//

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:donation_app_igdtuw/screens/profileview.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// import 'home_screen.dart';
// import 'navbar.dart';
//
// class Home extends StatefulWidget{
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState()=> _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   // Home({Key? key}) : super(key: key);
//   int activeIndex = 0;
//   final _firestoreInstance = FirebaseFirestore.instance;
//   final List<String> _carouselImages = [];
//   var _dotPosition = 0;
//   final List _names = [];
//   final List _data =[];
//   final List _time=[];
//   int index = 0;
//   final screens = [
//     Home(),
//     HomeScreen(),
//     viewprofile(),
//   ];
//
//   fetchCarousel() async {
//     QuerySnapshot qn =
//     await _firestoreInstance.collection("drives").get();
//     setState(() {
//       for (int i = 0; i < qn.docs.length; i++) {
//         _carouselImages.add(
//           qn.docs[i]["image_url"],
//         );
//       }
//       for (int i = 0; i < qn.docs.length; i++) {
//         _names.add(
//           qn.docs[i]["name"],
//         );
//         // _data.add(
//         //   qn.docs[i][""]
//         // );
//       }
//     });
//
//     return qn.docs;
//   }
//
//   //final _controller = PageController();
//   @override
//   void initState() {
//     fetchCarousel();
//     super.initState();
//   }
//   Widget buildImage(String urlImages, int index) => Container(
//     margin: const EdgeInsets.symmetric(horizontal: 8),
//     color: Colors.grey,
//     child: Image.network(
//       urlImages,
//       fit: BoxFit.cover,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF000000),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//
//               const SizedBox(
//                 height: 60.0,
//               ),
//               Container(
//                 // width: 100.00,
//                   height: 100.00,
//                   decoration: new BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     image: new DecorationImage(
//                       image: AssetImage('assets/donationquote.jpeg'),
//                       fit: BoxFit.fitHeight,
//                     ),
//                   )
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Recent Drives',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight:FontWeight.w600,
//                     color: Color(0xFFE64A19),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(29),
//                 child: AspectRatio(
//                   aspectRatio: 1.5,
//                   child: CarouselSlider(
//                       items: _carouselImages
//                           .map((item) => Padding(
//                         padding: const EdgeInsets.only(left: 3, right: 3),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.of(context)
//                               //     .push(
//                               //   MaterialPageRoute(
//                               //     builder: (context) => ViewNote( //////////////////////////////////////////////ppppppppppppppppppp
//                               //       data,
//                               //       formattedTime,
//                               //       snapshot.data!.docs[index].reference,
//                               //     ),
//                               //   ),
//                               // )
//                               //     .then((value) {
//                               //   setState(() {});
//                               // });
//                             },
//                             child: Container(
//                               height: 900,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),),
//                               child: Stack(children: <Widget>[
//                                 Image.network(item,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                                 Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                                     child: Text(
//                                       _names[_carouselImages.indexOf(item)],
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ))
//                               ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ))
//                           .toList(),
//                       options: CarouselOptions(
//                           autoPlay: false,
//                           enlargeCenterPage: true,
//                           viewportFraction: 1.0,
//                           enlargeStrategy: CenterPageEnlargeStrategy.height,
//                           height: 700,
//                           onPageChanged: (val, carouselPageChangedReason) {
//                             setState(() {
//                               _dotPosition = val;
//                             });
//                           })),
//                 ),
//               ),
//               const SizedBox(
//                 height: 7.0,
//               ),
//               DotsIndicator(
//                 dotsCount:
//                 _carouselImages.isEmpty ? 1 : _carouselImages.length,
//                 position: _dotPosition.toDouble(),
//                 decorator: DotsDecorator(
//                   activeColor: Colors.orange,
//                   color: Colors.orange.withOpacity(0.5),
//                   spacing: const EdgeInsets.all(2),
//                   activeSize: const Size(8, 8),
//                   size: const Size(6, 6),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Gallery',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFFE64A19),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               StaggeredGrid.count(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 3,
//                 crossAxisSpacing: 3,
//                 children:  [
//                   StaggeredGridTile.count(
//                       crossAxisCellCount: 2,
//                       mainAxisCellCount: 2,
//                       child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg')),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://imgmedia.lbb.in/media/2019/10/5da42de32790344dc8bfd964_1571040739720.jpg'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://imgstaticcontent.lbb.in/lbbnew/wp-content/uploads/sites/1/2015/12/soundofhope.jpg'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://www.ilead.net.in/ADMIN/IMAGES/OTH/Diwali%20Donation%20Drive%20by%20iLEAD_05.jpeg'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://files.globalgiving.org/pfil/33994/pict_featured_jumbo.jpg?t=1528214213000'),
//                   ),
//
//                   // StaggeredGridTile.count(
//                   //   crossAxisCellCount: 1,
//                   //   mainAxisCellCount: 1,
//                   //   child: Image.network('https://feelandshare.org/wp-content/uploads/2020/02/donation-food-old-age-home-prem-daan.jpg'),
//                   // ),
//                   //last line
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://i0.wp.com/vacommunityhealth.org/wp-content/uploads/2019/03/older-adults-hands.jpg?ssl=1'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 2,
//                     mainAxisCellCount: 2,
//                     child: Image.network('https://cdn.storymirror.com/cover/original/zcmxjoy4.jpg'),
//                   ),
//                   // StaggeredGridTile.count(
//                   //   crossAxisCellCount: 1,
//                   //   mainAxisCellCount: 1,
//                   //   child: Image.network('https://cimages.milaap.org/milaap/image/upload/v1588908914/production/images/campaign/170084/donation_for_elderly_oldage-home_helpageindia_umtdww_1588908920.jpg'),
//                   // ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://i.pinimg.com/originals/11/8b/ab/118baba7f634ef7552e729e6c34cdbe1.jpg'),
//                   ),
//
//                   //last line
//                   //new line
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://www.mlive.com/resizer/OmVHJKajc3WlOdpdL94OPkbpFJs=/1280x0/smart/advancelocal-adapter-image-uploads.s3.amazonaws.com/image.mlive.com/home/mlive-media/width2048/img/entertainmentnow_impact/photo/toysfortotsjpg-727ada738afa5d4e.jpg'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://files.globalgiving.org/pfil/14514/pict_large.jpg?m=1374317932000'),
//                   ),
//                   StaggeredGridTile.count(
//                     crossAxisCellCount: 1,
//                     mainAxisCellCount: 1,
//                     child: Image.network('https://static.toiimg.com/thumb/60320646/12938292_1003371776420893_2177797670633486735_n.jpg?width=1200&height=900'),
//                   ),
//
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       //
//
//     );
//
//   }
// }
