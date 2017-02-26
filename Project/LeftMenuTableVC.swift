

import Foundation
import SideMenu


struct menuItem {
    var name: String
    var iconName: String
    var sequeID: String
}

class LeftMenuTableVC: UITableViewController {
    let menuItems = [menuItem(name: "Home", iconName: "home", sequeID: "home"),
                     menuItem(name: "Overview", iconName: "overview", sequeID: "overview"),
                     menuItem(name: "Progress", iconName: "progress", sequeID: "progress"),
                     menuItem(name: "Account", iconName: "account", sequeID: "account"),

    ]

    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuItemCell

        cell.displayItem(item: menuItems[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: menuItems[indexPath.row].sequeID, sender: nil)


    }


}
