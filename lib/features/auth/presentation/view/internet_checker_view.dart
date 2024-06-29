// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:playforge/core/common/internet_checker/internet_checker_view_model.dart';
//
// class InternetCheckerView extends ConsumerWidget {
//   const InternetCheckerView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //check for internet
//     final connectivityStatus = ref.watch(connectivityStatusProvider);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Internet checker'),
//         ),
//         body: connectivityStatus == ConnectivityStatus.isConnected
//             ? const Center(
//                 child: Text(
//                   'Connected',
//                   style: TextStyle(fontSize: 25),
//                 ),
//               )
//             : const Center(
//                 child: Text(
//                   'Disconnected',
//                   style: TextStyle(fontSize: 25),
//                 ),
//               ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/common/internet_checker/internet_checker_view_model.dart';

class InternetCheckView extends StatelessWidget {
  const InternetCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Check'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final connectivityStatus = ref.watch(connectivityStatusProvider);
            if (connectivityStatus == ConnectivityStatus.isConnected) {
              return const Text(
                'Connected',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return const Text(
                'Disconnected',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
