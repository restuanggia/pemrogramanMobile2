import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiUpdateView extends GetView<PegawaiController> {
  const PegawaiUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Pegawai'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNip.text = data['nip'];
            controller.cNama.text = data['nama'];
            controller.cPangkat.text = data['pangkat'];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNip,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "NIP"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.cNama,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Nama"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: controller.cPangkat,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Pangkat"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNip.text,
                      controller.cNama.text,
                      controller.cPangkat.text,
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
