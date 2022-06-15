import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled9/allConstants/constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickName;
  String aboutMe;
  String phoneNumber;
  UserChat(
      {required this.id,
      required this.photoUrl,
      required this.nickName,
      required this.aboutMe,
      required this.phoneNumber});
  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickName: nickName,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickName);
    } catch (e) {}
    try {
      phoneNumber = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {}
    return UserChat(
        id: doc.id,
        photoUrl: photoUrl,
        nickName: nickname,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber);
  }
}
