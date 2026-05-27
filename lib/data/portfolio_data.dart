// lib/data/portfolio_data.dart
// ============================================================
// SINGLE SOURCE OF TRUTH — Edit this file to update the app.
// ============================================================

import 'package:flutter_portfolio/utils/utils.dart';

class PortfolioData {
  // ── Personal Info ──────────────────────────────────────────
  static const String name = 'Rishabh Dev Narayan';
  static const String tagline = 'Building Pixels That Matter';
  static const String email = 'dev000586@gmail.com';
  static const String phone = '+91 9651625217';
  static const String location = 'Noida, India 🇮🇳';
  static final DateTime startDate = DateTime(2020, 08, 20);
  static const String resumeUrl =
      'https://drive.google.com/file/d/1CsYAu5Ph3GBFbS0jG9y5M6sCVJqhVSC5/view?usp=drive_link';
  static final String aboutDescription =
      'I’m a passionate Flutter developer with ${Utils.getExperience(startDate)} years of experience crafting high-performance, '
      'scalable applications across Android, iOS, Web, and Desktop. I specialize in turning complex '
      'product ideas into elegant, maintainable solutions, with a strong focus on clean architecture '
      'and efficient state management. From building and customizing Flutter packages to optimizing '
      'app performance, I pay close attention to every detail—whether it’s a smooth animation or a'
      ' millisecond improvement in load time. I’m driven by creating seamless user experiences through '
      'responsive UI and robust engineering practices. Beyond development, I enjoy contributing to '
      'open-source projects, mentoring junior developers, and exploring new design systems to continuously'
      ' refine my craft.';

  // ── Animated Roles (Hero Section) ──────────────────────────
  static const List<String> roles = [
    'Senior Flutter Engineer',
    'Building Scalable Mobile Experiences',
    'Architecting High-Performance Apps',
    'Cross-Platform Solutions Expert',
    'Crafting Production-Ready Systems',
  ];

