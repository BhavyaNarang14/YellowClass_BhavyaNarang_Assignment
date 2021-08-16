import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterhivesample/google/sign_up_widget.dart';
// import 'package:google_signin_example/provider/google_sign_in.dart';
// import 'package:google_signin_example/widget/background_painter.dart';
// import 'package:google_signin_example/widget/logged_in_widget.dart';
// import 'package:google_signin_example/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';

import '../movie_list_screen.dart';
import 'background_painter.dart';
import 'google_sign_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);

          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            return MoviesListScreen();
          } else {
            return SignUpWidget();
          }
        },
      ),
    ),
  );

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      CustomPaint(painter: BackgroundPainter()),
      Center(child: CircularProgressIndicator()),
    ],
  );
}
