class Userr {
  late final String name;
  late final int petNum;
  late final String dHouseNum;

  Userr({required this.name, required this.dHouseNum, required this.petNum});
  static Userr fromJson(Map<String, dynamic> json) {
    return Userr(
        name: json['name'],
        dHouseNum: json['dHouseNum'],
        petNum: json['petNum']);
  }
}

class UserData {
  final String? uid;
  final String name;
  final int petNum;
  final String dHouseNum;
  UserData(
      {required this.uid,
      required this.name,
      required this.petNum,
      required this.dHouseNum});
}
