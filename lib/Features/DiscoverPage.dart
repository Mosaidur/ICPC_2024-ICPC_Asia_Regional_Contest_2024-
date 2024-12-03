import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoverPage extends StatelessWidget {
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
        title: const Text('Discover Daffodil Smart City'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildClickableContainer(
                context,
                'স্বাধীনতা সম্মেলন কেন্দ্র',
                'https://maps.app.goo.gl/FnFtbQr9BV87enqz9',
              ),
              _buildClickableContainer(
                context,
                'International Conference Hall',
                'https://maps.app.goo.gl/KoZ8PfpnUwzuQPg66',
              ),
              _buildClickableContainer(
                context,
                'Food Court',
                'https://maps.app.goo.gl/jVhWaEJsAs2EMrDQ9',
              ),
              _buildClickableContainer(
                context,
                'Green Garden',
                'https://maps.app.goo.gl/foRbnKKvLzRav3Nr9',
              ),
              _buildClickableContainer(
                context,
                'Knowledge Tower (AB4)',
                'https://maps.app.goo.gl/mz11jctBFwuRvy3j7',
              ),
              _buildClickableContainer(
                context,
                'Inspiration Building (AB1)',
                'https://maps.app.goo.gl/SVKw4QS5Tkik54tc9',
              ),
              _buildClickableContainer(
                context,
                'DIU Central Jame Masjid',
                'https://maps.app.goo.gl/xfJEgryG5myLyy3A7',
              ),
              _buildClickableContainer(
                context,
                'DIU Library',
                'https://maps.app.goo.gl/X7ptC5NppQyuftJNA',
              ),
              _buildClickableContainer(
                context,
                'DIU Mini Lake',
                'https://maps.app.goo.gl/wfkKihEbfmWu5QaJ7',
              ),
              _buildClickableContainer(
                context,
                'DIU Lake Side',
                'https://maps.app.goo.gl/5Zm7d9oLJ1xARZ5D6',
              ),
              _buildClickableContainer(
                context,
                'DIU Bus Stand',
                'https://maps.app.goo.gl/ZMyoxRBb4Um8ocBbA',
              ),
              _buildClickableContainer(
                context,
                'DIU Parking Space',
                'https://maps.app.goo.gl/AS53nC9yRNeh3Ehz6',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create clickable containers
  Widget _buildClickableContainer(BuildContext context, String title, String url) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => _openWebpage(context, url),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
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
            ],
          ),
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
      await launchUrl(
        Uri.parse(widget.url),
        mode: LaunchMode.externalApplication,  // Open the URL inside the app using a webview
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
              'Loading Please Wait...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
