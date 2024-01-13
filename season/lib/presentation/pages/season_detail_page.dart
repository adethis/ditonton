import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:season/presentation/bloc/detail/season_detail_bloc.dart';
import 'package:season/presentation/widgets/episode_card.dart';

class SeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/season-detail';
  final int seriesId;
  final int seasonNumber;

  const SeasonDetailPage({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
  });

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<SeasonDetailBloc>()
          .add(SeasonDetailEvent(widget.seriesId, widget.seasonNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
          builder: (context, state) {
            if (state is SeasonDetailLoading) {
              return const CircularProgressIndicator();
            } else if (state is SeasonDetailHasData) {
              return Text(state.result.name!);
            } else {
              return const Text('Detail Season');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
          builder: (context, state) {
            if (state is SeasonDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonDetailHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = state.result.episodes?[index];
                  return EpisodeCard(episode: episode!);
                },
                itemCount: state.result.episodes!.length,
              );
            } else if (state is SeasonDetailError) {
              return Center(
                child: Text(
                  state.message,
                  key: const Key('error_message'),
                ),
              );
            } else {
              return Container(
                key: const Key('unknown_state'),
              );
            }
          },
        ),
      ),
    );
  }
}
