class MachineCardData {
  final double value;
  final String name;

  final String img;
  final String imgIcon;

  final String statusName;

  final String sensor_1_name;
  final String sensor_1_value;

  final String sensor_2_name;
  final String sensor_2_value;

  final String sensor_3_name;
  final String sensor_3_value;

  final String days;

  MachineCardData({
    required this.value,
    required this.name,
    required this.img,
    required this.imgIcon,
    required this.statusName,
    required this.sensor_1_name,
    required this.sensor_1_value,
    required this.sensor_2_name,
    required this.sensor_2_value,
    required this.sensor_3_name,
    required this.sensor_3_value,
    required this.days,
  });
    Map<String, dynamic> toJson() {
    return {
      "value": value,
      "name": name,
      "img": img,
      "imgIcon": imgIcon,
      "statusName": statusName,
      "sensor_1_name": sensor_1_name,
      "sensor_1_value": sensor_1_value,
      "sensor_2_name": sensor_2_name,
      "sensor_2_value": sensor_2_value,
      "sensor_3_name": sensor_3_name,
      "sensor_3_value": sensor_3_value,
      "days": days,
    };
  }

  factory MachineCardData.fromJson(Map<String, dynamic> json) {
    return MachineCardData(
      value: (json["value"] ?? 0).toDouble(),
      name: json["name"] ?? "",
      img: json["img"] ?? "",
      imgIcon: json["imgIcon"] ?? "",
      statusName: json["statusName"] ?? "",
      sensor_1_name: json["sensor_1_name"] ?? "",
      sensor_1_value: json["sensor_1_value"] ?? "",
      sensor_2_name: json["sensor_2_name"] ?? "",
      sensor_2_value: json["sensor_2_value"] ?? "",
      sensor_3_name: json["sensor_3_name"] ?? "",
      sensor_3_value: json["sensor_3_value"] ?? "",
      days: json["days"] ?? "",
    );
  }
}
