import 'package:equatable/equatable.dart';

class Network extends Equatable {
  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
