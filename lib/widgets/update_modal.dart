import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/models/scan_models.dart';

import '../provider/scan_list_provider.dart';

class UpdateDialog extends StatelessWidget {
  final ScanModel scan;
  const UpdateDialog({Key? key, required this.scan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<ScanListProvider>(context, listen: false);
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(15),
      titlePadding: const EdgeInsets.all(10),
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: const Center(child: Text("Set new title")),
      children: [
        TextField(
          onChanged: (title) async {
            ScanModel updatedScan = ScanModel(
              valor: scan.valor,
              tipo: scan.tipo,
              title: title,
              id: scan.id,
            );
            await db.update(updatedScan);
          },
          decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              filled: false,
              labelText: 'Title',
              hintText: 'type you title'),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("save"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),
      ],
      alignment: Alignment.center,
    );
  }
}
