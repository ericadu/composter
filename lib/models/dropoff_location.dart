import 'package:composter/models/dropoff_time.dart';

enum Status {
  closed,
  probably_closed,
  probably_open,
  open
}

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

  int _timeToInt(String time) {
    RegExp regExp = new RegExp(
      r"^(1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm])$",
      caseSensitive: false,
      multiLine: false,
    );

    var matches = regExp.allMatches(time);
    if (matches.length > 0) {
      Match match = matches.elementAt(0);
      int hr = int.parse(match.group(1));
      int min = int.parse(match.group(2));
      bool pm = match.group(3).toLowerCase() == 'pm';

      return (pm ? hr + 12 : hr) * 60 + min;
    }
    
    return 0;
  }

  bool _isInRange(DropoffTime hr, List<String> weekdays, int weekday) {
      List<String> range = hr.operationDay.split("-");
      weekdays.asMap().forEach((i, w) {
        if ((range[0].contains(w) && i > (weekday - 1)) || (range[1].contains(w) && i < (weekday - 1)) ) {
          return false;
        }
      });
      return true;
  }

  Status getStatus() {
    DateTime currentTime = new DateTime.now();
    int weekday = currentTime.weekday;
    List<String> weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

    for (DropoffTime hr in this.dropoffHours) {
      if (hr.operationDay.toLowerCase().contains('every')) {
        // return Text('Probably Open',
        //   style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600, fontSize: 14)
        // );
        return Status.probably_open;
      }

      if (hr.operationDay.toLowerCase().contains(weekdays[weekday - 1]) ||
          (hr.operationDay.split("-").length > 1 ? _isInRange(hr, weekdays, weekday): false)) {
        int startTime = _timeToInt(hr.hourFrom);
        int endTime = _timeToInt(hr.hourTo);
        int current = (currentTime.hour * 60) + currentTime.minute;

        if (current > startTime && current < endTime) {
          if (this.siteName.contains('CLOSED')) {
            // return Text('Probably Closed',
            //   style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600, fontSize: 14)
            // );
            return Status.probably_closed;
          }
          // return Text('Open',
          //   style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 14)
          // );
          return Status.open;
        }
      }
    }

    // return Text('Closed',
    //   style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14)
    // );
    return Status.closed;
  }

  DropoffLocation.fromJSON(Map<String, dynamic> json)
    : id = json['ID'],
      borough = json['Borough'],
      siteName = json['DropOffSiteName'],
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
