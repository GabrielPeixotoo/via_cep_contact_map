import 'package:equatable/equatable.dart';

import '../../domain.dart';

abstract class FetchCepByAddressUsecase {
  Future<List<AddressEntity>> call({required FetchCepByAddressParams params});
}

class FetchCepByAddressParams extends Equatable {
  final String state;
  final String city;
  final String streetName;

  const FetchCepByAddressParams({
    required this.state,
    required this.city,
    required this.streetName,
  });

  @override
  List<Object> get props => [state, city, streetName];
}
