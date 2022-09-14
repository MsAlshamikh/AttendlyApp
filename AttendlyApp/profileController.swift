//
//  profileController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
//

import UIKit



class profileContoller: UIViewController {


//
    //@IBAction func loUGout(_ sender: Any) {

    @IBAction func loUGout(_ sender: Any) {
    
    print("logout!")

        self.performSegue(withIdentifier: "logoo", sender: self)

    }

    override func viewDidLoad() {

        super.viewDidLoad()



        // Do any additional setup after loading the view.

    }
    

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


