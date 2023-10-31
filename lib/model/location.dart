class location {
  final String latitude;
  final String longitude;
  final String type;

  location(this.latitude,this.longitude, this.type);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
      };

  factory location.fromJson(Map<String, dynamic> json) {
    return location(
      json['latitude'],
      json['longitude'],
      json['type'],
    );
  }
}