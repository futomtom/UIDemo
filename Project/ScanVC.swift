
import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON



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
                    currentItem =  metadata.stringValue
                  //0855111003279
                    getInfoby( metadata.stringValue!)
                            { name in
                                let price = Int(arc4random_uniform(300))
                        self.tableviewItems.insert(Expenses(name: name, price: price), at: 0)
                        self.tableview.reloadData()
                        for item in self.tableviewItems {
                            self.total = self.total + item.price
                        }
                        
                        self.totalPrice.text = "\(self.total)"
                        
                        }
                    }
                }
            }
        }

    func getInfoby(_ barCode:String, handle:@escaping ((String) -> Void)) {
        let urlParams = ["upc": barCode]
        Alamofire.request("https://api.upcitemdb.com/prod/trial/lookup", method: .get, parameters: urlParams, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let name = json["items"][0]["title"].string
                    print(name!)
                    handle(name!)

                    
                case .failure(let error):
                    print(error)
                }
        }

      
    }
    
    @IBAction func done(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemlist") as! ItemListVC
        vc.tableviewItems = tableviewItems
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
     total = 0 
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpenseCell
        
        cell.displayItem(item: tableviewItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableviewItems.remove(at: indexPath.row)
            self.tableview.reloadData()
        }
    }

    
     func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        let call = UITableViewRowAction(style: .default, title: "\u{260F}\nRemove") { action, index in
            self.tableviewItems.remove(at: indexPath.row)
            self.tableview.reloadData()
        }
        return [call]
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewItems.count
    }
    
    
    
}





