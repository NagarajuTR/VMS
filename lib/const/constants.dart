import 'package:firebase_storage/firebase_storage.dart';

class Constants {
  Constants._();

  static final instance = Constants._();

  final storageRef = FirebaseStorage.instance.ref();

  getUrl({required String imageName}) {
    final islandRef = storageRef.child("images/Femployee_1718347226534.jpg");

    return "https://firebasestorage.googleapis.com/v0/b/vmsp-b1e74.appspot.com/o/images%2Femployee_1718347226534.jpg?alt=media&token=0b137c9c-6224-4262-8f62-731f80693e17";
  }
}
