import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitteePage extends StatelessWidget {
  // URL to launch
  final String url = 'https://icpc.daffodilvarsity.edu.bd/committee';

  @override
  Widget build(BuildContext context) {
    // Automatically navigate to LoadingScreen first when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(url: url),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Committee')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Launch the URL when the button is pressed
            if (await canLaunch(url)) {
              await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Container(),
        ),
      ),
    );
  }
}

// Loading screen with progress bar and animation before going to the web page
class LoadingScreen extends StatefulWidget {
  final String url;

  const LoadingScreen({Key? key, required this.url}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _loadingComplete = false;
  late DateTime _loadingStartTime;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  // Simulate loading and then launch the URL
  Future<void> _startLoading() async {
    _loadingStartTime = DateTime.now();

    await Future.delayed(const Duration(seconds: 2)); // Minimum loading time

    if (await canLaunch(widget.url)) {
      await launchUrl(Uri.parse(widget.url), mode: LaunchMode.inAppWebView);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the webpage')),
      );
    }

    final duration = DateTime.now().difference(_loadingStartTime).inSeconds;

    if (duration < 2) {
      // Wait for the remaining time to complete 2 seconds
      await Future.delayed(Duration(seconds: 2 - duration));
    }

    setState(() {
      _loadingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingComplete) {
      // Automatically pop the loading screen when done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/images/cpcLogo.png',
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              'Loading Please Wait...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
