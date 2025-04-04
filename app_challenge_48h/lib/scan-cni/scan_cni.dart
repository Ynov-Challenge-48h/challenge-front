import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
   
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (cameraController == null || 
        cameraController?.value.isInitialized == false) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: cameraController!.value.previewSize!.height,
                height: cameraController!.value.previewSize!.width,
                child: CameraPreview(cameraController!),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              XFile picture = await cameraController!.takePicture();
              // Handle the captured image
            },
            iconSize: 100,
            icon: const Icon(
              Icons.camera,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Future<void> _setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      final backCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

      setState(() {
        cameras = _cameras;
        cameraController = CameraController(
          backCamera,
          ResolutionPreset.high,
        );
      });

      cameraController?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      }).catchError((Object e) {
        print(e);
      });
    }
  }

}
