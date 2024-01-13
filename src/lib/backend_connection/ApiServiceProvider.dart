import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jura_hostic_i_film_app/models/audits/AuditStatus.dart';
import 'package:jura_hostic_i_film_app/util/local_storage/LocalStorageManager.dart';
import 'package:path_provider/path_provider.dart';
import '../DTOs/AuditDTO.dart';
import '../DTOs/LoginDTO.dart';
import '../DTOs/RegisterDTO.dart';
import '../constants.dart';
import '../models/User.dart';
import '../models/audits/Audit.dart';
import '../models/documents/Document.dart';
import '../models/documents/DocumentStatus.dart';
import '../models/documents/DocumentType.dart';
import 'ApiService.dart';

class ApiServiceProvider extends ChangeNotifier {
  final String root = Constants.baseUrl;
  String? token;
  User? currentUser;

  ApiServiceProvider(this.token);

  Future<bool> authUser(LoginDTO user) async {
    String? responseToken = await ApiService.usersLogin(user);
    if (responseToken != null) {
      token = responseToken;
      await getCurrentUser();
      notifyListeners();
      return await LocalStorageManager.writePair('token', token, true);
    }
    return false;
  }

  Future<bool> createUser(RegisterDTO user) async {
    if (token != null) {
      User? responseUser = await ApiService.usersRegister(user, token!);
      notifyListeners();

      return responseUser != null;
    }

    return false;
  }

  Future<bool> createStartingUser(RegisterDTO user) async {
    await ApiService.usersRegisterAdmin(user);
    return await authUser(user.toLoginDTO());
  }

  Future<bool> getCurrentUser() async {
    if (token != null) {
      currentUser ??= await ApiService.usersMe(token!);
    }

    return currentUser != null;
  }

  Future<bool> logoutUser() async {
    token = null;
    currentUser = null;
    return await LocalStorageManager.clearStorage();
  }

  Future<List<User>> getAllUsers() async {
    if (token != null) {
      return await ApiService.users(token!);
    }

    return [];
  }

  Future<bool> checkAdmin() async {
    return await ApiService.usersAdminExists();
  }

  Future<List<Document>> getDocuments(DocumentType? typeQuery, DocumentStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.documents(token!, typeQuery != null ? typeQuery.name : '', statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<List<Document>> getUserDocuments() async {
    if (token != null) {
      return await ApiService.documentsMe(token!);
    }

    return [];
  }

  Future<Document?> createDocument(String imagePath) async {
    if (token != null) {
      return await ApiService.documentsCreate(token!, imagePath);
    }

    return null;
  }

  Future<Document?> getDocumentByID(int documentId) async {
    if (token != null) {
      return await ApiService.documentsDocument(token!, documentId.toString());
    }

    return null;
  }

  Future<ImageProvider?> getImageByID(int imageId) async {
    if (token != null) {
      Uint8List? imageString = await ApiService.documentsImage(token!, imageId.toString());
      if (imageString != null) {
        return MemoryImage(imageString);
      }
    }

    return null;
  }

  Future<Document?> updateDocumentStatus(int documentId, DocumentStatus documentStatus) async {
    if (token != null) {
      return await ApiService.documentsUpdate(token!, documentId.toString(), documentStatus.name);
    }

    return null;
  }

  Future<List<Audit>> getAudits(int? userIdQuery, AuditStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.audits(token!, userIdQuery != null ? userIdQuery.toString() : '', statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<List<Audit>> getUserAudits(AuditStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.auditsMe(token!, statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<Audit?> createAuditRequest(AuditDTO audit) async {
    if (token != null) {
      return await ApiService.auditsCreate(token!, audit);
    }

    return null;
  }

  Future<Audit?> auditDocument(int documentId) async {
    if (token != null) {
      return await ApiService.auditsDocument(token!, documentId.toString());
    }

    return null;
  }

  Future<ImageProvider?> apiDocumentsTest() async {
    final byteData = await rootBundle.load('assets/test_img.jpeg');

    final file = File('${(await getTemporaryDirectory()).path}/test_img.jpeg');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    Document? newDoc = await createDocument(file.path);
    if (newDoc != null) {
      print(newDoc.imageId.toString() + " created!");
    } else {
      print("error?");
      return null;
    }

    List<Document> docs = await getUserDocuments();
    print("num of user documents: " + docs.length.toString());
    for (Document doc in docs) {
      if (doc.id > docs.length - 5 || doc.id < 5) {
        print(doc.id.toString() + " " + doc.documentType.name + " " + doc.documentStatus.name);
      }
    }

    ImageProvider? submitted = await getImageByID(newDoc.imageId);
    Uint8List? uint = await ApiService.documentsImage(token!, newDoc.imageId.toString());
    print("image good: " + (uint.toString() == byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes).toString()).toString());

    print("old status: " + newDoc.documentStatus.name);
    newDoc = await updateDocumentStatus(newDoc.id, DocumentStatus.refused);
    print("new status: " + newDoc!.documentStatus.name);

    List<Document> refusedDocs = await getDocuments(DocumentType.internal, DocumentStatus.refused);
    print(refusedDocs.length);

    Document? firstDoc = await getDocumentByID(1);
    if (firstDoc != null) {
      print("first doc: " + firstDoc.documentType.name + " " + firstDoc.documentStatus.name);
    } else {
      print("first not found!");
    }

    return submitted;
  }
}