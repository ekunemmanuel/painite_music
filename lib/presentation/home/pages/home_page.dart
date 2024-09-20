import 'package:flutter/material.dart';
import 'package:panite_music/presentation/home/widgets/playlist.dart';

import '../../../common/widgets/app_bar_logo.dart';
import '../../../common/widgets/basic_app_bar.dart';
import '../widgets/news_song.dart';
import '../widgets/top_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: AppBarLogo(),
        hideback: true,
      ),
      body: Column(
        children: [
          const TopCard(),
          TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'News'),
              Tab(text: 'Videos'),
              Tab(text: 'Artists'),
              Tab(text: 'Playlists'),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _firstTab(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _firstTab() {
  return const SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: 194,
          child: NewsSong(),
        ),
        Playlist(),
      ],
    ),
  );
}
