import 'package:flutter/material.dart';

class AngsuranTile extends StatelessWidget {
  final String tanggal;
  final String title;
  final String deskripsi;
  final String? caraBayar;
  final VoidCallback? onDelete;
  const AngsuranTile({
    Key? key,
    required this.tanggal,
    required this.title,
    required this.deskripsi,
    this.caraBayar,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              tanggal,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deskripsi.isEmpty ? "<Kosong>" : deskripsi,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.45),
                      ),
                    ),
                    const SizedBox(height: 6),
                    caraBayar != null
                        ? Container(
                            padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.withOpacity(.2),
                            ),
                            child: Text(
                              caraBayar!,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
