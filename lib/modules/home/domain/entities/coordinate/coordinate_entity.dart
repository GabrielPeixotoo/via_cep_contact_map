import 'package:equatable/equatable.dart';

class CoordinateEntity extends Equatable {
  final double lat;
  final double long;

  const CoordinateEntity({required this.lat, required this.long});

  @override
  List<Object> get props => [lat, long];
}
