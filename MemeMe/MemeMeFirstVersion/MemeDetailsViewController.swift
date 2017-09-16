//
//  MemeDetailsViewController.swift
//  MemeMeFinal
//
//  Created by Jean Ro on 9/15/17.
//  Copyright © 2017 Jean Ro. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = self.image {
            imageView.image = image
        }
    }

}
