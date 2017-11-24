//
//  SignUpSuccessViewController.swift
//  SignUpAccount
//
//  Created by Safhone Oung on 11/24/17.
//  Copyright © 2017 Safhone Oung. All rights reserved.
//

import UIKit

class SignUpSuccessViewController: UIViewController {

    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var congratulationImageView: UIImageView!
    
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeUserLabel.lineBreakMode = .byWordWrapping
        welcomeUserLabel.text = userName == "" || userName == nil ? "Welcome Annoymous, Your account has been created!" : "Welcome \(userName!.uppercased()), Your account has been created!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.congratulationImageView.center.y -= view.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.congratulationImageView.center.y += self.view.bounds.height
        }, completion: nil)
    }
    
}
