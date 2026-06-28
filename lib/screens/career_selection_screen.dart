import 'package:flutter/material.dart';
import 'package:kits/screens/career_details_screen.dart';
// import 'package:kits/screens/career_details_screen.dart';

class CareerSelectionScreen extends StatelessWidget {
  CareerSelectionScreen({super.key});

  final List<int> ints = [1, 2, 3, 4];

  Map<String, dynamic> map = {"word": 1, "count": "center"};

  final List<Map<String, dynamic>> careers = [
    {"title": "Flutter Developer", "icon": Icons.phone_android},
    {"title": "AI Engineer", "icon": Icons.smart_toy},
    {"title": "Data Scientist", "icon": Icons.bar_chart},
    {"title": "Web Developer", "icon": Icons.web},
    {"title": "UI/UX Designer", "icon": Icons.design_services},
    {"title": "Cyber Security", "icon": Icons.security},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Careers', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Choose your dream career',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: careers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        // final title = careers[index]['title'] as String;
                        // final icon = careers[index]['icon'] as IconData;

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CareerDetailsScreen(
                        //       title: title,
                        //       icon: icon,
                        //     ),
                        //   ),
                        // );
                        String title = careers[index]["title"];
                        IconData icon = careers[index]["icon"];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CareerDetailsScreen(title: title, icon: icon),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(careers[index]["icon"], size: 50),
                          SizedBox(height: 10),
                          Text(
                            careers[index]["title"],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
