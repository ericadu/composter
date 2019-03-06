class DropoffTime {
  final int id;
  final String operationDay;
  final String hourFrom;
  final String hourTo;
  
  DropoffTime.fromJSON(Map<String, dynamic> json)
    : id = json['DropoffLocationID'],
      operationDay = json['OperationDay'],
      hourFrom = json['HourFrom'],
      hourTo = json['HourTo'];
}