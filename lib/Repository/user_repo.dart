import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import '../Models/user_model.dart';
import '../utils/exceptions/firebase_exceptions.dart';
import '../utils/exceptions/format_exceptions.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.put(UserRepo());

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user record
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
      debugPrint("User record saved successfully");
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Function to get user record
  Future<UserModel> getUserRecord() async {
    try {
      final uid = AuthenticationRepo.instance.currentUser?.uid;
      if (uid == null) {
        debugPrint('User ID is null');
        throw 'User is not authenticated';
      }
      
      debugPrint('Fetching user record for UID: $uid');
      final documentSnapshot = await _db.collection('users').doc(uid).get();
      
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (data != null) {
          debugPrint('User record found: $data');
          return UserModel.fromMap(data);
        } else {
          debugPrint('Document data is null');
          throw 'User record is empty';
        }
      } else {
        debugPrint('User record does not exist');
        throw 'User record does not exist';
      }
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      debugPrint('FormatException');
      throw const TFormatException();
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      debugPrint('Exception: $e');
      throw 'Something went wrong. Please try again.';
    }
  }

    // Function to update user record
  Future<void> updateUserrecord(Map<String,dynamic> json) async {
    try {
      await _db.collection('users').doc(AuthenticationRepo.instance.currentUser?.uid).update(json);
      debugPrint("User record updated successfully");
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

    Future<void> delelteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
      debugPrint("User record deleted successfully");
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

}
