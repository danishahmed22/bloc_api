import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = "https://mocki.io"})
      : assert(baseUrl != null);
  Future<List<String>> fetchBannerData() async {
    final url = Uri.parse('https://mocki.io/v1/783f8c69-af91-45ff-87df-e675c3f11fef');
    try {
      final response = await http.get(url);
      print(jsonDecode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      final List<String> bannersUrl = List<String>.from(extractedData['data']['image_url']);
      return bannersUrl;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<String>> fetchListingData() async {
    final url = Uri.parse('https://mocki.io/v1/783f8c69-af91-45ff-87df-e675c3f11fef');
    try {
      final response = await http.get(url);
      print(jsonDecode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      final List<String> bannersUrl = List<String>.from(extractedData['data']['image_url']);
      return bannersUrl;
    } catch (error) {
      print(error);
      return [];
    }
  }
}
