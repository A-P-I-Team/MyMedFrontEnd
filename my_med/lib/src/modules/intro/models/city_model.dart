import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  CityModel({
    required this.id,
    required this.cityName,
  });

  final int id;
  final String cityName;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
      };
}
