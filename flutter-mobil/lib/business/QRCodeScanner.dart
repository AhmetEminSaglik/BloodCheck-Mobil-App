import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

var log = Logger(printer: PrettyPrinter(colors: false));

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool _hasScanned = false;

  void _goBackPage(String readData) {
    if (!_hasScanned) {
      _hasScanned = true;
      controller.stop();
      Navigator.pop(context, readData);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String? code = barcode.rawValue;
                if (code != null && code.isNotEmpty) {
                  _goBackPage(code);
                  break;
                }
              }
            },
            errorBuilder: (context, error, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Kamera hatası: ${error.errorDetails?.message ?? error.errorCode.name}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),

          // Overlay — tarama çerçevesi
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Alt kontrol butonları
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Flash
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      final bool flashOn =
                          value.torchState == TorchState.on;
                      return ElevatedButton.icon(
                        onPressed: () => controller.toggleTorch(),
                        icon: Icon(
                          flashOn ? Icons.flash_on : Icons.flash_off,
                        ),
                        label: Text(flashOn ? 'Flash: Açık' : 'Flash: Kapalı'),
                      );
                    },
                  ),

                  // Kamera çevir
                  ElevatedButton.icon(
                    onPressed: () => controller.switchCamera(),
                    icon: const Icon(Icons.flip_camera_android),
                    label: const Text('Kamera Çevir'),
                  ),

                  // Pause / Resume
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      final bool isRunning = value.isRunning;
                      return ElevatedButton.icon(
                        onPressed: () {
                          if (isRunning) {
                            controller.stop();
                          } else {
                            controller.start();
                          }
                        },
                        icon: Icon(
                          isRunning ? Icons.pause : Icons.play_arrow,
                        ),
                        label: Text(isRunning ? 'Duraklat' : 'Devam'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
