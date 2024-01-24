part of 'widgets.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 101,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'images/logo.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  'LANGGAM',
                  style: AppTheme.greyTextStyle
                      .copyWith(fontSize: 18, fontWeight: AppTheme.bold),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari produk',
                    hintStyle: AppTheme.greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.blackColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffe4e4e4),
                        width: 10,
                        strokeAlign: 20,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          alignment: const Alignment(0.63, -0.55),
                          child: ModalLayanan(context),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          'LAYANAN',
                          style: AppTheme.secondaryTextStyle.copyWith(
                            fontWeight: AppTheme.semiBold,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xffe4e4e4),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xffe4e4e4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          alignment: const Alignment(0.7, -0.55),
                          child: ModalUpdate(context),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          'UPDATE',
                          style: AppTheme.secondaryTextStyle.copyWith(
                            fontWeight: AppTheme.semiBold,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xffe4e4e4),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xffe4e4e4),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          alignment: const Alignment(0.8, -0.55),
                          child: ModalBantuan(context),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          'BANTUAN',
                          style: AppTheme.secondaryTextStyle.copyWith(
                            fontWeight: AppTheme.semiBold,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xffe4e4e4),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xffe4e4e4),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 8,
                        child: Text(
                          '10',
                          style: AppTheme.whiteTextStyle.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ModalBantuan(BuildContext context) {
    return Container(
      width: 100,
      height: 250,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BANTUAN',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          TextButtonHovered(
            text: 'Panduan',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Peraturan Pemerintah',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Tentang Kami',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Hubungi Kami',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Konfirmasi Pembayaran',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget ModalUpdate(BuildContext context) {
    return Container(
      width: 100,
      height: 170,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UPDATE',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          TextButtonHovered(
            text: 'Peringatan Dini Cuaca',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Gempa Bumi Terkini',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Peringatan Dini Cuaca',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget ModalLayanan(BuildContext context) {
    return Container(
      width: 100,
      height: 230,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LAYANAN',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ItemNavBarDropDown(
            text: 'Informasi Meteorologi',
            onTap: () {},
            lottieJson: 'lottie/animate-2.json',
          ),
          ItemNavBarDropDown(
            text: 'Informasi Klimatologi',
            onTap: () {},
            lottieJson: 'lottie/animate-4.json',
          ),
          ItemNavBarDropDown(
            text: 'Informasi Geofisika',
            onTap: () {},
            lottieJson: 'lottie/animate-3.json',
          ),
          ItemNavBarDropDown(
            text: 'Jasa Konsultasi',
            onTap: () {},
            lottieJson: 'lottie/animate-1.json',
          ),
        ],
      ),
    );
  }
}

class ItemNavBarDropDown extends StatefulWidget {
  int? index;
  final String text;
  final VoidCallback onTap;
  TextStyle? styleHovered;
  TextStyle? styleBeforeHovered;
  String? lottieJson;
  ItemNavBarDropDown({
    super.key,
    this.index = 0,
    required this.text,
    required this.onTap,
    this.styleHovered,
    this.styleBeforeHovered,
    this.lottieJson,
  });

  @override
  State<ItemNavBarDropDown> createState() => _ItemNavBarDropDownState();
}

class _ItemNavBarDropDownState extends State<ItemNavBarDropDown> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Row(
          children: [
            Center(
              child: Lottie.asset(
                widget.lottieJson!,
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 15),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: isHovered
                  ? AppTheme.primaryTextStyle
                      .copyWith(fontWeight: AppTheme.bold)
                  : AppTheme.greyTextStyle,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Text(widget.text),
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
