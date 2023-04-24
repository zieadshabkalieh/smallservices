import 'package:flutter/material.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/cleaning.dart';
import 'package:smallservices/pages/home.dart';

class SelectService extends StatefulWidget {
  const SelectService({ Key? key }) : super(key: key);

  @override
  SelectServiceState createState() => SelectServiceState();
}

class SelectServiceState extends State<SelectService> {

  List<List<String>> services = DashboardScreenState.services;


  // List<Services> services;
  // List<Service> services = [
  //   Service('تنظيف', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
  //   Service('مكياج', 'https://img.icons8.com/external-photo3ideastudio-flat-photo3ideastudio/256/external-makeup-supermarket-photo3ideastudio-flat-photo3ideastudio.png'),
  //   Service('الكتروني', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
  //   Service('دهان', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
  //   Service('كهرباء', 'https://img.icons8.com/fluency/2x/drill.png'),
  //   Service('مزارع', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
  //   Service('خياط', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
  //   Service('مساج', 'https://img.icons8.com/external-flaticons-lineal-color-flat-icons/1x/external-massage-tropical-flaticons-lineal-color-flat-icons-3.png'),
  //   Service('صحية', 'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
  //   Service('طباخ', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-cooking-daily-routine-wanicon-flat-wanicon.png'),
  //   Service('مبلط', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-cooking-daily-routine-wanicon-flat-wanicon.png'),
  //   Service('نجار', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-cooking-daily-routine-wanicon-flat-wanicon.png'),
  // ];

  int selectedService = -1;
  static int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: selectedService >= 0 ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CleaningPage(index: index, name: services[index][0], imageURL: services[index][1], question: services[index][2],),
            ),
          );
        },
        child: Icon(Icons.arrow_forward_ios, size: 20,),
        backgroundColor: Colors.blue,
      ) : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(1.2, Padding(
                padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'اي خدمة تريد؟',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 40,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                   child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeAnimation((1.0 + index) / 4, serviceContainer(services[index][1], services[index][0], index));
              }
        ),
                ),
            ]
          ),
        ),
      ),

    );
  }
  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else
            selectedService = index;
          SelectServiceState.index = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.blue.shade50 : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.blue : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 80),
              SizedBox(height: 20,),
              Text(name, style: TextStyle(fontSize: 13),)
            ]
        ),
      ),
    );
  }
}
