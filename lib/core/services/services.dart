import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_authentication.dart';
import 'package:fork_and_fusion/features/data/repositories/cart_repository.dart';
import 'package:fork_and_fusion/features/data/repositories/favourite_repository.dart';

import 'package:fork_and_fusion/features/data/repositories/firebase_auth_repository.dart';
import 'package:fork_and_fusion/features/data/repositories/order_repository.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Services {
  //------------
  static FirebaseAuthRepository firebaseRepo() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn google = GoogleSignIn();
    FireBaseAuthDataSource dataSource =
        FireBaseAuthDataSource(auth, google, fireStore);
    return FirebaseAuthRepository(dataSource);
  }

//---------------
  static CartRepository cartRepo() => CartRepository();
  static FavouriteRepository favouriteRepository() => FavouriteRepository();
  static OrderRepository orderRepository() => OrderRepository();
  static const firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyCiAiAFC1D1zlNhpa8-RTlHFb5gZ5b497c",
      authDomain: "fork-and-fusion.firebaseapp.com",
      databaseURL:
          "https://fork-and-fusion-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "fork-and-fusion",
      storageBucket: "fork-and-fusion.appspot.com",
      messagingSenderId: "1055687672689",
      appId: "1:1055687672689:web:1885d7f61e6125017cecd0");
}
