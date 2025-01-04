import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursesInfoCard extends StatefulWidget {
  const CoursesInfoCard({super.key});
  @override
  State<StatefulWidget> createState() => _CoursesInfoCardState();
}

class _CoursesInfoCardState extends State<CoursesInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Center(
                    child: Text(
                      "0",
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("已选",
                    style: GoogleFonts.notoSerif(fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                    margin: EdgeInsets.zero,
                    child: Center(
                      child: Text(
                        "0",
                        style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("已修",
                    style: GoogleFonts.notoSerif(fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                    margin: EdgeInsets.zero,
                    child: Center(
                      child: Text(
                        "0",
                        style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("待重修",
                    style: GoogleFonts.notoSerif(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
