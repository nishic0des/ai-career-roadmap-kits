import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kits/screens/skill_assessment_screen.dart';

class CareerDetailsScreen extends StatelessWidget {
  CareerDetailsScreen({super.key, required this.title, required this.icon});

  String title;
  IconData icon;

  static const Map<String, String> descriptions = {
    "Flutter Developer":
        "Develop mobile applications using Flutter framework, create responsive and high-performance apps for iOS and Android.",
    "AI Engineer":
        "Build and deploy intelligent systems using machine learning and deep learning algorithms, create AI-powered applications.",
    "Data Scientist":
        "Analyze and interpret data using statistical and machine learning techniques, create data-driven solutions.",
    "Web Developer":
        "Develop web applications using HTML, CSS, and JavaScript, create responsive and high-performance web applications.",
    "UI/UX Designer":
        "Design user interfaces and user experiences for web and mobile applications, create intuitive and user-friendly interfaces.",
    "Cyber Security":
        "Protect systems and networks from cyber threats, create secure and reliable applications.",
  };

  Map<String, List<String>> skills = {
    "Flutter Developer": ["Dart", "Widgets", "APIs", "Git"],
    "AI Engineer": ["Python", "ML", "DL", "TensorFlow"],
    "Data Scientist": ["Python", "R", "SQL", "Data Visualization"],
    "Web Developer": ["HTML", "CSS", "JavaScript", "React"],
    "UI/UX Designer": ["Figma", "Adobe XD", "Prototyping", "User Research"],
    "Cyber Security": [
      "Network Security",
      "Cyber Threat Intelligence",
      "Incident Response",
      "Security Architecture",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 20.h),
                  _buildDescription(context),
                  SizedBox(height: 20.h),
                  _buildSkills(context),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: const Color.fromARGB(255, 196, 184, 219),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Interested in this career?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SkillAssessmentScreen(career: title),
                          ),
                        ),
                      },
                      icon: Icon(Icons.bookmark_outline),
                      label: Text("Get Roadmap"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color.fromARGB(255, 153, 134, 204),
              child: Icon(icon, size: 30, color: Colors.black),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Career Overview",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About this role",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(height: 24),
            Text(
              descriptions[title]!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Key Skills",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                for (final skill in skills[title]!)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Chip(
                        label: Text(skill, overflow: TextOverflow.ellipsis),
                        backgroundColor: const Color.fromARGB(
                          255,
                          171,
                          151,
                          225,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
