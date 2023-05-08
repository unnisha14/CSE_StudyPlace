import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> company_list = <String>[
  'Amazon',
  'Microsoft',
  'Adobe',
  'DE Shaw',
  'Delhivery',
  'Oracle',
  'Optum'
];
String company = company_list.first;
String? email;
int r = 217, g = 167, b = 246;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCz_OymCd0iscjRzrDrSRaoMkh0swIBk2w",
          appId: "1:389747213374:android:6c46773472dff992c7bd6f",
          messagingSenderId: "389747213374",
          projectId: "fir-flutter-6677f"));
  runApp(MaterialApp(home: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (FirebaseAuth.instance.currentUser != null) return Home();
    return MyLogin();
  }
}

signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyLogin()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    email = FirebaseAuth.instance.currentUser?.email.toString();

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Home"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          MaterialButton(
                            splashColor: Colors.teal,
                            elevation: 6,
                            child: Container(
                              width: 150,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/sem_icon.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Semester()));
                            },
                          ),
                          MaterialButton(
                              splashColor: Colors.redAccent,
                              elevation: 6,
                              child: Container(
                                width: 150,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/interview_icon.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Interview()));
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          MaterialButton(
                              splashColor: Colors.redAccent,
                              elevation: 6,
                              child: Container(
                                width: 150,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/course_icon.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Courses()));
                              }),
                          MaterialButton(
                            splashColor: Colors.teal,
                            elevation: 6,
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              width: 150,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/blog_icon.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Blog()));
                            },
                          )
                        ],
                      ),
                    ],
                  ))),
        )
      ],
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => Login();
}

class Login extends State<MyLogin> {
  final emailId = TextEditingController();
  final password = TextEditingController();
  bool pass = false;

  @override
  void initState() {
    super.initState();
    pass = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Image.asset(
          "assets/images/bg_login.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("L O G I N"),
            backgroundColor: Colors.deepPurple,
          ),
          body: Container(
              margin: EdgeInsets.all(20.0),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 60.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                        ),
                        controller: emailId,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 60.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    pass = !pass;
                                  },
                                );
                              },
                              icon: Icon(pass
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          labelText: "Password",
                        ),
                        controller: password,
                        obscureText: pass,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 60.0),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailId.text.toString().trim(),
                                        password: password.text);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } catch (e) {
                                print('the error done ${e.toString()}');
                              }
                            },
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30.0),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: TextButton(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAccount()));
                              })),
                    ),
                  ],
                ),
              ))),
        )
      ],
    );
  }
}

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => CreateAcc();
}

class CreateAcc extends State<CreateAccount> {
  final emailId = TextEditingController();
  final password = TextEditingController();
  bool pass = false;

  @override
  void initState() {
    super.initState();
    pass = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_login.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("Create Account"),
              backgroundColor: Colors.deepPurple,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 60.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        suffixIcon: Icon(Icons.email),
                      ),
                      controller: emailId,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  pass = !pass;
                                },
                              );
                            },
                            icon: Icon(pass
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        labelText: "Password",
                      ),
                      controller: password,
                      obscureText: pass,
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50.0),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: TextButton(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailId.text.toString().trim(),
                                password: password.text,
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print('the error done ${e.toString()}');
                            }
                          }))
                ],
              ),
            ))
      ],
    );
  }
}

class Semester extends StatelessWidget {
  late List<String> sem_sub = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    sem_sub.add("CSE Fundamentals Languages C, C++, Java etc.");
    sem_sub.add("Start Doing DSA and Read Concepts of OOPs");
    sem_sub.add(
        "Start practicing basic questions on Leetcode or Codechef or anywhere you like");
    sem_sub.add("Now solve DSA sheets of Striver, Love Babbar, etc.");
    sem_sub.add(
        "Let’s start with the other major topics like Data Analytics, Machine Learning etc.");
    sem_sub.add(
        "Learn the topics thoroughly and start doing small projects, come up with ideas.");
    sem_sub.add(
        "Now, this is a life changing semester brush up your DSA skills to master level.");
    sem_sub.add("Now relax and share your journey to the juniors.");
    var rand = Random();
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Semesters"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Material_Semester(
                                      id: index,
                                    )));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.deepPurple,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 15.0),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(151, 72, 185, 100),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text(
                                sem_sub[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        )
      ],
    );
  }
}

