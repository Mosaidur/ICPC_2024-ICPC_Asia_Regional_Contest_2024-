import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreliminaryContestPage extends StatelessWidget {
  const PreliminaryContestPage({Key? key}) : super(key: key);

  // Function to open a URL with a loading screen
  void _openWebpage(BuildContext context, String url) {
    if (url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(url: url), // Show loading screen
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('URL not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preliminary Contest'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildClickableContainer(
              context,
              'Preliminary Schedule',
              'https://icpc.daffodilvarsity.edu.bd/preliminary-schedule',
            ),
            const SizedBox(height: 16),
            _buildClickableContainer(
              context,
              'Preliminary Rules',
              'https://icpc.daffodilvarsity.edu.bd/preliminary-rules',
            ),
            const SizedBox(height: 16),
            _buildClickableContainer(
              context,
              'Selected Teams',
              'https://icpc.daffodilvarsity.edu.bd/selected-teams-preliminary',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create clickable containers
  Widget _buildClickableContainer(BuildContext context, String title, String url) {
    return GestureDetector(
      onTap: () => _openWebpage(context, url),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
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
      await launchUrl(Uri.parse(widget.url), mode:  LaunchMode.inAppWebView);
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