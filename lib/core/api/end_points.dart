import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String cloudinary = dotenv.env['CLOUDINARY_URL'] ?? '';
  static String cloudinaryUpload = '${cloudinary}upload';
  static String cloudinarySignature = '$cloudinary/cloudinary-signature';
}
