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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
