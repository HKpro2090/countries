import 'dart:convert';

List<Country> CountryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String CountryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  String name = "";
  String alpha3Code = "";
  String region = "";
  String capital = "";
  String flag = "";
  //String borders = "";
  //String languages = "";

  Country({
    this.name,
    this.alpha3Code,
    this.region,
    this.capital,
    this.flag,
    //this.languages,
    //this.borders,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    alpha3Code: json["alpha3Code"],
    region: json["region"],
    capital: json["capital"],
    //borders: json["borders"][0],
    //languages: json["language"][0],
    flag: json["flag"],

  );

  Map<String, dynamic> toJson() => {
    "name" : name,
    "alpha3Code": alpha3Code,
    "region" : region,
    "capital" : capital,
    //"borders" : borders,
    //"languages" : languages,
    "flag" : flag,

  };
}