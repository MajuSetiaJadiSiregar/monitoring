part of 'view.dart';

class HomeView extends StatelessWidget {

  HomeView({super.key});
  List<Inspeksi> inspeksi = [
    Inspeksi(startDate: '12 September 2024', endDate: '15 September 2024', badanUsaha: "PT Timah Usaha Sukses"),
    Inspeksi(startDate: '20 Oktober 2024', endDate: '25 Oktober 2024', badanUsaha: "PT Batubara jaya")
  ];

  List<Inspeksi> activity = [
    Inspeksi(startDate: '12 September 2024', endDate: '15 September 2024', badanUsaha: "Kedatangan + Jam Istirahat"),
    Inspeksi(startDate: '20 Oktober 2024', endDate: '25 Oktober 2024', badanUsaha: "Rapat Dengan KTT"),
    Inspeksi(startDate: '03 November 2024', endDate: '06 November 2024', badanUsaha: "Riview Awal")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              margin: const EdgeInsets.all(AppSize.marginSmall),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _imageProfile(width: size.width * 0.35, height: size.height * 0.2),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Label(label: 'Inspector', fontSize: AppSize.fontSizeExtraLarge, fontWeight: 6,),
                        _itemProfile(Icons.person_pin_rounded, title: 'Septian Dwi'),
                        _itemProfile(Icons.call, title: '087-888-1234'),
                        _itemProfile(Icons.mail, title: 'septian@gmail.com')
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(AppSize.marginSmall),
              child: const Label(label: 'Inspeksi', fontWeight: 6, fontSize: AppSize.fontSizeExtraLarge)
            ),

            Container(
              margin: const EdgeInsets.all(AppSize.marginSmall),
              child: CustomTable(inspeksi: inspeksi, isActivity: true,),
            ),

            Container(
                margin: const EdgeInsets.all(AppSize.marginSmall),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(label: 'Jadwal Kegiatan', fontWeight: 6, fontSize: AppSize.fontSizeExtraLarge),
                    SizedBox(width: AppSize.paddingSmall,),
                    Label(label: 'PT Timah berkah jaya', fontSize: AppSize.fontSizeSmall)
                  ],
                )
            ),

            Container(
              margin: const EdgeInsets.all(AppSize.marginSmall),
              child: CustomTable(isActivity: false, inspeksi: activity,),
            ),

          ],
        ),
      ),
    );
  }

  Widget _imageProfile({double width=200, double height=200}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusLarge),
      child: Image.network(
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return const Label(label: 'Failed to load image', color: '#fa6a6c', fontSize: AppSize.fontSizeMedium,);
        },
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  Widget _itemProfile(IconData icon, {String title=''}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.brown,
          size: 20.0,
        ),
        const SizedBox(width: AppSize.marginSmall,),
        Expanded(child: Label(label: title, fontSize: AppSize.fontSizeMedium,))
      ],
    );
  }



}