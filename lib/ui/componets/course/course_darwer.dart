import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDarwer extends StatefulWidget {
  const CourseDarwer({super.key, required this.natures});

  final List<String> natures;

  @override
  State<CourseDarwer> createState() => _CourseDarwerState();
}

class _CourseDarwerState extends State<CourseDarwer> {
  ///课程通过状态
  /// 未考察
  /// 已通过
  /// 未通过
  var courseState = [true, true, true];

  ///修读必要性
  ///必修
  ///非必修
  var necessity = [true, true];

  ///课程性质
  var natures = [];
  @override
  void initState() {
    setState(() {
      natures = List.filled(widget.natures.length, true);
    });
    super.initState();
  }

  void submit() {}

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("通过状态", style: GoogleFonts.notoSerif(fontSize: 18)),
                SizedBox(height: 5),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            courseState[0] = !courseState[0];
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: courseState[0]
                                ? colorTheme.primary
                                : colorTheme.surfaceContainer),
                        child: Text(
                          "未考察",
                          style: GoogleFonts.notoSerif(
                              color: courseState[0]
                                  ? colorTheme.onPrimary
                                  : colorTheme.onSurface),
                        )),
                    SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            courseState[1] = !courseState[1];
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: courseState[1]
                                ? colorTheme.primary
                                : colorTheme.surfaceContainer),
                        child: Text(
                          "已通过",
                          style: GoogleFonts.notoSerif(
                              color: courseState[1]
                                  ? colorTheme.onPrimary
                                  : colorTheme.onSurface),
                        )),
                    SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            courseState[2] = !courseState[2];
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: courseState[2]
                                ? colorTheme.primary
                                : colorTheme.surfaceContainer),
                        child: Text(
                          "未通过",
                          style: GoogleFonts.notoSerif(
                              color: courseState[2]
                                  ? colorTheme.onPrimary
                                  : colorTheme.onSurface),
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Text("修读必要性", style: GoogleFonts.notoSerif(fontSize: 18)),
                SizedBox(height: 5),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            necessity[0] = !necessity[0];
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: necessity[0]
                                ? colorTheme.primary
                                : colorTheme.surfaceContainer),
                        child: Text(
                          "必修",
                          style: GoogleFonts.notoSerif(
                              color: necessity[0]
                                  ? colorTheme.onPrimary
                                  : colorTheme.onSurface),
                        )),
                    SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            necessity[1] = !necessity[1];
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: necessity[1]
                                ? colorTheme.primary
                                : colorTheme.surfaceContainer),
                        child: Text(
                          "选修",
                          style: GoogleFonts.notoSerif(
                              color: necessity[1]
                                  ? colorTheme.onPrimary
                                  : colorTheme.onSurface),
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Text("课程归属", style: GoogleFonts.notoSerif(fontSize: 18)),
                SizedBox(height: 5),
                Wrap(
                  spacing: 10,
                  children: widget.natures
                      .asMap()
                      .map((index, e) {
                        return MapEntry(
                            index,
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    natures[index] = !natures[index];
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: natures[index]
                                        ? colorTheme.primary
                                        : colorTheme.surfaceContainer),
                                child: Text(
                                  e == "" ? "未知" : e,
                                  style: GoogleFonts.notoSerif(
                                      color: natures[index]
                                          ? colorTheme.onPrimary
                                          : colorTheme.onSurface),
                                )));
                      })
                      .values
                      .toList(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.primaryFixed),
                      child: Text("确认")),
                ),
              ],
            )));
  }
}
