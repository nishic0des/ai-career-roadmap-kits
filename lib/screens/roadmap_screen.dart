import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapScreen extends StatefulWidget {
  final String career;
  final IconData icon;
  final String roadmap;
  const RoadmapScreen({
    super.key,
    required this.career,
    required this.icon,
    required this.roadmap,
  });

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Roadmap")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Roadmap saved")));
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      body: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          
          position: slideAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.career,
                          child: CircleAvatar(
                            
                            radius: 30,
                            child: Icon(widget.icon, size: 45),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          widget.career,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Learning Progress",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: 0.75),
                          duration: Duration(seconds: 2),
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                LinearProgressIndicator(value: value),
                                SizedBox(height: 5),
                                Text('${value * 100.round()}%'),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2.r,
                              ),
                            ],
                          ),
                          child: MarkdownBody(
                            data: widget.roadmap,
                            selectable: true,
                          ),
                        ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