class Material_Semester extends StatelessWidget {
  late final Stream<QuerySnapshot> note;
  int id;
  Material_Semester({required this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (id) {
      case 0:
        note = FirebaseFirestore.instance.collection('Sem-1 Notes').snapshots();
        break;
      case 1:
        note = FirebaseFirestore.instance.collection('Sem-2 Notes').snapshots();
        break;
      case 2:
        note = FirebaseFirestore.instance.collection('Sem-3 Notes').snapshots();
        break;
      case 3:
        note = FirebaseFirestore.instance.collection('Sem-4 Notes').snapshots();
        break;
      case 4:
        note = FirebaseFirestore.instance.collection('Sem-5 Notes').snapshots();
        break;
      case 5:
        note = FirebaseFirestore.instance.collection('Sem-6 Notes').snapshots();
        break;
      case 6:
        note = FirebaseFirestore.instance.collection('Sem-7 Notes').snapshots();
        break;
      case 7:
        note = FirebaseFirestore.instance.collection('Sem-8 Notes').snapshots();
        break;
    }

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text("Semester " + (id + 1).toString()),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    signOut(context);
                  },
                  tooltip: 'Sign Out',
                  icon: Icon(Icons.logout),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: StreamBuilder(
                  stream: note,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot = snapshot
                                  .data
                                  ?.docs[index] as DocumentSnapshot<Object?>;
                              String subject = documentSnapshot.reference.id
                                  .toString()
                                  .toUpperCase();
                              subject = subject.replaceAll("_", " ");
                              return Card(
                                  margin: EdgeInsets.all(10.0),
                                  color: Color.fromRGBO(151, 72, 185, 100),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(10.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                subject,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 15.0),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            69, 10, 115, 1.0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    child: new TextButton(
                                                      onPressed: () async {
                                                        Uri _url = Uri.parse(
                                                            documentSnapshot[
                                                                'book']);
                                                        if (!await launchUrl(
                                                            _url)) {
                                                          throw Exception(
                                                              'Could not launch $_url');
                                                        }
                                                      },
                                                      child: Text(
                                                        "Books",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            69, 10, 115, 1.0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    child: new TextButton(
                                                      onPressed: () async {
                                                        Uri _url = Uri.parse(
                                                            documentSnapshot[
                                                                'note']);
                                                        if (!await launchUrl(
                                                            _url)) {
                                                          throw Exception(
                                                              'Could not launch $_url');
                                                        }
                                                      },
                                                      child: Text(
                                                        "Notes",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              69, 10, 115, 1.0),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                      child: new TextButton(
                                                        onPressed: () async {
                                                          Uri _url = Uri.parse(
                                                              documentSnapshot[
                                                                  'reference']);
                                                          if (!await launchUrl(
                                                              _url)) {
                                                            throw Exception(
                                                                'Could not launch $_url');
                                                          }
                                                        },
                                                        child: Text(
                                                          "You Tube",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(15.0),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                documentSnapshot['syllabus'],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )));
                            });
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ))
      ],
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class Interview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("INTERVIEW"),
            titleSpacing: 2.0,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, childAspectRatio: 1),
              itemCount: company_list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("AlertDialog"),
                              content: Text("Choose One!"),
                              actions: [
                                TextButton(
                                  child: Text("Intern"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Experience(
                                                  company_name:
                                                      company_list[index]
                                                          .toLowerCase(),
                                                  choice: "intern",
                                                )));
                                  },
                                ),
                                TextButton(
                                  child: Text("Placement"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Experience(
                                                  company_name:
                                                      company_list[index]
                                                          .toLowerCase(),
                                                  choice: "placement",
                                                )));
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      company_list[index],
                      style: TextStyle(color: Color.fromRGBO(42, 4, 58, 1.0)),
                    ),
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(300, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        overlayColor: MaterialStateProperty.all(
                            const Color.fromRGBO(217, 167, 246, 100)),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                              fontSize: 33, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(151, 72, 185, 100))),
                  ),
                );
              }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Add_Experience()));
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class Add_Experience extends StatelessWidget {
  final name = TextEditingController();
  final branch = TextEditingController();
  final no_of_rounds = TextEditingController();
  final tips = TextEditingController();
  final ip = TextEditingController();
  final linkedin = TextEditingController();
  final profile = TextEditingController();
  final year = TextEditingController();
  final position = TextEditingController();
  late final List<TextEditingController> rounds = [
    for (int i = 0; i < 10; i++) TextEditingController()
  ];
  String choice = "placement";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Add Experience"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            color: Color.fromRGBO(151, 72, 185, 100),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //choose intern or placement
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Type I for Intern and P for placement",
                      ),
                      controller: ip,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  //role
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Position/Role",
                      ),
                      controller: position,
                    ),
                  ),
                  //year
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Year",
                      ),
                      controller: year,
                    ),
                  ),
                  //name
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                      controller: name,
                    ),
                  ),
                  //branch no of rounds company
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Branch",
                            ),
                            controller: branch,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "No of Rounds",
                            ),
                            controller: no_of_rounds,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        dropDown(),
                      ],
                    ),
                  ),
                  //round
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          String r = "Round " + (index + 1).toString();
                          return Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: TextField(
                              controller: rounds[index],
                              decoration: InputDecoration(
                                labelText: r,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          );
                        }),
                  ),
                  //linkedin
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "LinkedIn",
                      ),
                      controller: linkedin,
                    ),
                  ),
                  //profile/resume link
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Profile Link / Resume Link",
                      ),
                      controller: profile,
                    ),
                  ),
                  //tips
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Tips",
                      ),
                      controller: tips,
                    ),
                  ),
                  //write data
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        List<String> round_detail = [];
                        for (int i = 0; i < int.parse(no_of_rounds.text); i++) {
                          round_detail.add(rounds[i].text);
                        }
                        if (ip.text == "I")
                          choice = "intern";
                        else
                          choice = "placement";
                        String data = company.toLowerCase() + "-" + choice;
                        if (!company_list.contains(company))
                          company_list.add(company);
                        CollectionReference cf =
                            FirebaseFirestore.instance.collection(data);
                        cf.add({
                          'name': name.text,
                          'branch': branch.text,
                          'role': position.text,
                          'no_of_rounds': int.parse(no_of_rounds.text),
                          'rounds': round_detail,
                          'year': year.text,
                          'linkedin': linkedin.text,
                          'profile': profile.text,
                          'tips': tips.text
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 75.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 30.0),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Text(
                          "DONE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class dropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownCompany();
}

class DropDownCompany extends State<dropDown> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      value: company,
      dropdownColor: Colors.deepPurple,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          company = value!;
        });
      },
      items: company_list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}

