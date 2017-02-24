
import UIKit
import AVFoundation

class ScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var label: UILabel!
    
    let detectionArea = UIView()
    var timer: Timer!
    var counter = 0
    var isDetected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let captureSession = AVCaptureSession()
        
      
        let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice)
        captureSession.addInput(videoInput)

             let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        
     
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
       
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code]
        
    
        let x: CGFloat = 0.05
        let y: CGFloat = 0.3
        let width: CGFloat = 0.9
        let height: CGFloat = 0.2
        
        detectionArea.frame = CGRect(x: view.frame.size.width * x, y: view.frame.size.height * y, width: view.frame.size.width * width, height: view.frame.size.height * height)
        detectionArea.layer.borderColor = UIColor.red.cgColor
        detectionArea.layer.borderWidth = 3
        view.addSubview(detectionArea)

      
        metadataOutput.rectOfInterest = CGRect(x: y,y: 1-x-width,width: height,height: width)
        
 
        if let videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession) {
            videoLayer.frame = previewView.bounds
            videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewView.layer.addSublayer(videoLayer)
        }
        
 
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
        
            if metadata.type == AVMetadataObjectTypeEAN13Code || metadata.type == AVMetadataObjectTypeEAN8Code{
                if metadata.stringValue != nil {
               
                    counter = 0
                    if !isDetected || label.text != metadata.stringValue! {
                        isDetected = true
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // バイブレーション
                        label.text = metadata.stringValue!
                        detectionArea.layer.borderColor = UIColor.white.cgColor
                        detectionArea.layer.borderWidth = 5
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func update(tm: Timer) {
        counter += 1
        print(counter)
        if 1 < counter {
            detectionArea.layer.borderColor = UIColor.red.cgColor
            detectionArea.layer.borderWidth = 3
            label.text = ""
        }
    }
}

