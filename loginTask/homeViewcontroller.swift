//
//  homeViewcontroller.swift
//  loginTask
//
//  Created by Alen George on 30/08/23.
//

import UIKit
import ImageIO

class homeViewcontroller: UIViewController {
 
    @IBOutlet weak var gifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.loadGif(name: "gifImage")
    }
}