class Experience extends StatelessWidget {
  String company_name, choice;
  Experience({required this.company_name, required this.choice});
  String collection = "";
  late final Stream<QuerySnapshot> company;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (choice == "intern")
      collection = company_name + "-intern";
    else
      collection = company_name + "-placement";
    company = FirebaseFirestore.instance.collection(collection).snapshots();
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(company_name.toUpperCase()),
            titleSpacing: 30.0,
            backgroundColor: Colors.deepPurple,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: StreamBuilder(
            stream: company,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = snapshot
                            .data?.docs[index] as DocumentSnapshot<Object?>;

                        return Card(
                            margin: EdgeInsets.all(25.0),
                            color: Color.fromRGBO(151, 72, 185, 100),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  //role
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        documentSnapshot['role'],
                                      ),
                                    ),
                                  ),
                                  //rounds
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount:
                                            documentSnapshot['no_of_rounds'],
                                        itemBuilder: (context, idx) {
                                          return Text(
                                              documentSnapshot['rounds'][idx]);
                                        }),
                                  ),
                                  //tips
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        documentSnapshot['tips'],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        //name
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Text(
                                            documentSnapshot['name'],
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                        //branch
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Text(
                                            documentSnapshot['branch'],
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                        //year
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Text(
                                            documentSnapshot['year'] + " year",
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //linkedin and resume link
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(15.0),
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  69, 10, 115, 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0))),
                                          child: new TextButton(
                                            onPressed: () async {
                                              Uri _url = Uri.parse(
                                                  documentSnapshot['linkedin']);
                                              if (!await launchUrl(_url)) {
                                                throw Exception(
                                                    'Could not launch $_url');
                                              }
                                            },
                                            child: Text(
                                              "Linkedin Profile",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  69, 10, 115, 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0))),
                                          child: new TextButton(
                                            onPressed: () async {
                                              Uri _url = Uri.parse(
                                                  documentSnapshot['profile']);
                                              if (!await launchUrl(_url)) {
                                                throw Exception(
                                                    'Could not launch $_url');
                                              }
                                            },
                                            child: Text(
                                              "Resume / Profile Link",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      });
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
    throw UnimplementedError();
  }
}

