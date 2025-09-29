import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


// The main function is the starting point for all Flutter apps.
void main() {
  runApp(MyPortfolioApp());
}

// This is the root widget of the application.
class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the base widget that sets up the app.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Bilal Ahmed Portfolio',
      // Define a new theme to apply styles across the app.
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        // FIX: Changed CardTheme to CardThemeData as required by ThemeData.cardTheme
        cardTheme: CardThemeData(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyMedium: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
      home: MainScreen(), // Set the home screen to the new MainScreen
    );
  }
}

// --- MainScreen with Bottom Navigation Bar ---
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // List of pages to be displayed in the tabs
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AboutPage(),
    EducationPage(),
    ProjectsPage(),
    AchievementsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of titles for the AppBar corresponding to each tab
  final List<String> _appBarTitles = [
    'Home',
    'About Me',
    'Education',
    'Projects',
    'Achievements & Skills'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

// --- 1. HomePage ---
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            // FIX: Replaced .withOpacity() with .withAlpha()
            backgroundColor: Colors.teal.withAlpha(51), // 0.2 * 255 = 51
            child: Icon(Icons.person, size: 100, color: Colors.teal),
          ),
          SizedBox(height: 20),
          Text(
            'BILAL AHMED',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tech Enthusiast & Aspiring Developer',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. AboutPage ---
class AboutPage extends StatelessWidget {
  // Helper to launch URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        _buildInfoCard(
          context,
          'Career Objective',
          'Seeking an entry level position in tech industry where I can utilize my computing skills for professional and organizational growth.',
          Icons.work_outline,
        ),
        _buildInfoCard(
          context,
          'Contact Information',
          '',
          Icons.contact_mail,
          children: [
            ListTile(
              leading: Icon(Icons.phone, color: Colors.teal),
              title: Text('9642508720'),
              onTap: () => _launchUrl('tel:9642508720'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.teal),
              title: Text('bilalahmed2108.2005@gmail.com'),
              onTap: () => _launchUrl('mailto:bilalahmed2108.2005@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.link, color: Colors.teal),
              title: Text('LinkedIn Profile'),
              onTap: () => _launchUrl(
                  'https://www.linkedin.com/in/bilal-ahmed-301689318'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String content,
      IconData icon, {List<Widget>? children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal, size: 28),
                SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Divider(height: 20, thickness: 1),
            if (content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(content, style: Theme.of(context).textTheme.bodyMedium),
              ),
            if (children != null) ...children,
          ],
        ),
      ),
    );
  }
}

// --- 3. EducationPage ---
class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        _buildEducationCard(
          context,
          'Pursuing B.Tech, CSE',
          'JNTUH',
          '2023 - 2027',
          'CGPA: 7.4',
        ),
        _buildEducationCard(
          context,
          '12th Grade, MPC',
          'SSC Board',
          '2021 - 2023',
          'Score: 795',
        ),
        _buildEducationCard(
          context,
          '10th Grade',
          'CBSE Board',
          '2021',
          'Percentage: 79.5%',
        ),
      ],
    );
  }

  Widget _buildEducationCard(BuildContext context, String course,
      String university, String year, String grade) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.school, color: Colors.teal, size: 40),
        title: Text(course, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text('$university\n$year\n$grade'),
        isThreeLine: true,
      ),
    );
  }
}

// --- 4. ProjectsPage ---
class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        _buildProjectCard(
          context,
          'Data Science Intern - SB Solutions',
          'Developed and fine-tuned AI models, created Python libraries for data processing, and worked with Hugging Face, Docker, web scraping, and Azure AI Foundry.',
          '5-Month Internship',
        ),
        _buildProjectCard(
          context,
          'Data Analysis using Excel',
          'Conducted data cleaning and preprocessing using Excel functions. Applied statistical analysis to identify trends and patterns.',
          'Personal Project',
        ),
        _buildProjectCard(
          context,
          'Data Visualization using R',
          'Built dynamic visualizations with ggplot2 and plotly. Explored large datasets to uncover insights through various charts.',
          'Personal Project',
        ),
        _buildProjectCard(
          context,
          'Testing of Hypothesis',
          'Formulated and tested null and alternative hypotheses for real-world datasets.',
          'Personal Project',
        ),
      ],
    );
  }

  Widget _buildProjectCard(
      BuildContext context, String title, String description, String role) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 4),
            Text(role,
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey[600])),
            Divider(height: 20),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

// --- 5. AchievementsPage ---
class AchievementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionCard(
          context,
          'Achievements',
          Icons.emoji_events,
          [
            'Project Team Lead (SB Solutions, C R Rao AIMSCS)',
            'AI Research Team Member (CR Rao AIMSCS)',
          ],
        ),
        _buildSectionCard(
          context,
          'Certifications',
          Icons.card_membership,
          [
            'Introduction to Artificial Intelligence - Great learning',
            'Python Libraries for Machine Learning - Great learning',
            'Data Science Foundations - Great learning',
            'R for Data Science - Cognitive class.ai',
            'Applications of AI and AI Fundamentals - Great learning',
            'Data Structures in C - Great learning',
            'Google AI Essentials - GOOGLE',
          ],
        ),
        _buildSectionCard(
          context,
          'Technical Skills',
          Icons.code,
          [],
          children: [
            _buildSkillCategory('Programming Languages', 'Java, Python, C, R'),
            _buildSkillCategory('Frameworks', 'TensorFlow (Keras), Scikit-Learn, Matplotlib, Seaborn, Transformers'),
            _buildSkillCategory('Developer Tools', 'Git, VS Code, Visual Studio, PyCharm, Eclipse, Hugging Face, Docker, PyPi'),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, String title, IconData icon, List<String> items,
    {List<Widget>? children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal, size: 28),
                SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Divider(height: 20, thickness: 1),
            ...items.map<Widget>((item) => Padding( // Explicit type argument for map
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                      Expanded(
                          child: Text(item,
                              style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                )),
            if (children != null) ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCategory(String title, String skills){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text(skills, style: TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}