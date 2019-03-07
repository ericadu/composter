import 'package:composter/models/dropoff_time.dart';

class DropoffLocation{
  final int id;
  final String borough;
  final String siteName;
  final String location;
  final double latitude;
  final double longitude;
  final String website;
  final String servicedBy;
  final String openMonth;
  final String openMonthFrom;
  final String openMonthTo;
  final String notes;
  final String phone;
  final List<DropoffTime> dropoffHours;
  final String days;

  DropoffLocation.fromJSON(Map<String, dynamic> json)
    : id = json['ID'],
      borough = json['Borough'],
      siteName = json['DropoffSiteName'],
      location = json['Location'],
      latitude = json['Latitude'],
      longitude = json['Longitude'],
      website = json['Website'],
      servicedBy = json['ServicedBy'],
      openMonth = json['OpenMonth'],
      openMonthFrom = json['OpenMonthFrom'],
      openMonthTo = json['OpenMonthTo'],
      notes = json['Notes'],
      phone = json['Phone'],
      dropoffHours = (json['DropOffHoursList'] as List).map((json) => DropoffTime.fromJSON(json)).toList(),
      days = json['Days']
    ;
}