class Courses extends StatelessWidget {
  //final Uri _url = Uri.parse('https://flutter.dev');
  final List<String> course = <String>[
    'https://youtube.com/playlist?list=PLu0W_9lII9ahIappRPN0MCAgtOu3lQjQi',
    'https://youtube.com/playlist?list=PLDzeHZWIZsTryvtXdMr6rPh4IDexB5NIA',
    'https://youtube.com/playlist?list=PLjVLYmrlmjGdDps6HAwOOVoAtBPAgIOXL'
  ];
  final List<String> name = <String>[
    "DSA Course by CodewithHarry",
    "DSA Course by Love Babbar",
    "Android Development Course"
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("COURSES"),
            titleSpacing: 12.0,
            backgroundColor: Colors.deepPurple,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(15.0),
            itemCount: course.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 2.0)
                      ]),
                  child: new GestureDetector(
                    onTap: () async {
                      Uri _url = Uri.parse(course[index]);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    child: Text(
                      name[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}

class Blog extends StatelessWidget {
  late final Stream<QuerySnapshot> blog =
      FirebaseFirestore.instance.collection("blog_data").snapshots();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Blogs",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_alert,
                  color: Colors.white,
                ),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: StreamBuilder(
              stream: blog,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = snapshot
                              .data?.docs[index] as DocumentSnapshot<Object?>;
                          return Card(
                              margin: EdgeInsets.all(10.0),
                              color: Color.fromRGBO(151, 72, 185, 100),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(15.0),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            documentSnapshot['title'],
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      padding: EdgeInsets.all(10.0),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            documentSnapshot['description'],
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          )),
                                    ),
                                    Container(
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: TextButton(
                                            onPressed: () async {
                                              Uri _url = Uri.parse(
                                                  documentSnapshot['linkedin']);
                                              if (!await launchUrl(_url)) {
                                                throw Exception(
                                                    'Could not launch $_url');
                                              }
                                            },
                                            child: Text(
                                              documentSnapshot['name'],
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add_Blog()));
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class Add_Blog extends StatelessWidget {
  final linkedin = TextEditingController();
  final name = TextEditingController();
  final title = TextEditingController();
  final description = TextEditingController();
  final CollectionReference blog =
      FirebaseFirestore.instance.collection("blog_data");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_main.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Add Blog"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_alert),
                tooltip: 'Notification',
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: Container(
            color: Color.fromRGBO(151, 72, 185, 100),
            margin: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //name
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Name",
                        ),
                        controller: name,
                      ),
                    ),
                    //linkedin
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Linkedin",
                        ),
                        controller: linkedin,
                      ),
                    ),
                    //title
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                        controller: title,
                      ),
                    ),
                    //descp
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                        controller: description,
                      ),
                    ),
                    //write
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          blog.add({
                            'title': title.text.toString(),
                            'description': description.text.toString(),
                            'linkedin': linkedin.text.toString(),
                            'name': name.text.toString()
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 75.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30.0),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: Text(
                            "DONE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
