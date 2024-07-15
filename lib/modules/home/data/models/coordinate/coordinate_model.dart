import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

class CoordinateModel extends CoordinateEntity {
  const CoordinateModel({required super.lat, required super.long});

  factory CoordinateModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return CoordinateModel(
        lat: map['geometry']['location']['lat'],
        long: map['geometry']['location']['lng'],
      );
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }
}
