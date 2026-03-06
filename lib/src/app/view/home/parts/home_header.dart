part of '../home_view.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.searchController,
    required this.onSearchPressed,
  });

  final TextEditingController searchController;
  final VoidCallback onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SearchInput(
                  controller: searchController,
                  onSubmitted: onSearchPressed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final labels = ['Safe Payment', 'Fast Delivery', 'Free Return'];
                return Chip(label: Text(labels[index]));
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: 3,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                final colors = [
                  const Color(0xFFFFE9D8),
                  const Color(0xFFE7F6FF),
                  const Color(0xFFFFE9F2),
                ];
                return Container(
                  width: 260,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index == 0
                            ? 'Welcome: 15% OFF + Free Delivery'
                            : index == 1
                            ? 'Grand Bazaar Deals'
                            : 'Today: Shop More, Save More',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Task mock banner'),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

