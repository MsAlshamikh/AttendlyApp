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
             print("FAAAAAIIIIILLLLLL ")
            }
            else{
            print("SUCCESSSSS")
                let actual = snapshot!.documents.first!.get("courses") as! [String]
                print(actual)
                for i in 0..<actual.count {
                
                    let label = UILabel(frame: .init(x: self.view.frame.midX - 100, y: 200 + ( Double(i) * 70 ), width: 100, height: 50))
                    label.backgroundColor = .red
                    label.text = actual[i]
                    self.view.addSubview(label)
                }
                //Vstack
               // coursesT.text = actual
           //     print((actual).count)
            }
        }
      //  coursesT.text = actual
}
}

    

