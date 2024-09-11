// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class Video extends StatefulWidget {
//   const Video({super.key});
//
//   @override
//   State<Video> createState() => _VideoState();
// }
//
// class _VideoState extends State<Video> {
//   late final PodPlayerController controller;
//   @override
//   void initState() {
//     controller = PodPlayerController(
//       playVideoFrom: PlayVideoFrom.youtube(
//         'https://youtu.be/nUdyGwa-hIY',
//       ),
//         podPlayerConfig: const PodPlayerConfig(
//             autoPlay: false,
//             isLooping: false,
//         )
//     )..initialise();
//     super.initState();
//   }
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//
//               Text(
//                 'Trailers',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 22.sp,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               PodVideoPlayer(controller: controller,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
