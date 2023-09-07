//
//  menuController.swift
//  loginTask
//
//  Created by Alen George on 06/09/23.
//

import UIKit

class menuController: UITableViewController {
    var items = ["Home","Map","Sign Up","Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = items[indexPath.row]
        switch selectedItem {
        case "Home":
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home")
            navigationController?.pushViewController( viewController1 , animated: true)
        case "Map":
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
            navigationController?.pushViewController( viewController1 , animated: true)
        case "Log Out":
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "log")
            navigationController?.pushViewController( viewController1 , animated: true)
        case "Sign Up":
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sign")
            navigationController?.pushViewController( viewController1 , animated: true)
        default :
            break
        }
    }
    
}
