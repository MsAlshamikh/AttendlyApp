//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      get()
    }
      /*  func loadStats(){
            let db = Firestore.firestore()
            db.collection("Unistudent").addDocument(data: ["advisorID" : "441111111", "major" : "SWE","sFirstN" : "Amani","sLastN" : "Aldahmash","studentID" : "441204066"])
            {error in
                if let error = error {
                 print("FAAAAAIIIIILLLLLL ")
                }
                else{
                print("YESSSSSSSSSSS")
                }
            }}}*/
    func get(){
        let db = Firestore.firestore()
        db.collection("Unistudent").whereField("Emailstudent", isEqualTo: "mo@gmail.com").getDocuments{
            (snapshot, error) in
            if let error = error {
             print("FAIL ")
            }
            else{
            print("SUCCESS")
                let actual = snapshot!.documents.first!.get("courses") as! [String]
                print(actual)
                for i in 0..<actual.count {
                
                    let label = UIButton(frame: .init(x: self.view.frame.midX-120 , y: 200 + ( Double(i) * 70 ), width: 250, height: 50))
                    label.setTitle(actual[i], for: .normal)
                    label.setTitleColor(UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2), for: .normal)
                    label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                    label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                    label.layer.cornerRadius = 0.07 * label.bounds.size.width
                    self.view.addSubview(label)
                }
                //Vstack
               // coursesT.text = actual
           //     print((actual).count)
            }
        }

}
    
    @objc func pressed() {
        
        
        
    }
}

    

