import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KaryawanController extends GetxController {
  //TODO: Implement MahasiswaController
  late TextEditingController cNo;
  late TextEditingController cNama;
  late TextEditingController cJabatan;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference karyawan = firestore.collection('karyawan_22312013');

    return karyawan.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference karyawan = firestore.collection('karyawan_22312013');
    return karyawan.snapshots();
  }

  void add(
      String no_karyawan, String nama_karyawan, String jabatan_karyawan) async {
    CollectionReference karyawan = firestore.collection("karyawan_22312013");

    try {
      await karyawan.add({
        "no_karyawan": no_karyawan,
        "nama_karyawan": nama_karyawan,
        "jabatan_karyawan": jabatan_karyawan
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data pegawai",
          onConfirm: () {
            cNo.clear();
            cNama.clear();
            cJabatan.clear();
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
        middleText: "Gagal Menambahkan Karyawan.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef =
        firestore.collection("karyawan_22312013").doc(id);

    return docRef.get();
  }

  void Update(String no_karyawan, String nama_karyawan, String jabatan_karyawan,
      String id) async {
    DocumentReference karyawanById =
        firestore.collection("karyawan_22312013").doc(id);

    try {
      await karyawanById.update({
        "no_karyawan": no_karyawan,
        "nama_karyawan": nama_karyawan,
        "jabatan_karyawan": jabatan_karyawan
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Karyawan.",
        onConfirm: () {
          cNo.clear();
          cNama.clear();
          cJabatan.clear();
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
        middleText: "Gagal Merubah Karyawan.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef =
        firestore.collection("karyawan_22312013").doc(id);

    try {
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
          Get.defaultDialog(
            title: "Sukses",
            middleText: "Berhasil menghapus data karyawan",
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
    cNo = TextEditingController();
    cNama = TextEditingController();
    cJabatan = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNo.dispose();
    cNama.dispose();
    cJabatan.dispose();
    super.onClose();
  }
}
