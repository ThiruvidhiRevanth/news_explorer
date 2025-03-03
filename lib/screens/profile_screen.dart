import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:news_explorer/Theme/theme_provider.dart'; // Theme Provider

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<UserCredential?> userCredential = ValueNotifier(null);
    

  @override
  Widget build(BuildContext context) {
     var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
     body: Column(
  crossAxisAlignment: CrossAxisAlignment.start, 
  children: [
    Expanded(
      child: ValueListenableBuilder(
        valueListenable: userCredential,
        builder: (context, value, child) {
          return userCredential.value == null
              ? Center(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      iconSize: 40,
                      icon: Image.asset(
                        'assests/images/google.png',
                        height: 40,
                        width: 40,
                      ),
                      onPressed: () async {
                        UserCredential? credential = await signInWithGoogle();
                        if (credential != null) {
                          userCredential.value = credential;
                        }
                      },
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(120,0,0,0),
                child:Column(
                
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    ClipOval(
                      child: Image.network(
                        userCredential.value!.user!.photoURL ?? '',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(userCredential.value!.user!.displayName ?? 'No Name'),
                    SizedBox(height: 10),
                    Text(userCredential.value!.user!.email ?? 'No Email'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        bool result = await signOutFromGoogle();
                        if (result) userCredential.value = null;
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ));
        },
      ),
    ),

    Divider(
      indent: 15,
      endIndent: 15,
      thickness: 0.7,
    ),
    SizedBox(height: 10),

    // Settings section (Dark Mode, Notification, Social Media)
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark Mode", style: TextStyle(fontSize: 18)),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Notification", style: TextStyle(fontSize: 18)),
              Switch(
                value: false, // Replace with actual notification state
                onChanged: (value) {
                  // Handle notification toggle
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Social Media", style: TextStyle(fontSize: 18)),
              Switch(
                value: false, // Replace with actual social media toggle state
                onChanged: (value) {
                  // Handle social media toggle
                },
              ),
            ],
          ),
        ],
      ),
    ),

    SizedBox(height: 180), // Space at the bottom
  ],
),

    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Exception -> $e');
      return null;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }


}
