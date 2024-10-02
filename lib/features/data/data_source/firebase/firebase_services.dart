import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fork_and_fusion/core/error/firebase_auth_exception.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //------------read all stream-----------------
  Stream<List<Map<String, dynamic>>> featchAll(String collection) {
    try {
      return _firestore.collection(collection).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions.handleFirebaseExceptions(e);
    } catch (e) {
      throw e.toString();
    }
  }

//------------------------read all async----------------
  Future<List<Map<String, dynamic>>> getAll(String collection) async {
    try {
      final data = await _firestore.collection(collection).get();
      return data.docs.map((element) => element.data()).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions.handleFirebaseExceptions(e);
    } catch (e) {
      throw e.toString();
    }
  }

  //--------------read one-----------------------
  Future<Map<String, dynamic>> getOne(String collection, String id) async {
    try {
      final snapshot = await _firestore.collection(collection).doc(id).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      throw 'could not find the data';
    } on FirebaseException catch (e) {
      throw FirebaseExceptions.handleFirebaseExceptions(e);
    } catch (e) {
      throw e.toString();
    }
  }

  //-------------search---------------------
  Future<List<Map<String, dynamic>>> search(
      String collection, String querry) async {
    try {
      final snapshot = await _firestore
          .collection(collection)
          .where('name', isGreaterThanOrEqualTo: querry)
          .where('name', isLessThanOrEqualTo: '$querry\uf8ff')
          .get();
      final data =
          snapshot.docs.map((e) => e.data() ).toList();

      return data;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions.handleFirebaseExceptions(e);
    } catch (e) {
      throw e.toString();
    }
  }
}
