import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print("Parsed Data: $data");  
        return data;
      } else {
        print("API Failed: Status ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching posts: $error");
      return [];
    }
  }
}
