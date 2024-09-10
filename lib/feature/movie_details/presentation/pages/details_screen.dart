import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/details_section.dart';
import '../widgets/more_like_this_item.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  static const String id = "DetailsScreen";

  @override
  Widget build(BuildContext context) {
    int id=ModalRoute.of(context)!.settings.arguments as int;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsSection(id: id,),
            SizedBox(height: 20.h,),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: 24.w),
              child: Text('More Like This',style:GoogleFonts.inter(fontSize: 15,color:Colors.white),),
            ),
            SizedBox(height: 20.h,),
            MoreLikeThisList(id: id,)
          ],
        ),
      ),
    );
  }
}
