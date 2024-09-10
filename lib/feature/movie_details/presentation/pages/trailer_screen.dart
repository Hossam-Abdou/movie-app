//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../../../../utils/app_colors/app_colors.dart';
// import '../../data/repository/get_trailer_repo/get_trailer_repo_impl.dart';
// import '../manager/get_trailer_cubit/get_trailer_cubit.dart';
// import '../manager/get_trailer_cubit/get_trailer_state.dart';
// class TrailerScreen extends StatefulWidget {
//   const TrailerScreen({super.key});
//   static const String routeName = "trailer";
//
//   @override
//   _TrailerScreenState createState() => _TrailerScreenState();
// }
//
// class _TrailerScreenState extends State<TrailerScreen> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int id = ModalRoute.of(context)!.settings.arguments as int;
//     return BlocProvider(
//       create: (context) => GetTrailerCubit(GetTrailerRepoImp())..getTrailer(id: id),
//       child: Scaffold(
//         body: BlocBuilder<GetTrailerCubit, GetTrailerState>(
//           builder: (context, state) {
//             if (state is GetTrailerSuccess) {
//               _controller = YoutubePlayerController(
//                 initialVideoId: state.trailer.title ?? "",
//                 flags: const YoutubePlayerFlags(
//                   autoPlay: true,
//                   mute: false,
//                 ),
//               );
//
//               return Center(
//                 child: AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: YoutubePlayer(
//                     controller: _controller,
//                     showVideoProgressIndicator: true,
//                     onReady: () {
//                       _controller.play();
//                     },
//                   ),
//                 ),
//               );
//             } else if (state is GetTrailerFailure) {
//               return const Center(
//                 child: Text(
//                   'Failed to load trailer',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.yellowColor,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
