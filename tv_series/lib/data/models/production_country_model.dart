import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/production_country.dart';

class ProductionCountryModel extends Equatable {
  const ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        'iso31661': iso31661,
        'name': name,
      };

  ProductionCountry toEntity() {
    return ProductionCountry(
      iso31661: iso31661,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
