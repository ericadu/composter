import 'dart:async';
import 'package:dio/dio.dart';

import 'package:composter/models/dropoff_location_response.dart';

class DsnyApiProvider {
  final String _endpoint = "https://a827-donatenyc.nyc.gov/DSNYApi/api/DSNYDropOff/GetDropOffLocation?category=2";
  final Dio _dio = Dio();

  Future<DropoffLocationResponse> getDropoffLocations() async {
    try {
      Response response = await _dio.get(_endpoint);
      return DropoffLocationResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DropoffLocationResponse.withError("$error");
    }
  }
}