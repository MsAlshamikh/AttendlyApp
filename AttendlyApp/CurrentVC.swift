//
//  CurrentVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit

class CurrentVC: UIViewController {

    @IBOutlet weak var selectCourseBtn: UIButton!
    
    @IBOutlet var butsection1Collection: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectCourseBtn.layer.cornerRadius = selectCourseBtn.frame.height / 2
        butsection1Collection.forEach{  (btn) in btn.layer.cornerRadius = btn.frame.height / 2
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        
    }
    }
    

    @IBAction func selectCourse(_ sender: UIButton) {
        butsection1Collection.forEach{ (btn) in UIView.animate(withDuration: 0.7){
            btn.isHidden = !btn.isHidden
            btn.alpha = btn.alpha == 0 ? 1 : 0
            btn.layoutIfNeeded()
            
        }
    }
    }
    @IBAction func butSection1(_ sender: UIButton) {
        if let btnLb1 = sender.titleLabel?.text{
            print(btnLb1)
            
        }
        
    }
    
   
}

