import '../../domain/model/address.dart';
import '../dto/address_dto.dart';
import '../service/address_api_service.dart';

class AddressRepository {
  const AddressRepository(this._apiService);

  final AddressApiService _apiService;

  Future<Address> createAddress({
    required String addressLine1,
    String? addressLine2,
    required String township,
    required String city,
    required int region,
    required int zone,
    String? postalCode,
    required bool isActive,
  }) async {
    final dto = AddressDto(
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      township: township,
      city: city,
      regionId: region,
      zoneId: zone,
      postalCode: postalCode,
      isActive: isActive,
    );

    return (await _apiService.createAddress(dto)).toDomain();
  }

  Future<Address> updateAddress({
    required int id,
    required String addressLine1,
    String? addressLine2,
    required String township,
    required String city,
    required int region,
    required int zone,
    String? postalCode,
    required bool isActive,
  }) async {
    final dto = AddressDto(
      id: id,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      township: township,
      city: city,
      regionId: region,
      zoneId: zone,
      postalCode: postalCode,
      isActive: isActive,
    );

    return (await _apiService.updateAddress(id, dto)).toDomain();
  }
}
