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
        get()}
        
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
}

    
        func get(){
            let db = Firestore.firestore()
            db.collection("Unistudent").document("jhkPjKIZ4mj9ZisvgjFb").getDocument{
                (document, error) in
                if let error = error {
                 print("FAAAAAIIIIILLLLLL ")
                }
                else{
                print("YESSSSSSSSSSS")
                    let actual = document!.get("courses")
                    print(actual)
                    print(Array(arrayLiteral: actual).count)
                }
            }
            
        }
