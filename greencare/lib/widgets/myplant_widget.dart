import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyPlantWidget extends StatefulWidget {
  const MyPlantWidget({super.key});

  @override
  State<MyPlantWidget> createState() => _MyPlantWidgetState();
}

class _MyPlantWidgetState extends State<MyPlantWidget> {
  double water_level = 70.7;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CurrentWeatherDetailWidget(),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 150,
                width: 315,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset('assets/icons/humid.png'),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget CurrentWeatherDetailWidget() {
    return Column(
      children: [
        Text(
          'ฟาร์มของคุณ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/icons/humid.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/icons/windspeed.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: CircularPercentIndicator(
              percent: water_level / 100,
              radius: 20,
              lineWidth: 7,
              animation: true,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.white,
            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'น้ำคงเหลือ',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "humidity%",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "weatherDataCurrent.current.windSpeed",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${water_level}%",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
