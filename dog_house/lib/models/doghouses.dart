class dogHouses {
  late String name;
  late String uid;

  dogHouses({
    required this.name,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
      };

  dogHouses.fromSnapshot(snapshot) {
    name = snapshot.data()['name'];
    uid = snapshot.id;
  }
}
