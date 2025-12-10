import 'package:flutter/material.dart';

class CreditEarnCard extends StatelessWidget {
  const CreditEarnCard(
      {super.key,
      required this.weightedAverageScore,
      required this.name,
      required this.studentNumber});
  final String weightedAverageScore;
  final String name;
  final String studentNumber;
  @override
  Widget build(context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Stack(children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "加权",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            weightedAverageScore,
                            style: TextStyle(
                                fontFamily: "NotoSerif",
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(name),
                                Icon(Icons.badge_outlined),
                              ],
                            ),
                            Row(
                              children: [
                                Text(studentNumber),
                                Icon(Icons.numbers_outlined)
                              ],
                            )
                          ])
                    ],
                  )),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.badge_outlined,
              size: 100,
              color: Color.fromARGB(40, 0, 0, 0),
            ),
          )
        ]));
  }
}
