//
//  Logoutcontoller.swift
//  AttendlyApp
//
//  Created by Sara Alsaleh on 14/02/1444 AH.
//

import UIKit

class Logoutcontoller: UIViewController {

    @IBAction func loUGout(_ sender: Any) {  
        print("hi")
        self.performSegue(withIdentifier: "logoo", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
}
