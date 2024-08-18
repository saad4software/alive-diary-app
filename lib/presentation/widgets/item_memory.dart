import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class ItemMemory extends StatelessWidget {

  final MemoryModel item;
  final bool isRemovable;
  final void Function(MemoryModel item)? onRemove;
  final void Function(MemoryModel item)? onShare;
  final void Function(MemoryModel item)? onItemPressed;
  final bool showContextMenu;
  const ItemMemory({
    super.key,
    required this.item,
    this.onItemPressed,
    this.showContextMenu=false,
    this.onRemove,
    this.onShare,
    this.isRemovable = false,
  });

  @override
  Widget build(BuildContext context) {

    final name = item.isMemory! ? item.title :  "${item.firstName} ${item.lastName}'s diary";
    final num = item.id! % 2 == 0 ? 2 : item.id! % 3 == 0 ? 3 : item.id! % 4 == 0 ? 4 : 1;

    final double rightPadding = num == 1 ? 80 : 20;
    return GestureDetector(
      onTap: ()=>onItemPressed?.call(item),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/book${num}.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.fromLTRB(20, 20, rightPadding , 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name ?? "",
              style: GoogleFonts.permanentMarker(
                fontSize: 20,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,


            ),
            showContextMenu ?
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(child: Row(
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 10,),
                    Text(AppLocale.share.getString(context)),
                  ],),
                  onTap: ()=>onShare?.call(item),
                ),
                PopupMenuItem(onTap: ()=>onRemove?.call(item),
                  enabled: onRemove != null,child: Row(
                  children: [
                    const Icon(Icons.delete, color: Colors.red,),
                    const SizedBox(width: 10,),
                    Text(AppLocale.delete.getString(context), style: const TextStyle(color: Colors.red),),
                  ],),
                ),
              ],
              icon: const Icon(Icons.more, color: Colors.amber,),
              offset: const Offset(30, 40),
            ) :
            Container(),
          ],
        ),
      ),
    );
  }
}
