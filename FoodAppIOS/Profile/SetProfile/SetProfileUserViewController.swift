//
//  SetProfileUserViewController.swift
//  FoodAppIOS
//
//  Created by Trương Duy Tân on 08/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SetProfileUserViewController: UIViewController {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.layer.cornerRadius = saveBtn.frame.height / 2
    }
    
    @IBAction func saveBtnHandle(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser{
            if let newName = nameTF.text,
               let newAge = Int(ageTF.text ?? ""),
               let newLocation = locationTF.text,
               let newGender = genderTF.text{
                let databaseRef = Database.database().reference()
                databaseRef.child("user").child(currentUser.uid).setValue([
                    "name" : newName,
                    "age": newAge,
                    "location" : newLocation,
                    "gender": newGender] as [String : Any]){ (error, databseRef) in
                        if let error = error{
                            self.showAlert(withTitle: "Error", message: "Failure to save profile")
                        }else{
                            self.showAlert(withTitle: "Success", message: "Save profile successfully", completionHandler:{
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let setPetProfile = storyboard.instantiateViewController(withIdentifier: "SetProfilePetViewController") as! SetProfilePetViewController
                                self.navigationController?.pushViewController(setPetProfile, animated: true)
                                
                            })
                            
                        }
                    }
            }
        }
    }
    
    func showAlert(withTitle title: String, message: String, completionHandler: (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completionHandler?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
