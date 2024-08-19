import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/api_response_schema.dart';

class FetchService {
  Future<ResponseSchema> fetchListSchema() async {
    final response = await http.get(
        Uri.parse("https://dotpitchtechnologies.com/polititi/public/api/data"));
    print("here is the response::: ${response}");
    if (response.statusCode == 200) {
      print("here is the response:::${jsonDecode(response.body)}");
      return ResponseSchema.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch List');
    }
  }
}
