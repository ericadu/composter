import 'package:composter/models/dropoff_location.dart';

class DropoffLocationResponse {
  final List<DropoffLocation> results;
  final String error;

  DropoffLocationResponse.fromJSON(List<dynamic> json)
    : results = json.map((i) => new DropoffLocation.fromJSON(i)).toList(),
      error = "";
    
  DropoffLocationResponse.withError(String errorValue)
    : results = List(),
      error = errorValue;
}