  // ── Social Links ───────────────────────────────────────────
  static const List<SocialLink> socialLinks = [
    SocialLink(
      label: 'GitHub',
      url: 'https://github.com/dev000586',
      icon: 'github',
    ),
    SocialLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/dev000586/',
      icon: 'linkedin',
    ),
    // SocialLink(
    //   label: 'Twitter',
    //   url: 'https://twitter.com/aryanmehta',
    //   icon: 'twitter',
    // ),
    // SocialLink(
    //   label: 'Medium',
    //   url: 'https://medium.com/@aryanmehta',
    //   icon: 'medium',
    // ),
    // SocialLink(
    //   label: 'YouTube',
    //   url: 'https://youtube.com/@aryanmehta',
    //   icon: 'youtube',
    // ),
  ];

  static String aboutTitle = 'Building Scalable\nFlutter Experiences';

  static final stats = [
    {'value': Utils.getExperience(startDate), 'label': 'Years\nExperience'},
    {'value': '30+', 'label': 'Apps\nDelivered'},
    {'value': '5+', 'label': 'Domains\nWorked'},
    {'value': '30%', 'label': 'Perf\nImprovement'},
    {'value': '7+', 'label': 'Devs\nMentored'},
    {'value': '20+', 'label': 'Interviews\nConducted'},
  ];

  static const List<String> aboutTags = [
    'Flutter',
    'Dart',
    'Cross-Platform',
    'Firebase',
    'REST APIs',
    'Clean Architecture',
    'BLoC',
    'GetX',
    'Performance',
    'App Optimization',
    'Open Source',
    'Mentoring',
  ];

  // ── Skills ─────────────────────────────────────────────────
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Core',
      skills: [
        Skill(name: 'Flutter', level: 0.97, tag: 'Framework'),
        Skill(name: 'Dart', level: 0.95, tag: 'Language'),
        Skill(
            name: 'Cross-Platform Development',
            level: 0.96,
            tag: 'Mobile/Web/Desktop'),
        Skill(name: 'Firebase', level: 0.90, tag: 'Backend'),
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      skills: [
        Skill(name: 'Clean Architecture', level: 0.94, tag: 'Pattern'),
        Skill(name: 'MVVM / MVC', level: 0.90, tag: 'Pattern'),
        Skill(name: 'BLoC / Cubit', level: 0.95, tag: 'State'),
        Skill(name: 'Provider / GetX', level: 0.92, tag: 'State'),
      ],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      skills: [
        Skill(name: 'REST APIs', level: 0.94, tag: 'Integration'),
        Skill(name: 'GraphQL', level: 0.85, tag: 'API'),
        Skill(name: 'Firebase Services', level: 0.90, tag: 'Auth/DB/FCM'),
        Skill(name: 'Third-Party SDKs', level: 0.92, tag: 'Integration'),
      ],
    ),
    SkillCategory(
      title: 'Databases & Storage',
      skills: [
        Skill(name: 'Firestore', level: 0.90, tag: 'NoSQL'),
        Skill(name: 'SQLite', level: 0.88, tag: 'Database'),
        Skill(name: 'Hive / ObjectBox', level: 0.89, tag: 'Local DB'),
        Skill(name: 'Secure Storage', level: 0.87, tag: 'Encryption'),
      ],
    ),
    SkillCategory(
      title: 'Performance & Quality',
      skills: [
        Skill(
            name: 'App Performance Optimization',
            level: 0.94,
            tag: 'Profiling'),
        Skill(name: 'Memory Optimization', level: 0.90, tag: 'Performance'),
        Skill(name: 'Unit Testing', level: 0.85, tag: 'Testing'),
        Skill(name: 'Code Reviews', level: 0.92, tag: 'Quality'),
      ],
    ),
    SkillCategory(
      title: 'Tools & DevOps',
      skills: [
        Skill(name: 'Git & GitHub', level: 0.96, tag: 'Version Control'),
        // Skill(name: 'CI/CD', level: 0.88, tag: 'Automation'),
        // Skill(name: 'Fastlane / Codemagic', level: 0.85, tag: 'Deploy'),
        Skill(name: 'Android Studio / VS Code', level: 0.95, tag: 'IDE'),
      ],
    ),
    SkillCategory(
      title: 'Platforms',
      skills: [
        Skill(name: 'Android', level: 0.93, tag: 'Mobile'),
        Skill(name: 'iOS', level: 0.88, tag: 'Mobile'),
        Skill(name: 'Flutter Web', level: 0.86, tag: 'Web'),
        Skill(name: 'Flutter Desktop', level: 0.80, tag: 'Desktop'),
      ],
    ),
    SkillCategory(
      title: 'Additional',
      skills: [
        Skill(name: 'Agile / Scrum', level: 0.90, tag: 'Process'),
        Skill(name: 'Mentoring', level: 0.92, tag: 'Leadership'),
        Skill(name: 'App Store Deployment', level: 0.91, tag: 'Release'),
        Skill(name: 'Open Source', level: 0.88, tag: 'Community'),
      ],
    ),
  ];

  static const List<String> techTags = [
    // Core
    'Flutter',
    'Dart',
    'Cross-Platform',

    // Architecture & State
    'Clean Architecture',
    'BLoC',
    'Cubit',
    'Provider',
    'GetX',
    'MVVM',
    'MVC',

    // Backend & APIs
    'REST API',
    'GraphQL',
    'Firebase',
    'Authentication',
    'FCM',
    'Third-Party SDKs',

    // Databases
    'Firestore',
    'SQLite',
    'Hive',
    'ObjectBox',
    'Secure Storage',

    // Performance
    'Performance Optimization',
    'App Profiling',
    'Memory Optimization',

    // Tools
    'Git',
    'GitHub',
    // 'CI/CD',
    // 'Fastlane',
    // 'Codemagic',

    // Platforms
    'Android',
    'iOS',
    'Web',
    'Desktop',

    // Quality & Process
    'Unit Testing',
    'Code Review',
    'Agile',
    'Scrum',

    // Extras
    'Open Source',
    'Mentoring',
    'App Deployment',
  ];

  // ── Experience ─────────────────────────────────────────────
  static const List<Experience> experiences = [
    Experience(
      company: 'Quokka Labs',
      role: 'Software Engineer L-2',
      duration: 'Nov 2022 – Present',
      location: 'Noida, India',
      description:
          'Leading end-to-end development of cross-platform Flutter applications for enterprise clients across multiple domains. Focused on scalable architecture, performance optimization, and clean coding practices.',
      highlights: [
        'Delivered 5+ scalable Flutter applications across 5+ domains',
        'Improved app startup time by 30% and reduced crash rates by 25%',
        'Reduced UI defects by 30–40% through better engineering practices',
        'Mentored 5–7 developers and reduced onboarding time by 40%',
        'Conducted 20+ technical interviews for mid & senior roles',
        'Accelerated development cycles by 35% via clean architecture',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST API',
        'Clean Architecture',
        'BLoC',
        'GetX',
        'GraphQL'
      ],
      isCurrent: true,
    ),
    Experience(
      company: 'Singsys',
      role: 'Software Engineer',
      duration: 'Aug 2020 – Nov 2022',
      location: 'Lucknow, India',
      description:
          'Worked on multiple mobile applications across Flutter, Android, and cross-platform technologies. Contributed to full app lifecycle including development, integration, testing, and deployment.',
      highlights: [
        'Built and maintained multiple production mobile applications',
        'Worked with Flutter, Android (Java/Kotlin), React Native & Ionic',
        'Integrated complex APIs and third-party SDKs',
        'Collaborated closely with design & backend teams',
        'Handled performance optimization and bug fixing across projects',
        'Adapted quickly to diverse tech stacks and requirements',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'Android',
        'Java',
        'Kotlin',
        'React Native',
        'Ionic',
        'Firebase',
        'REST API',
        'GraphQL'
      ],
      isCurrent: false,
    ),
  ];

  // ── Projects ───────────────────────────────────────────────
  static const List<Project> projects = [
    Project(
      title: 'MyWeb',
      subtitle: 'Secure Personal Digital Space',
      description:
          'Built a secure cross-platform app with encrypted storage and optimized data access.',
      techStack: [
        'Flutter',
        'Encryption',
        'Secure Storage',
        'Objectbox',
      ],
      categories: [ProjectCategory.mobile, ProjectCategory.desktop],
      featured: true,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.mywebapp.android',
      iosUrl:
          'https://apps.apple.com/us/app/myweb-personal-digital-space/id1549863749',
      imageAsset: 'assets/images/project_myweb.png',
      stats: {'Type': 'Privacy', 'Focus': 'Security'},
    ),
    Project(
      title: 'TToC',
      subtitle: 'Travel Itinerary Platform (Web)',
      description:
          'Built a Flutter web app from scratch for managing travel itineraries with dynamic UI and real-time workflows.',
      techStack: ['Flutter Web', 'Dart', 'Firestore', 'State Management'],
      categories: [ProjectCategory.web],
      featured: true,
      githubUrl: '',
      liveUrl: 'https://ttoc.app/',
      androidUrl: '',
      iosUrl: '',
      imageAsset: 'assets/images/project_ttoc.png',
      stats: {'Type': 'SaaS', 'Role': 'Lead Dev'},
    ),
    Project(
      title: 'Secfense Authenticator',
      subtitle: '2FA Security Application',
      description:
          'Maintained and enhanced a secure Flutter-based authenticator app with dynamic themes and optimized authentication flows.',
      techStack: [
        'Flutter',
        'REST API',
        'Security',
        'Encryption',
        'Analytics',
      ],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.droid.secfense&hl=en_IN',
      iosUrl:
          'https://apps.apple.com/us/app/secfense-authenticator/id1619375634',
      imageAsset: 'assets/images/project_secfense.png',
      stats: {'Type': 'Security', 'Feature': '2FA'},
    ),
    Project(
      title: 'Run The Day',
      subtitle: 'Sports Event Management Platform',
      description:
      'Developed and maintained a cross-platform Flutter application for sports event and tournament management, enabling users to organize, track, and participate in events seamlessly.',
      techStack: ['Flutter', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
      'https://play.google.com/store/apps/details?id=com.droid.eseosports',
      iosUrl:
      'https://apps.apple.com/in/app/run-the-day-formerly-eseo/id1589957665',
      imageAsset: 'assets/images/project_run_the_day.png',
      stats: {'Domain': 'Sports'},
    ),
    Project(
      title: 'GP World',
      subtitle: 'Lifestyle & Rewards Platform',
      description:
      'Built a feature-rich Flutter application for the Gourmet Planet ecosystem, providing users with an engaging platform for exploring services, rewards, and personalized experiences.',
      techStack: ['Flutter', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
      'https://play.google.com/store/apps/details?id=com.gourmetplanet.gpapplication',
      iosUrl:
      'https://apps.apple.com/in/app/gp-world/id1638079441',
      imageAsset: 'assets/images/project_gp_world.png',
      stats: {'Domain': 'Lifestyle'},
    ),

    Project(
      title: 'Rhubarb - Garden AI Superapp',
      subtitle: 'AI Powered Gardening Platform',
      description:
      'Developed an AI-powered Flutter super app focused on smart gardening and plant care solutions with modern UI/UX and scalable architecture.',
      techStack: ['Flutter', 'AI', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
      'https://play.google.com/store/apps/details?id=com.rhubarblabs.rhubarb',
      iosUrl:
      'https://apps.apple.com/us/app/rhubarb-garden-ai-superapp/id6474530874',
      imageAsset: 'assets/images/project_rhubarb.png',
      stats: {'Domain': 'AI & Gardening'},
    ),

    Project(
      title: 'ClearVisit',
      subtitle: 'Visitor Management Solution',
      description:
      'Developed a Flutter-based visitor management and appointment solution with secure authentication, real-time notifications, and optimized cross-platform performance.',
      techStack: ['Flutter', 'REST API', 'Firebase'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
      'https://play.google.com/store/apps/details?id=com.clearvisit.prod&hl=en_IN',
      iosUrl:
      'https://apps.apple.com/in/app/clearvisit/id6752611256',
      imageAsset: 'assets/images/project_clearvisit.png',
      stats: {'Domain': 'Enterprise'},
    ),
    Project(
      title: 'Adapt Aware',
      subtitle: 'Safety & Threat Awareness App',
      description:
          'Developed a real-time safety app with background location tracking, alerts, and performance optimizations.',
      techStack: ['Flutter', 'Location', 'REST API', 'Firebase'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.app.adapt.adapt_flutter',
      iosUrl: 'https://apps.apple.com/us/app/adapt-aware/id6504078203',
      imageAsset: 'assets/images/project_adapt.png',
      stats: {
        'Type': 'Safety',
        'Feature': 'Live Tracking',
      },
    ),
    Project(
      title: 'Pulse+',
      subtitle: 'News & Podcast Platform',
      description:
          'Enhanced a production Flutter app delivering curated news and podcasts with improved stability and performance.',
      techStack: ['Flutter', 'REST API', 'GetX'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.thepulse.plus',
      iosUrl: 'https://apps.apple.com/us/app/pulse-news-podcasts/id6449618419',
      imageAsset: 'assets/images/project_pulse.png',
      stats: {'Type': 'Media', 'Feature': 'News & Podcasts'},
    ),
    Project(
      title: 'ql_logger_flutter',
      subtitle: 'Open Source Logging Plugin',
      description:
          'Created a Flutter plugin for secure log collection with sensitive data masking.',
      techStack: ['Flutter', 'Dart', 'Open Source'],
      categories: [ProjectCategory.openSource],
      featured: false,
      githubUrl: 'https://pub.dev/packages/ql_logger_flutter',
      liveUrl: 'https://pub.dev/packages/ql_logger_flutter',
      androidUrl: '',
      iosUrl: '',
      imageAsset: 'assets/images/icon_package.png',
      stats: {'Type': 'Plugin', 'Focus': 'Logging'},
    ),
    Project(
      title: 'flutter_perf_guard',
      subtitle: 'Open Source Performance Monitoring Plugin',
      description:
      'Developed a Flutter plugin for monitoring app performance, detecting frame drops, and improving runtime stability with lightweight integration.',
      techStack: ['Flutter', 'Dart', 'Open Source'],
      categories: [ProjectCategory.openSource],
      featured: false,
      githubUrl: 'https://pub.dev/packages/flutter_perf_guard',
      liveUrl: 'https://pub.dev/packages/flutter_perf_guard',
      androidUrl: '',
      iosUrl: '',
      imageAsset: 'assets/images/icon_package.png',
      stats: {'Type': 'Plugin', 'Focus': 'Performance'},
    ),
    Project(
      title: 'iGym SG & Trainer',
      subtitle: 'Fitness Management Platform',
      description:
          'Developed a comprehensive fitness management solution with user tracking and trainer workflows.',
      techStack: ['Flutter', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.igymsg&hl=en_IN',
      iosUrl: 'https://apps.apple.com/my/app/igym-sg/id1453997863',
      imageAsset: 'assets/images/project_igym.png',
      stats: {'Domain': 'Fitness'},
    ),
    Project(
      title: 'Cigna Care Connect',
      subtitle: 'Corporate Healthcare Platform',
      description:
          'Worked on a healthcare mobile platform enabling seamless user interaction and service integration.',
      techStack: ['Ionic', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.ahg.heyally.cigna&hl=en_IN',
      iosUrl: 'https://apps.apple.com/in/app/cigna-care-connect/id6469683207',
      imageAsset: 'assets/images/project_cigna.png',
      stats: {'Domain': 'Healthcare'},
    ),
    Project(
      title: 'Jumper Assist',
      subtitle: 'Conversational Commerce Platform',
      description:
          'Contributed to a conversational commerce platform integrating chat-based buying experiences.',
      techStack: ['Flutter', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.vonage.jumper&hl=en_IN',
      iosUrl: 'https://apps.apple.com/us/app/jumper-assist/id6503607662',
      imageAsset: 'assets/images/project_jumper.png',
      stats: {'Domain': 'E-Commerce'},
    ),
    Project(
      title: 'TNTS',
      subtitle: 'Warehouse Management System',
      description:
          'Built a goods management system for warehouse operations with optimized workflows.',
      techStack: ['React native', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl: '',
      iosUrl: '',
      imageAsset: 'assets/images/project_tnts.png',
      stats: {'Domain': 'Logistics'},
    ),
    Project(
      title: 'NBRI Plant App',
      subtitle: 'Plant Information Application',
      description:
          'Developed an informational app providing plant data and classification features.',
      techStack: ['Android', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.nbri_csir_new&hl=en_IN',
      iosUrl: '',
      imageAsset: 'assets/images/project_nbri.png',
      stats: {'Domain': 'Education'},
    ),
    Project(
      title: 'Way FengShui Almanac',
      subtitle: 'Chinese Horoscope Application',
      description:
          'Built a horoscope-based mobile app with personalized insights and predictions.',
      techStack: ['Android', 'REST API', 'SQLite'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.wayfengshui.almanac&hl=en_IN',
      iosUrl: '',
      imageAsset: 'assets/images/project_fengshui.png',
      stats: {'Domain': 'Lifestyle'},
    ),
    Project(
      title: 'ARCC Spaces',
      subtitle: 'Smart Workplace & Access Platform',
      description:
          'Developed a members-only mobile platform enabling seamless workspace management, room bookings, and secure digital access for modern office environments.',
      techStack: ['Android', 'REST API', 'Third Party SDK'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.arcc.app&hl=en_IN',
      iosUrl: '',
      imageAsset: 'assets/images/project_arcc.png',
      stats: {
        'Platform': 'Enterprise Workspace',
        'Access': 'Keyless System',
        'Booking': 'Real-time Rooms',
      },
    ),
    Project(
      title: 'Collate',
      subtitle: 'On-Demand Home Services Platform',
      description:
      'Built a service marketplace application connecting homeowners, tenants, and service providers with real-time booking, in-app chat, and subscription-based service management.',
      techStack: ['React Native', 'REST API'],
      categories: [ProjectCategory.mobile],
      featured: false,
      githubUrl: '',
      liveUrl: '',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.collateorg',
      iosUrl: 'https://apps.apple.com/br/app/collate/id1566995853?l=en-GB',
      imageAsset: 'assets/images/project_collate.png',
      stats: {
        'Service': 'On-Demand Booking',
        'Features': 'Chat & Alerts',
        'Domain': 'Lifestyle'
      },
    ),
  ];

  // ── Achievements ───────────────────────────────────────────
  static const List<Achievement> achievements = [
    Achievement(
      title: 'Hidden Gem Award',
      subtitle: 'Quokka Labs (for Performance)',
      year: '2024',
      icon: 'award',
      color: 0xFF6366F1,
    ),
    Achievement(
      title: 'Star of the Month (2x)',
      subtitle: 'Quokka Labs',
      year: 'Aug 2023 • Feb 2024',
      icon: 'star',
      color: 0xFFF59E0B,
    ),
    Achievement(
      title: 'Hackathon Winner (Team Captain)',
      subtitle: 'Quokka Labs',
      year: 'July 2023',
      icon: 'trophy',
      color: 0xFF10B981,
    ),
    Achievement(
      title: 'Monthly Achievement Award (2x)',
      subtitle: 'Singsys Software Services',
      year: 'June 2022 • July 2022',
      icon: 'medal',
      color: 0xFF3B82F6,
    ),
    Achievement(
      title: 'Service Excellence Award',
      subtitle: 'Singsys Software Services',
      year: '2021',
      icon: 'certificate',
      color: 0xFFEF4444,
    ),
  ];

  // ── Contact Form Config ────────────────────────────────────
  static const ContactFormConfig contactFormConfig = ContactFormConfig(
    nameLabel: 'Your Name',
    namePlaceholder: 'John Doe',
    emailLabel: 'Email Address',
    emailPlaceholder: 'john@example.com',
    messageLabel: 'Message',
    messagePlaceholder: 'Tell me about your project...',
    submitLabel: 'Send Message',
    successMessage: '🎉 Message sent! I\'ll get back to you within 24 hours.',
    errorMessage:
        '⚠️ Something went wrong. Please try again or email me directly.',
  );

  // ── Section Config (Dynamic Rendering) ────────────────────
  static const List<SectionConfig> sections = [
    SectionConfig(id: 'hero', label: 'Home', visible: true),
    SectionConfig(id: 'about', label: 'About', visible: true),
    SectionConfig(id: 'skills', label: 'Skills', visible: true),
    SectionConfig(id: 'experience', label: 'Experience', visible: true),
    SectionConfig(id: 'projects', label: 'Projects', visible: true),
    SectionConfig(id: 'achievements', label: 'Achievements', visible: true),
    SectionConfig(id: 'contact', label: 'Contact', visible: true),
  ];
}

// ── Data Models ────────────────────────────────────────────────

class SocialLink {
  final String label;
  final String url;
  final String icon;

  const SocialLink(
      {required this.label, required this.url, required this.icon});
}

class Skill {
  final String name;
  final double level; // 0.0 – 1.0
  final String tag;

  const Skill({required this.name, required this.level, required this.tag});
}

class SkillCategory {
  final String title;
  final List<Skill> skills;

  const SkillCategory({required this.title, required this.skills});
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final String location;
  final String description;
  final List<String> highlights;
  final List<String> techStack;
  final bool isCurrent;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
    required this.highlights,
    required this.techStack,
    required this.isCurrent,
  });
}

enum ProjectCategory { mobile, web, desktop, openSource }

class Project {
  final String title;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final List<ProjectCategory> categories;
  final bool featured;
  final String githubUrl;
  final String liveUrl;
  final String androidUrl;
  final String iosUrl;
  final String imageAsset;
  final Map<String, String> stats;

  const Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.categories,
    required this.featured,
    required this.githubUrl,
    required this.liveUrl,
    required this.androidUrl,
    required this.iosUrl,
    required this.imageAsset,
    required this.stats,
  });
}

class Achievement {
  final String title;
  final String subtitle;
  final String year;
  final String icon;
  final int color;

  const Achievement({
    required this.title,
    required this.subtitle,
    required this.year,
    required this.icon,
    required this.color,
  });
}

class ContactFormConfig {
  final String nameLabel;
  final String namePlaceholder;
  final String emailLabel;
  final String emailPlaceholder;
  final String messageLabel;
  final String messagePlaceholder;
  final String submitLabel;
  final String successMessage;
  final String errorMessage;

  const ContactFormConfig({
    required this.nameLabel,
    required this.namePlaceholder,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.messageLabel,
    required this.messagePlaceholder,
    required this.submitLabel,
    required this.successMessage,
    required this.errorMessage,
  });
}

class SectionConfig {
  final String id;
  final String label;
  final bool visible;

  const SectionConfig(
      {required this.id, required this.label, required this.visible});
}
