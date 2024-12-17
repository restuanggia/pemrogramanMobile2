// import 'package:bcdx_11312136/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/karyawan/controllers/karyawan_controller.dart';
import 'package:myapp/app/modules/karyawan/views/karyawan_update_view.dart';
// import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_update_view.dart';
// import '../controllers/dosen_controller.dart';

class KaryawanView extends GetView<KaryawanController> {
  const KaryawanView({super.key});

  void showOption(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.to(
                const KaryawanUpdateView(),
                arguments: id,
              );
            },
            title: const Text('Update'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              controller.delete(id);
            },
            title: const Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: const Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: Get.put(KaryawanController()).streamData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // mengambil data
          var listAllDocs = snapshot.data?.docs ?? [];
          return listAllDocs.length > 0
              ? ListView.builder(
                  itemCount: listAllDocs.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Color.fromARGB(255, 248, 248, 248),
                    ),
                    title: Text(
                      "${(listAllDocs[index].data() as Map<String, dynamic>)["nama_karyawan"]}",
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["no_karyawan"]}"),
                        Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["jabatan_karyawan"]}"),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () => showOption(listAllDocs[index].id),
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                )
              : const Center(
                  child: Text("Data Kosong"),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
