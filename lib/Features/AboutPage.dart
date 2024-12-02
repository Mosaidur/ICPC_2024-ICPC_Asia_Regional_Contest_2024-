import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  // Function to open a URL
  void _openWebpage(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(url: url), // Show loading screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildClickableContainer(
              context,
              'About ICPC',
              'https://icpc.daffodilvarsity.edu.bd/about-icpc',
            ),
            const SizedBox(height: 16),
            _buildClickableContainer(
              context,
              'About DIU',
              'https://icpc.daffodilvarsity.edu.bd/about-diu',
            ),
            const SizedBox(height: 16),
            _buildClickableContainer(
              context,
              'About Club',
              'https://icpc.daffodilvarsity.edu.bd/about-cpc',
            ),
            const SizedBox(height: 16),
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
      await launch(
        widget.url,
        forceWebView: true,
        enableJavaScript: true,
      );
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
              'Loading the webpage...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}