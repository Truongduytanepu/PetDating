//
//  SetProfilePetViewController.swift
//  FoodAppIOS
//
//  Created by Trương Duy Tân on 08/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SetProfilePetViewController: UIViewController {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.layer.cornerRadius = saveBtn.frame.height / 2
    }
    
    @IBAction func saveBtnHandle(_ sender: Any) {
    
        if let currentUser = Auth.auth().currentUser {
            if let newName = nameTF.text,
               let newAge = Int(ageTF.text ?? ""),
               let newType = typeTF.text,
               let newGender = genderTF.text {
                let databaseRef = Database.database().reference()
                databaseRef.child("user").child(currentUser.uid).child("pet").setValue([
                    "name" : newName,
                    "age": newAge,
                    "type" : newType,
                    "gender": newGender
                ] as [String : Any]) { [weak self] (error, databaseRef) in
                    guard let strongSelf = self else { return }
                    
                    if let error = error {
                        strongSelf.showAlert(withTitle: "Error", message: "Failure to save pet profile")
                    } else {
                        strongSelf.showAlert(withTitle: "Success", message: "Save pet profile successfully", completionHandler: {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let mainTabbar = storyboard.instantiateViewController(withIdentifier: "MainTabbarViewController") as? MainTabbarViewController {
                                strongSelf.navigationController?.pushViewController(mainTabbar, animated: true)
                            }
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
