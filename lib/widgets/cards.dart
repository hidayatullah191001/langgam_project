part of 'widgets.dart';

class LayananCard extends StatefulWidget {
  final int index;
  final String imagePath;
  final String titleLayanan;
  final String descriptionLayanan;

  LayananCard({
    required this.index,
    required this.imagePath,
    required this.titleLayanan,
    required this.descriptionLayanan,
  });

  @override
  _LayananCardState createState() => _LayananCardState();
}

class _LayananCardState extends State<LayananCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: 260,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: isHovered ? 0.0 : -15.0,
              bottom: isHovered ? 0.0 : -15.0,
              left: isHovered ? 0.0 : -15.0,
              right: isHovered ? 0.0 : -15.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isHovered ? 0.5 : 0.0,
              child: Container(
                color: Colors.black,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.titleLayanan,
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: AppTheme.semiBold,
                      ),
                    ),
                  ),
                  isHovered
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                        )
                      : AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 0,
                        ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Text(
                      widget.descriptionLayanan,
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class LayananPopulerCard extends StatefulWidget {
  const LayananPopulerCard({Key? key}) : super(key: key);

  @override
  State<LayananPopulerCard> createState() => _LayananPopulerCardState();
}

class _LayananPopulerCardState extends State<LayananPopulerCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 300,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    'https://media.istockphoto.com/id/1444475661/vector/world-map-very-simple-contour-vector-illustration.jpg?b=1&s=612x612&w=0&k=20&c=naZe0MzYqjR6KtjDaGkZFOH3_rpPmy-G9proneKj5M8=',
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 0.5 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Center(
                      child: InkWell(
                        onTap: () {}, // Button add item to cart
                        child: Container(
                          width: 50,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.whiteColor, width: 2),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: AppColors.whiteColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                'Atlas Curah Hujan di Indonesia Rata-rata',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp.1.500.000',
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.semiBold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '/ buku',
                  style: AppTheme.greyTextStyle.copyWith(
                    fontWeight: AppTheme.medium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class UpdateCard extends StatelessWidget {
  const UpdateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.width * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2kxB8JDD63E_xsfOFEje7eWSkvri0295El8holhZGkwJxB4KDIuG8M6LrJhquZEleys&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 18,
              ),
              child: Text(
                'Gempa Berkekuatan 6.5 Skala Richter Guncang Selatan Jawa ',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  fontSize: 18,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemLayananCardList extends StatelessWidget {
  const ItemLayananCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage(
                      'images/product-1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButtonHovered(
                      onTap: () {
                        Navigator.pushNamed(context, '/layanan/detail');
                      },
                      text:
                          'Tampilan cepat Analisis dan prakiraan Hujan Bulanan',
                      styleBeforeHovered: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                      styleHovered: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rp.650000',
                          style: AppTheme.primaryTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '/ buku',
                          style: AppTheme.greyTextStyle.copyWith(
                            fontWeight: AppTheme.medium,
                            fontSize: 18,
                            color: AppColors.softgreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Analisis dan prakiraan hujan bulanan memberikan wawasan yang penting dalam berbagai aspek kehidupan dan lingkungan, memungkinkan pengambilan keputusan yang lebih baik, persiapan yang lebih tepat, dan langkah-langkah pencegahan untuk mengurangi dampak buruk dari perubahan cuaca',
                      style: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.medium,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      onTap: () {},
                      titleButton: 'TAMBAH KE KERANJANG',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
