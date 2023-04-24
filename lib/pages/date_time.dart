
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/home.dart';

class DateAndTime extends StatefulWidget {
  final String name;
  final String imageURL;
  final String question;
  final List<List<String>> subServices;
  const DateAndTime({ Key? key , required this.name,required this.imageURL,required this.question,required this.subServices}) : super(key: key);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';

  ItemScrollController _scrollController = ItemScrollController();


  final List<dynamic> _days = [
    [1, 'الجمعة'],
    [2, 'السبت'],
    [3, 'الأحد'],
    [4, 'الأثنين'],
    [5, 'الثلاثاء'],
    [6, 'الأربعاء'],
    [7, 'الخميس'],
    [8, 'الجمعة'],
    [9, 'السبت'],
    [10, 'الأحد'],
    [11, 'الأثنين'],
    [12, 'الثلاثاء'],
    [13, 'الأربعاء'],
    [14, 'الخميس'],
    [15, 'الجمعة'],
    [16, 'السبت'],
    [17, 'الأحد'],
    [18, 'الأثنين'],
    [19, 'الثلاثاء'],
    [20, 'الأربعاء'],
    [21, 'الخميس'],
    [22, 'الجمعة'],
    [23, 'السبت'],
    [24, 'الأحد'],
    [25, 'الأثنين'],
    [26, 'الثلاثاء'],
    [27, 'الأربعاء'],
    [28, 'الخميس'],
    [29, 'الجمعة'],
    [30, 'السبت'],
    [31, 'الأحد'],
  ];

  final List<String> _hours = <String>[
    '01:00',
    '01:30',
    '02:00',
    '02:30',
    '03:00',
    '03:30',
    '04:00',
    '04:30',
    '05:00',
    '05:30',
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30',
  ];

  final List<String> _repeat = [
    'كل شهر',
    'كل اسبوع',
    'كل يوم',
    'عدم التكرار',
  ];


  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final databaseReference = FirebaseDatabase.instance.ref().child('Users').child(user!.uid).child('Orders');
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              String? orderId = databaseReference.push().key;
              Map<String, dynamic> serviceData = {
                'username' : user.displayName,
                'email' : user.email,
                'name': widget.name,
                'image_url': widget.imageURL,
                'question': widget.question,
                'date' : _days[_selectedDay],
                'time' : _selectedHour,
                'repetition' : _repeat[_selectedRepeat]
              };
              for (int i = 0; i < widget.subServices.length; i++) {
                serviceData[i.toString()] = widget.subServices[i];
              }
              databaseReference.child(orderId!).set(serviceData);
              print(serviceData.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(1, Padding(
                padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'اختر التاريخ والوقت',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 30,),
              FadeAnimation(1, Text("تاريخ اليوم: "+DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(), textAlign: TextAlign.right)),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeAnimation((1 + index) / 6, GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = _days[index][0];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedDay == _days[index][0] ? Colors.blue.shade100.withOpacity(0.5) : Colors.blue.withOpacity(0),
                          border: Border.all(
                            color: _selectedDay == _days[index][0] ? Colors.blue : Colors.white.withOpacity(0),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_days[index][0].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(_days[index][1], style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                    ));
                  }
                ),
              ),
              SizedBox(height: 50,),
              FadeAnimation(1.2, Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _hours.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedHour = _hours[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedHour == _hours[index] ? Colors.orange.shade100.withOpacity(0.5) : Colors.orange.withOpacity(0),
                          border: Border.all(
                            color: _selectedHour == _hours[index] ? Colors.orange : Colors.white.withOpacity(0),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_hours[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              ),
              SizedBox(height: 50,),
              FadeAnimation(1.2, Text("التكرار",textAlign: TextAlign.right, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
              SizedBox(height: 10,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _repeat.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRepeat = index;
                        });
                      },
                      child: FadeAnimation((1.2 + index) / 4, Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _selectedRepeat == index ? Colors.blue.shade400 : Colors.grey.shade100,
                        ),
                        margin: EdgeInsets.only(right: 20),
                        child: Center(child: Text(_repeat[index], 
                          style: TextStyle(fontSize: 18, color: _selectedRepeat == index ? Colors.white : Colors.grey.shade800),)
                        ),
                      )),
                    );
                  },
                )
              ),
              SizedBox(height: 40,),
            ],
          ), 
        ),
      )
    );
  }
}