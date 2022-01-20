import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:countrytest/models/country.dart';

class CountryService {
  Uri myUri = Uri.parse("https://countriesnow.space/api/v0.1/countries/iso");

  Future<List<Country>> getCountries() async {
    dynamic res = await http.get(myUri);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<Country> countries = [];

      for (var item in body['data']) {
        countries.add(Country.fromJson(item));
      }

      return countries;
    } else {
      print("can't get countries");
      return [];
    }
  }
}
