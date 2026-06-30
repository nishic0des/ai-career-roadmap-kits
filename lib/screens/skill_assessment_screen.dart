import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kits/services/openai_service.dart';
import 'package:kits/screens/roadmap_screen.dart';

class SkillAssessmentScreen extends StatefulWidget {
  final String career;
  const SkillAssessmentScreen({super.key, required this.career});

  @override
  State<SkillAssessmentScreen> createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final technologies = careerTechnologies[widget.career] ?? [];
    for (final tech in technologies) {
      selectedTechnologies[tech] = false;
    }
  }

  final TextEditingController nameController = TextEditingController();

  String programmingLevel = "Beginner";

  double studyHours = 5;
  String learningMode = "Videos";

  Map<String, List<String>> careerTechnologies = {
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

  Map<String, bool> selectedTechnologies = {};
  List<String> flutterTechnologies = ["Dart", "Widgets", "APIs", "Git"];
  List<String> aiTechnologies = ["Python", "ML", "DL", "TensorFlow"];
  List<String> dataScienceTechnologies = [
    "Python",
    "R",
    "SQL",
    "Data Visualization",
  ];
  List<String> uiUxTechnologies = [
    "Figma",
    "Adobe XD",
    "Prototyping",
    "User Research",
  ];
  List<String> cyberSecurityTechnologies = [
    "Network Security",
    "Cyber Threat Intelligence",
    "Incident Response",
    "Security Architecture",
  ];

  Map<String, bool> flutterTech = {
    "Dart": false,
    "Widgets": false,
    "APIs": false,
    "Git": false,
  };

  bool dart = false;
  bool widgets = false;
  bool apis = false;
  bool git = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Skill Assessment",
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.career,
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                "Programming Level",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                value: "Beginner",
                title: Text("Beginner"),
                groupValue: programmingLevel,
                onChanged: (value) {
                  setState(() {
                    programmingLevel = value!;
                  });
                },
              ),
              RadioListTile(
                value: "Intermediate",
                title: Text("Intermediate"),
                groupValue: programmingLevel,
                onChanged: (value) {
                  setState(() {
                    programmingLevel = value!;
                  });
                },
              ),
              RadioListTile(
                value: "Expert",
                title: Text("Expert"),
                groupValue: programmingLevel,
                onChanged: (value) {
                  setState(() {
                    programmingLevel = value!;
                  });
                },
              ),
              Divider(),
              Text(
                "Technologies you know",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: selectedTechnologies.keys.map((technology) {
                  return CheckboxListTile(
                    title: Text(technology),
                    value: selectedTechnologies[technology],
                    onChanged: (value) {
                      setState(() {
                        selectedTechnologies[technology] = value!;
                        print("Selected Technologies: $selectedTechnologies");
                        print("Technology: $technology");
                        print("Value: $value");
                      });
                    },
                  );
                }).toList(),
              ),
              Divider(),
              Text(
                "Study Hours per Week",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                min: 1,
                max: 40,
                divisions: 39,
                value: studyHours,
                label: studyHours.round().toString(),
                onChanged: (value) {
                  setState(() {
                    studyHours = value;
                  });
                },
              ),
              Center(child: Text("${studyHours.round()} hours per week")),
              SizedBox(height: 20),
              DropdownButtonFormField(
                value: learningMode,
                decoration: InputDecoration(
                  labelText: "Learning Mode",
                  border: OutlineInputBorder(),
                ),
                items: ["Videos", "Books", "Articles", "Projects"].map((mode) {
                  return DropdownMenuItem(value: mode, child: Text(mode));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    learningMode = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    final selectedSkills = selectedTechnologies.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final service = OpenAIService();
                      final roadmap = await service.generateRoadmap(
                        name: nameController.text,
                        career: widget.career,
                        level: programmingLevel,
                        skills: selectedSkills,
                        studyHours: studyHours,
                        learningMode: learningMode,
                      );

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoadmapScreen(roadmap: roadmap),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Error generating roadmap. Please try again later.",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } finally {
                      isLoading = false;
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
