import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app_igdtuw/models/user_model.dart';
import 'navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: UploadingImageToFirebaseStorage(),
    );
  }
}

class UploadingImageToFirebaseStorage extends StatefulWidget {
  const UploadingImageToFirebaseStorage({Key? key}) : super(key: key);

  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  late io.File imageFile;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('PrintFile: ${pickedFile.toString()}');
      setState(() {
        imageFile = io.File(pickedFile.path);
      });
    } else {
      print('PickedFile: is null');
    }
    if (imageFile != null) {
      return imageFile;
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    late String img_url;
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    uploadTask.whenComplete(() async {
      try {
        img_url = await firebaseStorageRef.getDownloadURL();
      } catch (onError) {
        print("Error");
      }
      return img_url;
    });
  }

  final _auth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  Future<DocumentSnapshot> getDocument() async {
    var user = await FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
  }

  String? fname;
  String? sname;
  // String? phone;
  String? email;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: getDocument(),
            builder: (context, snapshot) {
              final data;
              if (snapshot.hasData) {
                data = snapshot.data;
                return ListView(
                  padding:
                      EdgeInsets.fromLTRB(w * .05, h * 0.05, w * .05, h * 0.01),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => navMainPage()),
                        );
                      },
                      style: ButtonStyle(
                        alignment: Alignment.topLeft,
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: w * .01,
                            vertical: h * .02,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 24.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * .02, h * 0.00, w * .02, h * 0.0),
                      child: CircleAvatar(
                        radius: h * .20,
                        child: ClipOval(
                          child: CircleAvatar(
                              radius: h * .20,
                              child: Image.network(data["image_url"])),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          getImage();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(
                              w * .03, h * .02, w * .03, h * .02),
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(
                            color: Colors.orange,
                            fontSize: h*0.03,
                            //fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                          ),
                        ),
                        child: const Text("Change Photo"),
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    // First Name Field
                    Padding(
                      padding: EdgeInsets.fromLTRB(w * .03, h * .02, w * .03, h * .01),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "First Name",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: h * 0.03,
                                color: Colors.deepOrangeAccent,
                                //fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(height: h * .01),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                fname = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                                hintText: data["firstName"],
                                hintStyle: TextStyle(
                                    fontSize: h * 0.03,
                                    color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: h * .01),

                    // Second Name Field
                    Padding(
                      padding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Second Name",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: h * 0.03,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: h * .01),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                sname = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                                hintText: data["secondName"],
                                hintStyle: TextStyle(
                                    fontSize: h * 0.03, color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: h * .01),

                    // Email Field
                    Padding(
                      padding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: h * 0.03,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: h * .015),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                email = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding: EdgeInsets.fromLTRB(w * .03, h * .01, w * .03, h * .01),
                                hintText: data['email'],
                                hintStyle: TextStyle(
                                    fontSize: h * 0.03,
                                    color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: h * .02),

                    // Save Changes Button
                    Padding(
                      padding: EdgeInsets.fromLTRB(w * .2, h * .01, w * .2, h * .01),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        height: h*0.1,
                        width: w*.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade700,
                              Colors.orange.shade900
                            ],
                          ),
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            postDetailsToFirestore();
                          },
                          child:  Text(
                            'Save Changes',
                            style: TextStyle(fontSize: h * 0.03,color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            textStyle:TextStyle(
                              fontSize: 18,
                              //fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Spartan',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();
    userModel.uid = user?.uid;
    if (fname != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'firstName': fname});
    }
    if (sname != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'secondName': sname});
    }
    if (email != "" && email != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'email': email});
    }
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    await firebaseFirestore.collection("users").doc(user?.uid).update(
        {'image_url': (await firebaseStorageRef.getDownloadURL()).toString()});
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => navMainPage()),
    );
  }
}
