import 'package:countries/src/models/data_model.dart';
import 'package:countries/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class CountryApiProvider {
  Future<List<Country>> getAllCountries() async {
    var url = "https://restcountries.eu/rest/v2/all";
    Response response = await Dio().get(url);
    return (response.data as List).map((country){
      print('Inserting $country');
      DBProvider.db.createCountry(Country.fromJson(country));
    }).toList();

  }
}