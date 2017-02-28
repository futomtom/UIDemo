
import UIKit
import AVFoundation



class ScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var previewView: UIView!
    var Items:[Expenses]=[Expenses(name:"Drink",price:10),Expenses(name:"Noodle",price:20),Expenses(name:"Ice Cream",price:8)]
    var tableviewItems:[Expenses] = []
    let detectionArea = UIView()
    var timer: Timer!
    var counter = 0
    var isDetected = false
    var currentItem = ""
    var total = 0
    
    @IBOutlet weak var totalPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        
     
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
        /*
        detectionArea.frame = CGRect(x: view.frame.size.width * x, y: view.frame.size.height * y, width: view.frame.size.width * width, height: view.frame.size.height * height)
        detectionArea.layer.borderColor = UIColor.red.cgColor
        detectionArea.layer.borderWidth = 3
        view.addSubview(detectionArea)
        */
      
        metadataOutput.rectOfInterest = CGRect(x: y,y: 1-x-width,width: height,height: width)
        
 
        if let videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession) {
            videoLayer.frame = previewView.bounds
            videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewView.layer.addSublayer(videoLayer)
        }
        
 
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
//        timer.fire()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
        
            if metadata.type == AVMetadataObjectTypeEAN13Code || metadata.type == AVMetadataObjectTypeEAN8Code{
                if metadata.stringValue != nil {
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                        print(metadata.stringValue!)
                    
                    if metadata.stringValue == currentItem {
                        return
                    }
                        switch metadata.stringValue! {
                        case "0855111003279":
                           tableviewItems.insert(Items[0], at: 0)
                            currentItem = "0855111003279"
                        case "0070470409610":
                             tableviewItems.insert(Items[1], at: 0)
                            currentItem = "0070470409610"
                        case "1":
                            tableviewItems.insert(Items[2], at: 0)
                            currentItem = "1"
                        default:
                            break
                        }
                        tableview.reloadData()
                    
                    for item in tableviewItems {
                        total = total + item.price
                    }
                    
                    totalPrice.text = "\(total)"
//                        detectionArea.layer.borderColor = UIColorUIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1).cgColor
//                        detectionArea.layer.borderWidth = 5
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
                    }
                }
            }
        }

    
    @IBAction func done(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "paymoney") as! PayMoneyVC
        vc.total = total
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
     total = 0 
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpenseCell
        
        cell.displayItem(item: tableviewItems[indexPath.row])
        
        return cell

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewItems.count
    }
    
    
    
}



