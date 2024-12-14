import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiAddView extends GetView<PegawaiController> {
  const PegawaiAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pegawai'),
        centerTitle: true,
      ),
      body: Padding(
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
              onPressed: () => controller.add(
                controller.cNip.text,
                controller.cNama.text,
                controller.cPangkat.text,
              ),
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
