import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _apiKey =
      '';
  Future<String> generateRoadmap({
    required String name,
    required String career,
    required String level,
    required List<String> skills,
    required double studyHours,
    required String learningMode,
  }) async {
    final prompt =
        """
You are an experienced software mentor.

A student has filled in the following details:

Name: $name
Career Goal: $career
Programming Level: $level
Known Skills: ${skills.join(", ")}
Available Study Time: ${studyHours.round()} hours/week
Preferred Learning Style: $learningMode

Generate a personalized learning roadmap.

Return ONLY Markdown.

Use this exact structure:

#  AI Career Roadmap

##  Welcome
Write a short personalized introduction.

##  Skills to Learn
Provide a bullet list.

##  Weekly Plan
Create an 8-week roadmap.

##  Beginner Projects
Suggest three projects.

##  Learning Resources
Suggest YouTube channels, documentation, and websites.

##  Interview Preparation
Give interview tips.

##  Motivation
End with an encouraging message.

Keep the language simple and suitable for beginners.
""";

    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": 'llama-3.3-70b-versatile',
        "messages": [
          {
            "role": "system",
            "content":
                "You are an expert career mentor. Always respond in markdown.",
          },
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      print("Roadmap: ${data["choices"][0]["message"]["content"]}");
      return data["choices"][0]["message"]["content"];
    } else {
      print("Error: ${response.body}");
      throw Exception('Failed to generate roadmap: ${response.statusCode}');
    }
  }
}
