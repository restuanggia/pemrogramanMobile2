import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PegawaiController extends GetxController {
  //TODO: Implement MahasiswaController
  late TextEditingController cNip;
  late TextEditingController cNama;
  late TextEditingController cPangkat;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference pegawai = firestore.collection('pegawai');

    return pegawai.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference pegawai = firestore.collection('pegawai');
    return pegawai.snapshots();
  }

  void add(String nip, String nama, String pangkat) async {
    CollectionReference pegawai = firestore.collection("pegawai");

    try {
      await pegawai.add({"nip": nip, "nama": nama, "pangkat": pangkat});
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data pegawai",
          onConfirm: () {
            cNip.clear();
            cNama.clear();
            cPangkat.clear();
            Get.back();
            Get.back();
            Get.back();
            textConfirm:
            "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Pegawai.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("pegawai").doc(id);

    return docRef.get();
  }

  void Update(String nip, String nama, String pangkat, String id) async {
    DocumentReference pegawaiById = firestore.collection("pegawai").doc(id);

    try {
      await pegawaiById.update({"nip": nip, "nama": nama, "pangkat": pangkat});

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Pegawai.",
        onConfirm: () {
          cNip.clear();
          cNama.clear();
          cPangkat.clear();
          Get.back();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Pegawai.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef = firestore.collection("pegawai").doc(id);

    try {
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
          Get.defaultDialog(
            title: "Sukses",
            middleText: "Berhasil menghapus data pegawai",
          );
        },
        textConfirm: "Ya",
        textCancel: "Batal",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak berhasil menghapus data",
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNip = TextEditingController();
    cNama = TextEditingController();
    cPangkat = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNip.dispose();
    cNama.dispose();
    cPangkat.dispose();
    super.onClose();
  }
}
