//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    
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
        db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "322@student.ksu.edu.sa").getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                print("SUCCESS")
                let actual = snapshot!.documents.first!.get("courses") as! [String]
                let sects = snapshot!.documents.first!.get("Sections") as! [String]
                print(actual)
                for i in 0..<actual.count {
                    
                    let label = UIButton(frame: .init(x: self.view.frame.midX-120 , y: 300 + ( Double(i) * 70 ), width: 250, height: 50))
                    label.setTitle(actual[i], for: .normal)
                    label.setTitleColor(UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2), for: .normal)
                    label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                    //label.params["course"] = actual[i]
                    //!!!!!!
                    label.tag = Int(sects[i]) ?? 0
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
    
    @objc func pressed(sender:UIButton) {
        
        //1
        titleB = sender.title(for: .normal)!
        //2
        section = String(sender.tag)
        
        
        
        let db = Firestore.firestore()
        db.collection("Sections").whereField("section", isEqualTo: section).getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL2 ")
            }
            else{
                print("SUCCESS2")
                let id = snapshot!.documents.first!.get("lecturerID") as! String
                print(id)
                
                db.collection("Lecturer").whereField("id", isEqualTo: id).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL3 ")
                    }
                    else{
                        print("SUCCESS 3")
                        self.name = snapshot!.documents.first!.get("name") as! String
                        self.performSegue(withIdentifier: "s1", sender: self)
                        //3
                        //print(name)
                        
//                        let c = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 200 , width: 250, height: 50))
//                        c.text = titleB
//                        c.textColor = UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2)
//
//                        let s = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 270 , width: 250, height: 50))
//                        s.text = section
//                        s.textColor = UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2)
//
//                        let n = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 340 , width: 250, height: 50))
//                        n.text = name
//                        n.textColor = UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2)
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "s1" {
            if let controller = segue.destination as? DetailsViewController {
                controller.section = section
                controller.name = name
                controller.titleB = titleB
            }
        }
    }
    
    @IBAction func exit(segue: UIStoryboardSegue){
        print("exited")
    }
    
}



/*
 let c = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 200 , width: 250, height: 50))
 c.text = titleB
 c.textColor = UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2)
 
 let s = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 270 , width: 250, height: 50))
 s.text = section
 s.textColor = UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2)
 */
