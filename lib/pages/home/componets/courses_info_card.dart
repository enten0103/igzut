import 'package:flutter/material.dart';

class CoursesInfoCard extends StatelessWidget {
  const CoursesInfoCard(
      {super.key,
      required this.all,
      required this.pass,
      required this.failed,
      required this.score});
  final int all;
  final int pass;
  final int failed;
  final String score;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "课程",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.radar_outlined),
                              Text(" 已修学分 $score",
                                  style: TextStyle(fontFamily: "NotoSerif"))
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_unchecked_outlined),
                              Text(" 已选课程 $all",
                                  style: TextStyle(fontFamily: "NotoSerif"))
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_checked_outlined),
                              Text(" 通过课程 $pass",
                                  style: TextStyle(fontFamily: "NotoSerif"))
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.cancel_outlined),
                              Text(" 未过课程 $failed ",
                                  style: TextStyle(fontFamily: "NotoSerif"))
                            ],
                          )),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
