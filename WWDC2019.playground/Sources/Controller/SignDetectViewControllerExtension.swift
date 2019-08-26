import UIKit
import AVKit
import Vision

extension SignDetectViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func sessionConfiguration() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            return
        }
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high
        guard captureSession.canAddInput(deviceInput) else {
            print("Could not add video device input to the session")
            self.captureSession.commitConfiguration()
            return
        }
        captureSession.addInput(deviceInput)

        let dataOutput = AVCaptureVideoDataOutput()

        if captureSession.canAddOutput(dataOutput) {
            self.captureSession.addOutput(dataOutput)
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "OutputQueue"))
        } else {
            print("Could not add video device output to the session")
            self.captureSession.commitConfiguration()
            return
        }

        self.captureSession.commitConfiguration()
        captureSession.startRunning()
    }

    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: ImageClassifier3().model) else { return }
        let request = VNCoreMLRequest(model: model, completionHandler: { (finishedReq, err) in
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            DispatchQueue.main.sync {
                self.analyzeResult(firstObservation.identifier)
            }
        })
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

}
