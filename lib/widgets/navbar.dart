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
                Padding(
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
                Container(
                  width: 1,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xffe4e4e4),
                  ),
                ),
                Padding(
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
                Container(
                  width: 1,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xffe4e4e4),
                  ),
                ),
                Padding(
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
                      icon: Icon(
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
}
