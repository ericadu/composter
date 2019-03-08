import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:composter/models/dropoff_location.dart';
import 'package:composter/models/dropoff_time.dart';
import 'package:composter/blocs/dropoff_locations_bloc.dart';

class DropoffDetail extends StatefulWidget {
  @override
  State<DropoffDetail> createState() => DropoffDetailState();
}

class DropoffDetailState extends State<DropoffDetail> {
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DropoffLocation>(
      stream: bloc.focusController.stream,
      builder: (context, AsyncSnapshot<DropoffLocation> snapshot) {
        Widget widget;
        if (snapshot.hasData) {
          widget = Card(
            elevation: 8.0,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: buildWidgets(snapshot.data),
              )
            )
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          widget = Text("");
        }

        return Positioned(
          bottom: 10.0,
          left: 10.0,
          right: 10.0,
          child: widget
        );
      }
    );
  }

  int timeToInt(String time) {
    RegExp regExp = new RegExp(
      r"^(1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm])$",
      caseSensitive: false,
      multiLine: false,
    );

    var matches = regExp.allMatches(time);
    Match match = matches.elementAt(0);
    int hr = int.parse(match.group(1));
    int min = int.parse(match.group(2));
    bool pm = match.group(3).toLowerCase() == 'pm';

    return (pm ? hr + 12 : hr) * 60 + min;
  }

  Text isOpen(loc) {
    DateTime currentTime = new DateTime.now();
    int weekday = currentTime.weekday;
    List<String> weekdays = ['mon', 'tues', 'wed', 'thurs', 'fri', 'sat', 'sun'];

    for (DropoffTime hr in loc.dropoffHours) {
      if (hr.operationDay.toLowerCase().contains(weekdays[weekday + 1])) {
        int startTime = timeToInt(hr.hourFrom);
        int endTime = timeToInt(hr.hourTo);
        int current = (currentTime.hour * 60) + currentTime.minute;

        if (current > startTime && current < endTime) {
          if (loc.siteName.contains('CLOSED')) {
            return Text('Probably Closed',
              style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600, fontSize: 14)
            );
          }
          return Text('Open',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 14)
          );
        }
      }
    }

    return Text('Closed',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14)
    );
  }

  List<Widget> buildWidgets(DropoffLocation loc) {

    List<Widget> widgets = <Widget>[
      ListTile(
        title: Text(loc.siteName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          )
        ),
        subtitle: Text(loc.servicedBy),
        trailing: IconButton(icon: Icon(Icons.close), onPressed: () => bloc.focusController.sink.add(null),)
      ),
      Padding(
        child: isOpen(loc),
        padding: EdgeInsets.only(left: 16.0)),
    ];
    List<Tuple2<Icon, String>> details = [
      Tuple2<Icon, String>(Icon(Icons.location_on, color: Theme.of(context).primaryColor), loc.location),
      Tuple2<Icon, String>(Icon(Icons.calendar_today, color: Theme.of(context).primaryColor), loc.openMonth),
      Tuple2<Icon, String>(Icon(Icons.access_time, color: Theme.of(context).primaryColor), loc.days),
    ];

    if (loc.notes != null && loc.notes.isNotEmpty) {
      details.add(Tuple2<Icon, String>(Icon(Icons.note, color: Theme.of(context).primaryColor), loc.notes));
    }

    details.forEach((detail) => {
      widgets.addAll([
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right:8.0),
                child: detail.item1,
              ),
              Flexible(
                child: Container(
                  child: Text(detail.item2,
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.start,
                  )
                )
              )
            ]
          ),
        ),
      ])
    });

    if (loc.website != null && loc.website.isNotEmpty) {
      details.add(Tuple2<Icon, String>(Icon(Icons.public, color: Theme.of(context).primaryColor), loc.website));

      widgets.addAll([
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right:8.0),
                child: Icon(Icons.public, color: Theme.of(context).primaryColor),
              ),
              Flexible(
                child: Container(
                  child: InkWell(
                    child: Text(loc.website,
                      style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () async {
                      if (loc.website.contains('.') && await canLaunch(loc.website)) {
                        await launch(loc.website);
                      }
                    }
                  )
                )
              )
            ]
          ),
        ),
      ]);
    }

    return widgets;
  }
}