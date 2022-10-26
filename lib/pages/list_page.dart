import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/provider/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';
import 'package:qrreader/widgets/update_modal.dart';

class CustomListPage extends StatelessWidget {
  final String type;

  const CustomListPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<ScanListProvider>(context);
    db.loadByType(type);
    return SizedBox(
      child: db.scans.isEmpty
          ? Container(
              height: double.infinity,
              child: Center(
                child: SvgPicture.asset(
                  "assets/empty_placeholder.svg",
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  width: 200,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: db.scans.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    tileColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onTap: () {
                      launchUrl(db.scans[index], context);
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (_) => UpdateDialog(scan: db.scans[index]));
                    },
                    title: Text(db.scans[index].title.toString()),
                    subtitle: Text(db.scans[index].valor),
                    trailing: IconButton(
                      onPressed: () {
                        db.deleteById(db.scans[index].id);
                        db.scans.remove(db.scans[index]);
                      },
                      icon: const Icon(Icons.delete_forever_rounded),
                    ),
                    leading: db.scans[index].tipo == "http"
                        ? const Icon(Icons.link)
                        : const Icon(Icons.map),
                  ),
                );
              }),
    );
  }
}
