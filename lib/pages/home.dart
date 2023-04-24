import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/account.dart';
import 'package:smallservices/pages/drawer.dart';
import 'package:smallservices/pages/notifications.dart';
import 'package:smallservices/pages/reportScreen.dart';
import 'package:smallservices/pages/viewServices.dart';
import 'package:smallservices/pages/workers.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static List<Map<String, dynamic>>? users;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final databaseReference = FirebaseDatabase.instance.ref();
  static List<List<String>> services = [];
  static List<List<String>> orders = [];

  // static List<List<String>> users = [];

  // List<Service> services = [
  //   Service('Cleaning',
  //       'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
  //   Service('Plumber',
  //       'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
  //   Service('Electrician',
  //       'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
  //   Service('Painter',
  //       'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
  //   Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
  //   Service('Gardener',
  //       'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
  // ];

  // static List<dynamic> workers = [
  //   [
  //     'Dala Krayem',
  //     'طباخ',
  //     'https://img.icons8.com/fluency/1x/gender-neutral-user.png'
  //   ],
  //   [
  //     'Ziead Shab Kalieh',
  //     'الكتروني',
  //     'https://img.icons8.com/fluency/1x/gender-neutral-user.png'
  //   ],
  //   [
  //     'Brenon Kalu',
  //     'دهان',
  //     'https://img.icons8.com/fluency/1x/gender-neutral-user.png'
  //   ]
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'لوحة التحكم',
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Auth().logout(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey.shade700,
                  size: 30,
                ))
          ],
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade700,
              size: 30,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          )),
      body: Builder(builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        if (_selectedIndex == 0) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // for users
                FadeAnimation(
                    1,
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportScreen()
                                  ),
                                );
                              },
                              child: Text(
                                'عرض الكل',
                              )),
                          Text(
                            'طلباتي',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                FadeAnimation(
                  1.2,
                  FutureBuilder<List<List<String>>>(
                    future: Auth().getOrders(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<List<String>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          orders = snapshot.data!;
                          print(orders);
                          return Container(
                            height: size.height / 4,
                            width: size.width - 20,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: orders.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Container(
                                      padding: EdgeInsets.all(20.0),
                                      height: size.height / 4,
                                      width: size.width - 110,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 4),
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Image.network(
                                                    orders[index][1],
                                                    width: 70,
                                                  )),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    orders[index][0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${DateTime.now().year} ${orders[index][3]}",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            child: Center(
                                                child: Text(
                                              'عرض المزيد',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    1.3,
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewServices(),
                                  ),
                                );
                              },
                              child: const Text(
                                'عرض الكل',
                              )),
                          const Text(
                            'الخدمات',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                FutureBuilder<List<List<String>>>(
                  future: Auth().getServices(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<List<String>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        services = snapshot.data!;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: 300,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return FadeAnimation(
                                (1.0 + index) / 4,
                                serviceContainer(services[index][1],
                                    services[index][0], index),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Auth.isManager
                    ? FadeAnimation(
                        1.3,
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Worker(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'عرض الكل',
                                  )),
                              const Text(
                                'المستخدمين',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                    : const SizedBox(),

                StreamBuilder<QuerySnapshot>(
                  stream:
                      Auth.firebaseFirestore.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    users = snapshot.data!.docs
                        .map((doc) => doc.data() as Map<String, dynamic>)
                        .toList();
                    return Auth.isManager
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 120,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: users!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var user = users![index];
                                  return FadeAnimation(
                                      (1.0 + index) / 4,
                                      workerContainer(
                                          user['username'] ?? '',
                                          user['imageURL'] ?? '',
                                          user['career'] ?? '',
                                          user['position'] ?? ''));
                                }),
                          )
                        : const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          );
        } else if (_selectedIndex == 1) {
          return Notifications();
        } else if (_selectedIndex == 2) {
          return const Account();
        } else {
          return const SizedBox();
        }
      }),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'الاشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 47),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 13),
              )
            ]),
      ),
    );
  }

  static workerContainer(String name, String image, String job, String pos) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(image)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      job,
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  pos,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]),
        ),
      ),
    );
  }
}
