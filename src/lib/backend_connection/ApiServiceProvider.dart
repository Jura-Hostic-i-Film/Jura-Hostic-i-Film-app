import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jura_hostic_i_film_app/DTOs/ArchiveDTO.dart';
import 'package:jura_hostic_i_film_app/DTOs/SignatureDTO.dart';
import 'package:jura_hostic_i_film_app/models/archives/Archive.dart';
import 'package:jura_hostic_i_film_app/models/archives/ArchiveStatus.dart';
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
import '../models/signatures/Signature.dart';
import '../models/signatures/SignatureStatus.dart';
import '../util/TabList.dart';
import 'ApiService.dart';

class ApiServiceProvider extends ChangeNotifier {
  final String root = Constants.baseUrl;
  String? token;
  User? currentUser;
  Map<String, int> notifications = {
    for (var tab in TabList.tabList) tab.key: 0
  };
  late Timer _timer;

  ApiServiceProvider(this.token) {
    _timer = Timer.periodic(
        const Duration(seconds: 10), (_) => updateNotifications());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> updateNotifications() async {
    notifications["/home/signature"] = await getUserSignaturePendingCount();
    notifications["/home/archive"] = await getUserArchivePendingCount();
    notifications["/home/revision"] = await getUserAuditPendingCount();
    notifyListeners();
    return;
  }

  Future<bool> authUser(LoginDTO user) async {
    String? responseToken = await ApiService.usersLogin(user);
    if (responseToken != null) {
      token = responseToken;
      await getCurrentUser();
      await updateNotifications();
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

  Future<List<Document>> getDocuments(
      DocumentType? typeQuery, DocumentStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.documents(
          token!,
          typeQuery?.name,
          statusQuery?.name);
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
      Uint8List? imageString =
          await ApiService.documentsImage(token!, imageId.toString());
      if (imageString != null) {
        return MemoryImage(imageString);
      }
    }

    return null;
  }

  Future<Uint8List?> getImageDataByID(int imageId) async {
    if (token != null) {
      return await ApiService.documentsImage(token!, imageId.toString());
    }

    return null;
  }

  Future<Document?> updateDocumentStatus(
      int documentId, DocumentStatus documentStatus) async {
    if (token != null) {
      return await ApiService.documentsUpdate(
          token!, documentId.toString(), documentStatus.name);
    }

    return null;
  }

  Future<Document?> approveDocument(int documentId, bool approve) async {
    if (token != null) {
      return await ApiService.documentsApproveDocument(
          token!, documentId.toString(), approve);
    }

    return null;
  }

  Future<List<Audit>> getAudits(
      int? userIdQuery, AuditStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.audits(
          token!,
          userIdQuery?.toString(),
          statusQuery?.name);
    }

    return [];
  }

  Future<List<Audit>> getUserAudits(AuditStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.auditsMe(
          token!, statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<Audit?> createAuditRequest(AuditDTO audit) async {
    if (token != null) {
      return await ApiService.auditsCreate(token!, audit);
    }

    return null;
  }

  Future<(Audit?, String)> auditDocument(int documentId) async {
    if (token != null) {
      Audit? rValue = await ApiService.auditsDocument(token!, documentId.toString());
      await updateNotifications();
      return (rValue, rValue == null ? "Success" : "Error");
    }

    return (null, "Error");
  }

  Future<Audit?> getAuditByID(int documentId) async {
    if (token != null) {
      return await ApiService.auditsDocumentGET(token!, documentId);
    }

    return null;
  }

  Future<List<Archive>> getArchives(
      int? userIdQuery, ArchiveStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.archives(
          token!,
          userIdQuery?.toString(),
          statusQuery?.name);
    }

    return [];
  }

  Future<List<Archive>> getUserArchives(ArchiveStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.archivesMe(
          token!, statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<Archive?> createArchiveRequest(ArchiveDTO archiveDTO) async {
    if (token != null) {
      return await ApiService.archivesCreate(token!, archiveDTO);
    }

    return null;
  }

  Future<(Archive?, String)> archiveDocument(int documentId, ArchiveStatus status) async {
    if (token != null) {
      Archive? rValue = await ApiService.archivesArchiveDocument(
          token!, documentId.toString(), status.name);
      await updateNotifications();
      return (rValue, rValue == null ? "Success" : "Error");
    }

    return (null, "Error");
  }

  Future<Archive?> getArchiveByID(int documentId) async {
    if (token != null) {
      return await ApiService.archivesDocument(token!, documentId);
    }

    return null;
  }

  Future<List<Signature>> getSignatures(
      int? userIdQuery, SignatureStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.signatures(
          token!,
          userIdQuery != null ? userIdQuery.toString() : '',
          statusQuery != null ? statusQuery.name : '');
    }

    return [];
  }

  Future<List<Signature>> getUserSignatures(
      SignatureStatus? statusQuery) async {
    if (token != null) {
      return await ApiService.signaturesMe(
          token!, statusQuery?.name);
    }

    return [];
  }

  Future<Signature?> createSignatureRequest(SignatureDTO signatureDTO) async {
    if (token != null) {
      return await ApiService.signaturesCreate(token!, signatureDTO);
    }

    return null;
  }

  Future<(Signature?, String)> signDocument(int documentId) async {
    if (token != null) {
      Signature? rValue = await ApiService.signaturesDocument(token!, documentId.toString());
      await updateNotifications();
      return (rValue, rValue == null ? "Success" : "Error");
    }

    return (null, "Error");
  }

  Future<int> getUserAuditPendingCount() async {
    if (token != null) {
      return await ApiService.auditsMePending(token!);
    }

    return 0;
  }

  Future<int> getUserArchivePendingCount() async {
    if (token != null) {
      return await ApiService.archivesMePending(token!);
    }

    return 0;
  }

  Future<int> getUserSignaturePendingCount() async {
    if (token != null) {
      return await ApiService.signaturesMePending(token!);
    }

    return 0;
  }

  Future<void> getUserStatistics(String username) async {
    if (token != null) {
      return await ApiService.usersStatisticsUsername(token!, username);
    }

    return;
  }

  Future<ImageProvider?> apiDocumentsTest() async {
    final byteData = await rootBundle.load('assets/test_img.jpeg');

    final file = File('${(await getTemporaryDirectory()).path}/test_img.jpeg');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

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
        print(doc.id.toString() +
            " " +
            doc.documentType.name +
            " " +
            doc.documentStatus.name);
      }
    }

    ImageProvider? submitted = await getImageByID(newDoc.imageId);
    Uint8List? uint =
        await ApiService.documentsImage(token!, newDoc.imageId.toString());
    print("image good: " +
        (uint.toString() ==
                byteData.buffer
                    .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
                    .toString())
            .toString());

    print("old status: " + newDoc.documentStatus.name);
    newDoc = await approveDocument(newDoc.id, true);
    print("new status: " + newDoc!.documentStatus.name);

    /*
    List<Document> refusedDocs = await getDocuments(DocumentType.internal, DocumentStatus.refused);
    print(refusedDocs.length);

    Document? firstDoc = await getDocumentByID(1);
    if (firstDoc != null) {
      print("first doc: " + firstDoc.documentType.name + " " + firstDoc.documentStatus.name);
    } else {
      print("first not found!");
    }


     */
    return submitted;
  }

  Future<void> apiAuditArchiveTest() async {
    final byteData = await rootBundle.load('assets/test_img.jpeg');

    final file = File('${(await getTemporaryDirectory()).path}/test_img.jpeg');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    Document? newDoc1 = await createDocument(file.path);
    Document? newDoc2 = await createDocument(file.path);
    int newDoc1Id = newDoc1!.id;
    int newDoc2Id = newDoc2!.id;

    Audit? audit1 = await createAuditRequest(new AuditDTO(25, newDoc1Id));
    Audit? audit2 = await createAuditRequest(new AuditDTO(25, newDoc2Id));
    print(audit1);
    print(audit2);

    Document? newDoc3 = await createDocument(file.path);
    int newDoc3Id = newDoc3!.id;
    Archive? archive1 =
        await createArchiveRequest(new ArchiveDTO(25, newDoc3Id));
    print(archive1);

    return;
  }

  Future<void> apiSignaturesTest() async {
    /*
    int signatureId = 102;
    Signature? newSignature = await createSignatureRequest(new SignatureDTO(21, signatureId));
    print(newSignature!.status.toString() + " " + newSignature!.document.id.toString());

    List<Signature> listSignatures = await getSignatures(null, null);
    print(listSignatures);

    newSignature = await signDocument(signatureId);
    print(newSignature!.status.toString() + " " + newSignature!.document.id.toString());
    */

    List<Signature> listSignaturesMy =
        await getUserSignatures(SignatureStatus.done);
    print(listSignaturesMy);

    return;
  }
}
