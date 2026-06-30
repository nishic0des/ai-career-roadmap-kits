import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapScreen extends StatelessWidget {
  final String roadmap;
  RoadmapScreen({super.key, required this.roadmap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Roadmap"),),
      body:Markdown(data: roadmap,selectable: true, padding: EdgeInsets.all(16.sp),)
    );
  }
}
