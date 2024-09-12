import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase_authentication.dart';

import 'package:fork_and_fusion/features/data/repositories/firebase_auth_repository.dart';

import 'package:google_sign_in/google_sign_in.dart';


class Services {
  //------------
  static Future<FirebaseAuthRepository> firebaseRepo() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn google = GoogleSignIn();
    FireBaseAuthDataSource dataSource =
        FireBaseAuthDataSource(auth, google, fireStore);
    return FirebaseAuthRepository(dataSource);
  }

//---------------
 
}
