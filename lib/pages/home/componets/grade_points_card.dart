import 'package:flutter/material.dart';

class GradePointsCard extends StatelessWidget {
  const GradePointsCard(
      {super.key,
      required this.gradePoint,
      required this.administrativeClass,
      required this.college});
  final String gradePoint;
  final String administrativeClass;
  final String college;
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
                  "绩点",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontFamily: "NotoSerif"),
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
                            gradePoint,
                            style: TextStyle(
                                fontFamily: "NotoSerif",
                                fontSize: 48,
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
                                Text(college),
                                Icon(Icons.school_outlined),
                              ],
                            ),
                            Row(
                              children: [
                                Text(administrativeClass),
                                Icon(Icons.class_outlined)
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
              Icons.school_outlined,
              size: 100,
              color: Color.fromARGB(40, 0, 0, 0),
            ),
          )
        ]));
  }
}
