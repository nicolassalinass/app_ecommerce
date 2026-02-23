
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage{
  final ProductRepository repository;

  UploadImage(this.repository);

  Future<String> uploadImage(XFile image, String token) async{
    return await repository.uploadImage(image, token);
  }
}
