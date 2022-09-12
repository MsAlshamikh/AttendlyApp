//
//  CurrentVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit
import FirebaseFirestore
var sections=[""]
class CurrentVC: UIViewController {
    var Sectionss: String = ""

    @IBOutlet weak var sectionText: UITextField!
    var SectionPicker = UIPickerView()
   
    //
    
    func get(){
             let db = Firestore.firestore()
        db.collection("Unistudent").whereField("lecturerID", isEqualTo: "123").getDocuments{
                 (snapshot, error) in
                 if let error = error {
                     print("FAIL")
                 }
                 else{
                     print("SUCCESS")
                     let actual = snapshot!.documents.first!.get("sections") as! [String]
                     
                     for i in 0..<actual.count {
                       //  var s = actual[i]
                         //sections.append(s)
                       
                         sections.append(actual[1])
                     }
                     }
                 
                 }
        
    }
    //
  //  var sections=["11","22"]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionText.inputView=SectionPicker
       
        sectionText.placeholder=" Select Section "
      //  sectionText.textAlignment =.center
        SectionPicker.delegate=self
        SectionPicker.dataSource=self
        get()
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
extension CurrentVC:UIPickerViewDataSource,UIPickerViewDelegate{
    

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sections.count
}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sectionText.text=sections[row]
        sectionText.resignFirstResponder()
    }
}
