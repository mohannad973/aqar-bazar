// To parse this JSON data, do
//
//     final preferencesResponse = preferencesResponseFromJson(jsonString);

import 'dart:convert';

PreferencesResponse preferencesResponseFromJson(String str) =>
    PreferencesResponse.fromJson(json.decode(str));

String preferencesResponseToJson(PreferencesResponse data) =>
    json.encode(data.toJson());

class PreferencesResponse {
  PreferencesResponse({
    this.countries,
    this.languages,
    this.currencies,
  });

  List<List<dynamic>> countries;
  List<List<dynamic>> languages;
  List<List<dynamic>> currencies;

  factory PreferencesResponse.fromJson(Map<String, dynamic> json) =>
      PreferencesResponse(
        countries: List<List<dynamic>>.from(
            json["countries"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        languages: List<List<dynamic>>.from(
            json["languages"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        currencies: List<List<dynamic>>.from(
            json["currencies"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(
            countries.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "languages": List<dynamic>.from(
            languages.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "currencies": List<dynamic>.from(
            currencies.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };

  @override
  String toString() {
    return 'PreferencesResponse{countries: $countries, languages: $languages, currencies: $currencies}';
  }
}

class Country {
  dynamic name;
  dynamic id;

  Country({this.name, this.id});

  @override
  String toString() {
    return 'Country{name: $name, id: $id}';
  }
}

class Currency {
  dynamic name;
  dynamic id;

  Currency({this.name, this.id});

  @override
  String toString() {
    return 'Currency{name: $name, id: $id}';
  }
}

class Language {
  dynamic name;
  dynamic id;

  Language({this.name, this.id});

  @override
  String toString() {
    return 'Language{name: $name, id: $id}';
  }
}
