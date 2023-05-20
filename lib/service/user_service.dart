import 'package:database_sample_project/constants/global_constants.dart';
import 'package:database_sample_project/model/user_detail_model.dart';

class UserService {
  Future addData(String age, String gender) async {
    var ref = GlobalConstants().firestore.collection('user details');

    var querySnapshot = await ref
        .where('userId', isEqualTo: GlobalConstants().auth.currentUser?.uid)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // Kullanıcının verisi henüz kaydedilmemiş, yeni bir kayıt oluşturulacak
      var documentRef = await ref.add({
        'userId': GlobalConstants().auth.currentUser?.uid,
        'age': age,
        'gender': gender
      });

      return UserDetailModel(id: documentRef.id, age: age, gender: gender);
    } else {
      // Kullanıcının verisi zaten kaydedilmiş, mevcut kaydı güncelle
      var documentRef = querySnapshot.docs.first.reference;
      var documentData = querySnapshot.docs.first.data();

      // Verileri kontrol et, güncelleme gerekiyorsa güncelle
      if (documentData['age'] != age || documentData['gender'] != gender) {
        await documentRef.update({
          'age': age,
          'gender': gender,
        });

        return UserDetailModel(id: documentRef.id, age: age, gender: gender);
      } else {
        // Veriler aynı, güncelleme yapmadan mevcut veriyi döndür
        return UserDetailModel(
          id: documentRef.id,
          age: documentData['age'],
          gender: documentData['gender'],
        );
      }
    }
  }
}
