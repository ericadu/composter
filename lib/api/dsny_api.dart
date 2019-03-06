import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:composter/models/dropoff_location.dart';

class DsnyApi {
  final String baseUrl = "a827-donatenyc.nyc.gov";
  final _httpClient = new HttpClient();

  Future<List<DropoffLocation>> dropoffLocations() async {
    var uri = Uri.https(
      baseUrl,
      'DSNYApi/api/DSNYDropOff/GetDropOffLocation',
      <String, String>{
        'category': '2',
      },
    );

    var response = await _getRequest(uri);

    List<DropoffLocation> locations = (json.decode(response) as List)
      .map((loc) => DropoffLocation
        .fromJSON(loc))
      .toList();
    
    return locations;
  }

  Future<String> _getRequest(Uri uri) async {
    var request = await _httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(utf8.decoder).join();
  }
}

DsnyApi api = DsnyApi();