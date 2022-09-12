//
//  CurrentVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 15/02/1444 AH.
//

import UIKit

class CurrentVC: UIViewController {

    @IBOutlet weak var sectionText: UITextField!
    var SectionPicker = UIPickerView()
    let sections=["00","99"]
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionText.inputView=SectionPicker
        SectionPicker.delegate=self
        SectionPicker.dataSource=self
        sectionText.placeholder="Select Section"
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
        //
    }
}
