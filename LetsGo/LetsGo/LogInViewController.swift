//
//  LogInViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-11.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameLogInTextField: UITextField!
    @IBOutlet weak var passwordLogInTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameLogInTextField {
           
            thisUser.username = usernameLogInTextField.text
            
        }
    }
    
  
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !thisUser.usernameExists(username: usernameLogInTextField.text!) {
            alert(title: "",message: "Username doesn't exist")
            return false
        }
        
        if !thisUser.checkPassword(username: usernameLogInTextField.text!, password: passwordLogInTextField.text!) {
            alert(title: "Oops.",message: "Wrong Password, try again")
            return false
        }
        else {
           // alert(title: "",message: "Login succesful!")
           thisUser.setUsername(usernameLogInTextField.text!)
            thisUser.setPassword(passwordLogInTextField.text!)
             print("This is the USERNAME: \(thisUser.username)")
            thisUser.init(Ui: thisUser.getInfo())

            return true
        }
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(actoin) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert,animated: true, completion: nil)
        
    }

}
