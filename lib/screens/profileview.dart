
import 'package:donation_app_igdtuw/screens/aboutpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'editprofile.dart';
import 'login_screen.dart';
import 'navbar.dart';

final Uri _url = Uri.parse('https://celestial-biscuit.vercel.app/About');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class viewprofile extends StatefulWidget {
  const viewprofile({Key? key}) : super(key: key);

  @override
  State<viewprofile> createState() => _viewprofileState();
}

class _viewprofileState extends State<viewprofile> {
  Future<DocumentSnapshot> getDocument() async {
    var user = await FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: FutureBuilder(
          future: getDocument(),
          builder: (context, snapshot) {
            final data;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                data = snapshot.data;

                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      //   child: Container(
                      height: 200,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,15,0,0),
                            child: CircleAvatar(
                              radius: 65,
                              child: ClipOval(

                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data['image_url']
                                  ),
                                  radius: 62,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['firstName'],
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Arial',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        //   child: Container(
                        height: 40,
                        color: Colors.grey[900],
                        child: const Center(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      //   child: Container(
                      height: 40,
                      color: Colors.grey[900],
                      child: const Center(
                        child: TextButton(
                          onPressed: _launchUrl,
                          child: Text(
                            "Celestial Biscuit IGDTUW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  About()),
                        );},
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        //   child: Container(
                        height: 40,
                        color: Colors.grey[900],
                        child: const Center(
                          child: Text(
                            "About Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      //   child: Container(
                      height: 40,
                      color: Colors.grey[900],
                      child:  Center(
                        child: TextButton(
                          onPressed:() async{
                            String email = Uri.encodeComponent("celestialbiscuitigdtuw.016@gmail.com");
                            String subject = Uri.encodeComponent("Request to include a drive in donation_app");
                            String body = Uri.encodeComponent("Please include \n\n 1) drive name\n 2)drive date\n 3)drive venue \n 4)description of donation drive \n 5)Donation drive manager-contact details");
                            // print(subject); //output: Hello%20Flutter
                            Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {
                              //email app opened
                            }else{
                              //email app is not opened
                            }
                          },
                          child: const Text(
                            "Request To add a donation drive",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      //   child: Container(
                      height: 40,
                      color: Colors.grey[900],
                      child:  Center(
                        child: TextButton(
                          onPressed:() async{
                            String email = Uri.encodeComponent("celestialbiscuitigdtuw.016@gmail.com");
                            String subject = Uri.encodeComponent("");
                            String body = Uri.encodeComponent("");
                            // print(subject); //output: Hello%20Flutter
                            Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {
                              //email app opened
                            }else{
                              //email app is not opened
                            }
                          },
                          child: const Text(
                            "Mail us",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    TextButton(
                      onPressed: () {
                        signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        //   child: Container(
                        height: 40,
                        color: Colors.grey[900],
                        child: const Center(
                          child: Text(
                            "Log out",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      //   child: Container(
                      height: 80,
                      color: Colors.grey[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed:() async{
                              const url = "https://www.linkedin.com/company/celestial-biscuit-igdtuw/mycompany/";
                              final Uri _url = Uri.parse(url);
                              await launchUrl(_url,mode: LaunchMode.externalApplication);
                            } ,
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset('assets/linkedin.png' ,
                                  height: 40, width: 40),
                            ),
                          ),
                          TextButton(
                            onPressed:() async{
                              const url = "https://www.instagram.com/celestialbiscuit/";
                              final Uri _url = Uri.parse(url);
                              await launchUrl(_url,mode: LaunchMode.externalApplication);
                            } ,
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset('assets/instagram.png',
                                  height: 40, width: 40),
                            ),
                          ),
                          TextButton(
                            onPressed:() async{
                              const url = "https://twitter.com/cbigdtuw";
                              final Uri _url = Uri.parse(url);
                              await launchUrl(_url,mode: LaunchMode.externalApplication);
                            } ,
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset('assets/twitter.png',
                                  height: 40, width: 40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data");
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
    );
  }

}