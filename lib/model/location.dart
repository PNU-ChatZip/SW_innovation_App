class location {
  final String latitude;
  final String longitude;

  location(this.latitude,this.longitude);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}