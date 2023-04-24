// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/date_time.dart';

// ignore: must_be_immutable
class CleaningPage extends StatefulWidget {
  int index = 0;
  String name;
  String imageURL;
  String question;

  CleaningPage(
      {Key? key,
      required this.index,
      required this.name,
      required this.imageURL,
      required this.question})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // List<dynamic>question = [
  //   'أي غرفة تريد تنظيفها؟',
  //   'اختاري نوع المكياج؟',
  //   'ما هي القطعة الالكترونية المراد صيانتها؟',
  //   'أي غرفة تريد تدهينها؟',
  //   'ماذا تريد تصليحه؟',
  //   'اختر ما تريد زراعتة؟',
  //   'اختر ما تريد خياطته؟',
  //   'اختر نوع المساج؟',
  //   'اختر ما تريد تصليحة',
  //   'اختر ما تريد طبخه'
  // ];

  final databaseReference = FirebaseDatabase.instance.ref();
  List<List<List<String>>> rooms = [];

  List colors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRooms();
  }

  void getRooms() {
    databaseReference.child('Services').onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      var values = dataSnapshot.value;
      rooms.clear();
      if (values is Map) {
        values.forEach((key, item) {
          List<List<String>> allRooms = [];
          if (item is Map) {
            item.forEach((key, value) {
              if (key != "imageURL" && key != "name" && key != "question") {
                List<String> makeup = [
                  value["name"].toString(),
                  value["imageURL"].toString()
                ];
                allRooms.add(makeup);
              }
            });
            rooms.add(allRooms);
          }
        });
      }
      setState(() {
        rooms = rooms;
      });
    });
  }

  // List<dynamic> _rooms = [[
  //   ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //   ['غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //   ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //   ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //   ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  // ],
  //   [
  //     ['ظل للعين', 'https://img.icons8.com/color/1x/eye-shadows.png', Colors.red, 0],
  //     ['فاونديشن', 'https://img.icons8.com/fluency/256/foundation-makeup.png', Colors.orange, 0],
  //     ['مناكير', 'https://img.icons8.com/external-microdots-premium-microdot-graphic/1x/external-makeup-beauty-cosmetics-microdots-premium-microdot-graphic.png', Colors.blue, 0],
  //     ['برش', 'https://img.icons8.com/color-glass/1x/cosmetic-brush.png', Colors.purple, 0],
  //     ['حمرة فم', 'https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/1x/external-Makeup-theater-smashingstocks-flat-smashing-stocks.png', Colors.green, 0]
  //   ],
  //   [
  //     ['كمبيوتر', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['موبايل', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['تاب', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['شواحن', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['نلفاز', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 2],
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0],
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     [ 'غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     [ 'غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     [ 'غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم',
  //       'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     [ 'غرفة نوم', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  //   [
  //     ['غرفة جلوس', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
  //     ['غرفة نوم','https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
  //     ['حمام', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
  //     ['مطبخ', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
  //     ['مكتب', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  //   ],
  // ];
  final List<List<String>> _selectedRooms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _selectedRooms.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DateAndTime(name: widget.name, imageURL: widget.imageURL,question: widget.question, subServices: _selectedRooms,)),
                  );
                },
                backgroundColor: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_selectedRooms.length}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: FadeAnimation(
                1,
                Padding(
                  padding: const EdgeInsets.only(
                      top: 120.0, right: 20.0, left: 20.0),
                  child: Text(
                    widget.question,
                    textAlign: TextAlign.center,
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
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rooms.length > widget.index
                    ? rooms[widget.index].length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation((1.2 + index) / 4,
                      room(rooms[widget.index][index], index));
                }),
          ),
        ));
  }

  room(List room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms.contains(room)) {
            _selectedRooms.remove(room);
          } else {
            _selectedRooms.add(room as List<String>);
          }
        });
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          margin: const EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: _selectedRooms.contains(room)
                ? colors[index].shade50.withOpacity(0.5)
                : Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _selectedRooms.contains(room)
                      ? Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ))
                      : const SizedBox(),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        room[0],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Image.network(
                        room[1],
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
