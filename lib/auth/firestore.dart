import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_records/auth/user.dart';

class FirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser!.uid
      : '';

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final String users = 'users';

  createUser({required UserModel model}) async {
    await userCollection.doc(model.uid).set(model.toJson());
  }

  updateUser({required Map<String, dynamic> data, required String id}) async {
    await userCollection.doc(id).update(data);
  }

  Future<DocumentSnapshot> getUser(String id) async {
    return await userCollection.doc(id).get();
  }

  deleteUser(String id) async {
    await userCollection.doc(id).delete();
  }
}
