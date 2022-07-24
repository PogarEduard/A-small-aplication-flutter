import 'package:flutter/material.dart';

class MyObj extends StatelessWidget {
  final playerX;
  final playerY;

  MyObj({this.playerX, this.playerY});

  @override
  Widget build(BuildContext context) {
    var objWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment(playerX, playerY),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: objWidth * 0.05,
          height: objWidth * 0.05,
          child: Image(
              image: NetworkImage(
                  'https://scontent.fotp3-3.fna.fbcdn.net/v/t39.30808-6/285319621_2342288695911633_9189623479155141218_n.jpg?stp=dst-jpg_p206x206&_nc_cat=103&ccb=1-7&_nc_sid=da31f3&_nc_ohc=vCXozmz0g38AX_vyMBh&tn=dUnsF2ULJC64Jn71&_nc_ht=scontent.fotp3-3.fna&oh=00_AT-ExpNVABR1tpDXeMyNfIqAyJbx_ozvd_Wipom_hbPJ_g&oe=62DDD221')),
        ),
      ),
    );
  }
}
