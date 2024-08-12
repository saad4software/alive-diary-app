import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDiary extends StatelessWidget {

  final DiaryModel item;
  final bool isRemovable;
  final void Function(DiaryModel item)? onRemove;
  final void Function(DiaryModel item)? onItemPressed;
  const ItemDiary({
    super.key,
    required this.item,
    this.onItemPressed,
    this.onRemove,
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
        child: Text(
          name ?? "",
          style: GoogleFonts.permanentMarker(
            fontSize: 20,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
