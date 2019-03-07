import 'package:composter/models/dropoff_location_response.dart';
import 'package:composter/api/dsny_api_provider.dart';

class DropoffLocationRepository {
  DsnyApiProvider _apiProvider = DsnyApiProvider();

  Future<DropoffLocationResponse> getDropoffLocations() {
    return _apiProvider.getDropoffLocations();
  }
}