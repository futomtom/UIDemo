

import UIKit
import SideMenu

class HomePageVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSideMenu()

   
}
  

  @IBAction func openMenu(_ sender: Any) {
    present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    // present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
  }
  


  fileprivate func setupSideMenu() {
    // Define the menus
    let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
    menuLeftNavigationController?.leftSide = true
    SideMenuManager.menuLeftNavigationController = menuLeftNavigationController



  }
}
