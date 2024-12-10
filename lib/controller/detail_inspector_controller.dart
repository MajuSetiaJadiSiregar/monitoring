part of 'controller.dart';

abstract class DetailInspectorContract {
  Future<void> openCamera();

  void addTemuan();
  void addArea();
  void chooseAreaAdd(Area area);
}


class DetailInspectorController extends GetxController implements DetailInspectorContract {

  final ImagePicker _picker = ImagePicker();
  var imageFile = Rx<File?>(null);


  var temuans = <Temuan>[
    Temuan(
      temuan: 'Batu bara ditemukan dengan kadar sulfur tinggi',
      lokasi: "Tambang A",
      area: 'Pit Selatan',
      aspek: "Kualitas",
      jenis: "Batubara",
      isEdit: false
    ),
    Temuan(
      temuan: 'Batu bara ditemukan dengan kadar sulfur tinggi',
      lokasi: "Tambang A",
      area: 'Pit Selatan',
      aspek: "Kualitas",
      jenis: "Batubara",
      isEdit: false
    )
  ].obs;
  
  var areas = <Area>[
    Area(id: 1, area: 'Pit Selatan')
  ].obs;

  var areasAdd = <Area>[
    Area(id: 1, area: 'Pit Selatan'),
    Area(id: 2, area: 'Pit Utara'),
    Area(id: 3, area: 'Lereng Timur')
  ].obs;

  var chooseArea = Area(id: 0, area: '').obs;

  var aspeks = <Aspek>[
    Aspek(id: 1, aspek: 'Kualitas'),
    Aspek(id: 2, aspek: 'Operasional'),
    Aspek(id: 3, aspek: 'Lingkungan')
  ].obs;
  
  var rekomendasi = <Rekomendasi>[
    Rekomendasi(id: 1, rekomendasi: 'Pemeliharaan'),
    Rekomendasi(id: 2, rekomendasi: 'Geoteknik'),
    Rekomendasi(id: 3, rekomendasi: 'Produktivitas')
  ].obs;



  @override
  Future<void> openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Android: Simpan gambar ke direktori publik (Pictures)
        final Directory picturesDir = Directory('/storage/emulated/0/Pictures');

        // Pastikan direktori ini ada
        if (!await picturesDir.exists()) {
          await picturesDir.create(recursive: true);
        }

        final String newPath = '${picturesDir.path}/${image.name}';
        final File savedImage = await File(image.path).copy(newPath);

        // Update state dengan GetX
        imageFile.value = savedImage;

        print("Gambar berhasil disimpan di galeri: ${savedImage.path}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void addTemuan() {
    temuans.add(Temuan(
        temuan: 'Pada form P2H ADT juga belum dilakukan pemisahan item fungsi pengereman sesuai dengan jenis pengereman (brake)',
        lokasi: '',
        area: '',
        aspek: '',
        jenis: '',
        isEdit: true
      )
    );
  }

  @override
  void addArea() {

    bool check = true;
    for(var i=0; i < areas.length; i++) {
      if(areas[i].id == chooseArea.value.id) {
        check = false;
        break;
      }
    }

    if(check) {
      areas.add(chooseArea.value);
    }
  }

  @override
  void chooseAreaAdd(Area area) {
    chooseArea.update((_){
      chooseArea.value = area;
    });
  }

  var percent = 0.0.obs; // Menggunakan RxDouble untuk progress
  Timer? timer;

  void startProgress() {
    percent.value = 0.0;
    const duration = Duration(milliseconds: 50); // Interval pembaruan
    const totalTime = 3; // Total waktu dalam detik

    timer = Timer.periodic(duration, (timer) {
      percent.value += duration.inMilliseconds / (totalTime * 1000);

      if (percent.value >= 1.0) {
        percent.value = 1.0; // Pastikan tidak melebihi 100%
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel(); // Hentikan timer saat controller ditutup
    super.onClose();
  }



  void showCustomLoading(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: AppSize.paddingMedium),
            child: Obx(() {
              if (percent.value >= 1.0) {
                Future.microtask(() {
                  Navigator.of(context).pop(); // Tutup dialog loading
                  showCustomError(context); // Tampilkan dialog error
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearPercentIndicator(
                    width: size.width * 0.7,
                      lineHeight: 20.0,
                      percent: percent.value, // Progres dari controller
                      center: Label(label:  "${(percent.value * 100).toInt()}%", color: '#ffffff',),
                      backgroundColor: Colors.grey[300],
                      progressColor: HexColor(AppSize.blue),
                    )
                ],
              );
            }),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCustomError(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, size: 50, color: Colors.red),
                Label(label: 'Upps...', fontSize: AppSize.fontSizeMedium,),
                Label(label: 'Gagal upload temuan, please sync ulang', fontSize: AppSize.fontSizeSmall,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){Navigator.pop(context, 'Cancel');},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.paddingSmall, vertical: AppSize.paddingSmall),
                        child: const Label(label: "Close", fontWeight: 6, color: AppSize.brown, fontSize: AppSize.fontSizeMedium),
                      ),
                    ),


                  ],
                ),

              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}