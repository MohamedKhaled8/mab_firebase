class GetMarkerModel {
  String? taskID;
  double lat;
  double longt;
  String name;

  GetMarkerModel({
     this.taskID,
    required this.lat,
    required this.longt,
    required this.name,
  });

  factory GetMarkerModel.fromJson(Map<String, dynamic> json) {
    return GetMarkerModel(
      taskID: json['TaskID'],
      lat: double.parse(json['Lat']),
      longt: double.parse(json['Longt']),
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TaskID': taskID,
      'Lat': lat,
      'Longt': longt,
      'Name': name,
    };
  }
}
