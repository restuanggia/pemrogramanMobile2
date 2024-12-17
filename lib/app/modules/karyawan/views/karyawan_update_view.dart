import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/karyawan/controllers/karyawan_controller.dart';

class KaryawanUpdateView extends GetView<KaryawanController> {
  const KaryawanUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Karyawan'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNo.text = data['no_karyawan'];
            controller.cNama.text = data['nama_karyawan'];
            controller.cJabatan.text = data['jabatan_karyawan'];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNo,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "No Karyawan"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cNama,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(labelText: "Nama Karyawan"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: controller.cJabatan,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(labelText: "Jabatan Karyawan"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNo.text,
                      controller.cNama.text,
                      controller.cJabatan.text,
                      Get.arguments,
                    ),
                    child: const Text("Ubah"),
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
