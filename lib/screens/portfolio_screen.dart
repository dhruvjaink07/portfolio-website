import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _skillsSectionKey = GlobalKey();
  final GlobalKey _experienceSection = GlobalKey();
  final GlobalKey _homeSection = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHomeSection(context),
            _buildAboutSection(context),
            _buildExperienceSection(context),
            _buildProjectsSection(context),
            _buildSkillsSection(context),
            _buildContactSection(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollToHome,
        child: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  Widget _buildHomeSection(BuildContext context) {
    return Container(
      key: _homeSection,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: const AlwaysStoppedAnimation(1.0),
                  builder: (context, child) {
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(seconds: 1),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: Text(
                        'Dhruv K. Jain',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                AnimatedBuilder(
                  animation: const AlwaysStoppedAnimation(1.0),
                  builder: (context, child) {
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(seconds: 1),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: Text(
                        'Flutter Developer | 2nd Year Engineering Student | India',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Me', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          Text(
            'Passionate Flutter developer with a keen interest in creating beautiful and functional mobile applications. Currently pursuing my engineering degree and constantly learning new technologies. Apart from this I love attending meetups and hackathons to learn and grow. I am always open to new opportunities and collaborations. If you are a startup or an individual looking to create an app or website, I am here to help you!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20, // Horizontal spacing between cards
            runSpacing: 20, // Vertical spacing between rows when wrapped
            children: [
              _buildStatCard(context, '3+', 'Projects', () {
                _scrollToProjects();
              }),
              _buildStatCard(context, '5+', 'Skills', () {
                _scrollToSkills();
              }),
              _buildStatCard(context, '1', 'Years Exp.', () {
                _scrollToExperience();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, String value, String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final List<Map<String, String>> projects = [
      {
        'title': 'Picture of the Day',
        'description':
            'An app to get the Astronomy Picture of the Day using a public API.',
        'image': 'assets/project1.png',
        'link': 'https://github.com/dhruvjaink07/Picture-of-day'
      },
      {
        'title': 'Music Player',
        'description': 'A simple music player app with a custom UI.',
        'image': 'assets/project2.png',
        'link': 'https://github.com/dhruvjaink07/android-MusicPlayer'
      },
      {
        'title': 'Weather App',
        'description':
            'An app that displays weather information using a public API.',
        'image': 'assets/project3.png',
        'link': 'https://github.com/dhruvjaink07/skySee'
      },
    ];

    return Container(
      key: _projectsSectionKey, // Assign key to projects section
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Projects', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildProjectCard(context, projects[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, String> project) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                project['image']!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title']!,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  project['description']!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _launchURL(project['link']!);
                  },
                  child: const Text('Learn More'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Flutter', 'level': 0.8},
      {'name': 'Dart', 'level': 0.8},
      {'name': 'Flask', 'level': 0.6},
      {'name': 'Firebase', 'level': 0.6},
      {'name': 'Git', 'level': 0.7},
      {'name': 'REST APIs', 'level': 0.6},
      {'name': 'App Publishing', 'level': 0.7},
    ];

    return Container(
      key: _skillsSectionKey,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Skills', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildSkillCard(context, skills[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill['name'],
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 5),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: skill['level']),
              duration: const Duration(seconds: 1),
              builder: (context, double value, child) {
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary),
                );
              },
            ),
            // const SizedBox(height: 8),
            // Text(
            //   '${(skill['level'] * 100).toInt()}%',
            //   style: TextStyle(
            //     color: Theme.of(context).colorScheme.secondary,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    final List<Map<String, String>> experiences = [
      {
        'position': 'Flutter Developer Intern',
        'company': 'Digilateral Solutions Pvt. Ltd.',
        'duration': 'January 2024 - July 2024',
        'description':
            'Developed and maintained mobile applications using Flutter. Worked on various projects from design to deployment. Collaborated with the team to create a seamless user experience.'
      },
    ];

    return Container(
      key: _experienceSection,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Experience', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildExperienceCard(context, experiences[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
      BuildContext context, Map<String, String> experience) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience['position']!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              experience['company']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              experience['duration']!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              experience['description']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final String email = 'dhruvkishorjain2506@gmail.com';
    final String github = 'https://github.com/dhruvjaink07';
    final String linkedin = 'https://www.linkedin.com/in/dhruv-jain-0ab564251';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Me', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          Text(
            'Feel free to reach out for collaborations or just a friendly hello!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          _buildContactCard(context, Icons.email, 'Email', email,
              () => _launchURL('mailto:$email')),
          const SizedBox(height: 10),
          _buildContactCard(
              context, Icons.code, 'GitHub', github, () => _launchURL(github)),
          const SizedBox(height: 10),
          _buildContactCard(context, Icons.work, 'LinkedIn', linkedin,
              () => _launchURL(linkedin)),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
        title: Text(title, style: Theme.of(context).textTheme.displaySmall),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  void _scrollToProjects() {
    Scrollable.ensureVisible(
      _projectsSectionKey.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToSkills() {
    Scrollable.ensureVisible(_skillsSectionKey.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _scrollToExperience() {
    Scrollable.ensureVisible(_experienceSection.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _scrollToHome() {
    Scrollable.ensureVisible(_homeSection.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
