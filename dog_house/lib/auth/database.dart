import 'package:matcher/matcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, int dHouseNum, int petNum) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'dHouseNum': dHouseNum,
      'petnum': petNum,
    });
  }

  List<Userr> _UserListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return Userr(
          name: doc.data()['name'] ?? '',
          petNum: doc.data()['petnum'] ?? '',
          dHouseNum: doc.data()['dHouseNum'] ?? '');
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        petNum: snapshot.get('petNum'),
        dHouseNum: snapshot.get('dHouseNum'));
  }

  Stream<List<Userr>> get users {
    return usersCollection
        .snapshots()
        .map((dynamic snapshot) => _UserListFromSnapshot(snapshot));
  }

  //get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
