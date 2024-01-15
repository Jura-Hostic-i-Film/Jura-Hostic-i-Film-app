import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:jura_hostic_i_film_app/DTOs/RegisterDTO.dart';
import 'package:jura_hostic_i_film_app/util/helpers/formatToken.dart';
import 'package:jura_hostic_i_film_app/util/helpers/secureHash.dart';
import '../DTOs/ArchiveDTO.dart';
import '../DTOs/AuditDTO.dart';
import '../DTOs/LoginDTO.dart';
import '../DTOs/SignatureDTO.dart';
import '../constants.dart';
import '../models/User.dart';
import '../models/archives/Archive.dart';
import '../models/audits/Audit.dart';
import '../models/documents/Document.dart';
import '../models/signatures/Signature.dart';

class ApiService {
  static const String root = Constants.baseUrl;

  // - /user/*

  static Future<String?> usersLogin(LoginDTO user) async {
    final url = Uri.https(root, "/users/login");

    Response response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': secureHash(user.password),
      }),
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['token'];
      return token;
    } else {
      return null;
    }
  }

  static Future<User?> usersRegister(
      RegisterDTO user,
      String token,
      ) async {
    final url = Uri.https(root, "/users/register");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'username': user.username,
        'password': secureHash(user.password),
        'first_name': user.firstName,
        'last_name': user.lastName,
        'roles': user.roles.map((role) => role.name).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<User?> usersMe(String token) async {
    final url = Uri.https(root, "/users/me");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<List<User>> users(String token) async {
    final url = Uri.https(root, "/users");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token), },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<User>((json) => User.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<User?> usersRegisterAdmin(RegisterDTO user) async {
    final url = Uri.https(root, "/users/register/admin");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'username': user.username,
        'password': secureHash(user.password),
        'first_name': user.firstName,
        'last_name': user.lastName,
        'roles': user.roles.map((role) => role.name).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<bool> usersAdminExists() async {
    final url = Uri.https(root, "/users/admin/exists");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return false;
    }
  }


  // - /documents/*

  static Future<List<Document>> documents(String token, String? typeQuery, String? statusQuery) async {
    Map<String, String> queryParams = {};
    if (typeQuery != null) {
      queryParams["document_type"] = typeQuery;
    }
    if (statusQuery != null) {
      queryParams["document_status"] = statusQuery;
    }
    final url = Uri.https(root, "/documents", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Document>((json) => Document.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Document>> documentsMe(String token) async {
    final url = Uri.https(root, "/documents/me");

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Document>((json) => Document.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<Document?> documentsCreate(String token, String imagePath) async {
    final url = Uri.https(root, "/documents/create");

    MultipartRequest request = MultipartRequest("POST", url);
    request.headers['Authorization'] = formatToken(token);
    request.files.add(await MultipartFile.fromPath(
      'image',
      imagePath,
    ));
    StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> decoded = jsonDecode(responseBody);
    if (response.statusCode == 200) {
      return Document.fromJson(decoded);
    }

    return null;
  }

  static Future<Document?> documentsDocument(String token, String documentId) async {
    final url = Uri.https(root, "/documents/document/$documentId");

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return Document.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<Uint8List?> documentsImage(String token, String documentId) async {
    final url = Uri.https(root, "/documents/image/$documentId");

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  static Future<Document?> documentsUpdate(String token, String documentId, String newStatus) async {
    final url = Uri.https(root, "/documents/update/$documentId", {"new_status": newStatus});

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return Document.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<Document?> documentsApproveDocument(String token, String documentId, bool approve) async {
    final url = Uri.https(root, "/documents/approve/$documentId", {"approve": approve});

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return Document.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }


  // - /audits/*

  static Future<List<Audit>> audits(String token, String? userId, String? status) async {
    Map<String, String> queryParams = {};
    if (userId != null) {
      queryParams["user_id"] = userId;
    }
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/audits", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Audit>((json) => Audit.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Audit>> auditsMe(String token, String? status) async {
    Map<String, String> queryParams = {};
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/audits/me", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Audit>((json) => Audit.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<Audit?> auditsCreate(String token, AuditDTO audit) async {
    final url = Uri.https(root, "/audits/create");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
      body: jsonEncode(<String, dynamic>{
        'audit_by': audit.auditBy,
        'document_id': audit.documentId,
      }),
    );

    if (response.statusCode == 200) {
      return Audit.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<Audit?> auditsDocument(String token, String documentId) async {
    final url = Uri.https(root, "/audits/$documentId");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return Audit.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }


  // - /archives/*

  static Future<List<Archive>> archives(String token, String? userId, String? status) async {
    Map<String, String> queryParams = {};
    if (userId != null) {
      queryParams["user_id"] = userId;
    }
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/archives", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Archive>((json) => Archive.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Archive>> archivesMe(String token, String? status) async {
    Map<String, String> queryParams = {};
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/archives/me", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Archive>((json) => Archive.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<Archive?> archivesCreate(String token, ArchiveDTO archive) async {
    final url = Uri.https(root, "/archives/create");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
      body: jsonEncode(<String, dynamic>{
        'archive_by': archive.archiveBy,
        'document_id': archive.documentId,
      }),
    );

    if (response.statusCode == 200) {
      return Archive.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<Archive?> archivesArchiveDocument(String token, String documentId) async {
    final url = Uri.https(root, "/archives/archive/$documentId");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return Archive.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }


  // - /signatures/*

  static Future<List<Signature>> signatures(String token, String? userId, String? status) async {
    Map<String, String> queryParams = {};
    if (userId != null) {
      queryParams["user_id"] = userId;
    }
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/signatures", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Signature>((json) => Signature.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Signature>> signaturesMe(String token, String? status) async {
    Map<String, String> queryParams = {};
    if (status != null) {
      queryParams["status"] = status;
    }
    final url = Uri.https(root, "/signatures/me", queryParams);

    Response response = await get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<Signature>((json) => Signature.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<Signature?> signaturesCreate(String token, SignatureDTO archive) async {
    final url = Uri.https(root, "/signatures/create");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
      body: jsonEncode(<String, dynamic>{
        'sign_by': archive.signBy,
        'document_id': archive.documentId,
      }),
    );

    if (response.statusCode == 200) {
      return Signature.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<Signature?> signaturesDocument(String token, String documentId) async {
    final url = Uri.https(root, "/signatures/$documentId");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return Signature.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }
}