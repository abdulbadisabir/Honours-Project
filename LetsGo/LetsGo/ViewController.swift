//
//  ViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-10-31.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//


struct userinfo: Codable{
    var id: Int?
    var username: String?
    var password: String?
    var firstname: String?
    var lastname: String?
    var gender: String?
    var age: Int?
    var email: String?
    var birthday: Date?
    var rating: Int?
    var eventsattended: Int?
    var eventsrsvped: Int?
    var photopath: String?
}

struct eventinfo: Codable{
    var id: Int?
    var Owner: Int? = nil
    var StartTime: Date? = nil
    var EndTime: Date? = nil
    var Title: String? = nil
    var Description: String? = nil
    var Male: Bool? = nil
    var Female: Bool? = nil
    var LeastAge: Int? = nil
    var MaxAge: Int? = nil
    var Address: String? = nil
    var longitude: Double? = nil
    var lattitude: Double? = nil
    var Duration: Double? = nil
    var photopath: String? = nil
    
    init(from decoder: Decoder) throws {
      
        let container = try decoder.container(keyedBy: KKeys.self)
        id = Int((try container.decode (String?.self, forKey: .id) ?? nil)!)
       Owner = Int((try container.decode(String?.self, forKey: .Owner) ?? nil)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        StartTime = dateFormatter.date(from: (try container.decode(String.self, forKey: .StartTime)) )
        EndTime = dateFormatter.date(from: (try container.decode(String.self, forKey: .EndTime)) )
        
        Title = try container.decode(String.self, forKey: .Title)
        
        Description = try container.decode(String.self, forKey: .Description)
        
        Male = Bool(truncating: Int((try container.decode(String?.self, forKey: .Male) ?? nil)!)! as NSNumber)
        Female = Bool(truncating: Int((try container.decode(String?.self, forKey: .Female) ?? nil)!)! as NSNumber)
        
        LeastAge = Int((try container.decode(String?.self, forKey: .LeastAge) ?? nil)!)
        MaxAge = Int((try container.decode(String?.self, forKey: .MaxAge) ?? nil)!)
        
        longitude = Double((try container.decode(String?.self, forKey: .longitude) ?? nil)!)
        
        lattitude = Double((try container.decode(String?.self, forKey: .lattitude) ?? nil)!)
        
        Duration = Double((try container.decode(String?.self, forKey: .Duration) ?? nil)!)
        
       photopath = try container.decode(String?.self, forKey: .photopath)
        
        Address = try container.decode(String?.self, forKey: .Address)
    }
    
    enum KKeys: String, CodingKey
    {
        case id, Owner, Title, Description, Male, Female, LeastAge, MaxAge, Address, longitude, lattitude, Duration, photopath, StartTime, EndTime
    }
    init() {
        
    }
    
    
    
    
}

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  
  
    
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupMainButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var continue2Button: UIButton!
    @IBOutlet weak var datePicker: UITextField!
    @IBOutlet weak var continue3Button: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupFinalButton: UIButton!
    
    
   /*
    @IBAction func test(_ sender: UIButton) {
        var tv = userinfo()
        tv.username = "Homeboy"
        tv.firstname = "Man"
        tv.password = "gegege"
        tv.lastname = "YoYo"
        tv.gender = "male"
        tv.email = "yoyo@gmail.com"
        
        thisUser.registerUser(Ui: tv)
    }*/
    
    
    var ui = userinfo()
    var navigationcounter = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
       
      /*  RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd"
        /* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
        //let string = "1996-12-19T16:39:57-08:00"
         let string = "1996-12-19"
        let date = RFC3339DateFormatter.date(from: string)
        print("\(date)")
      */
        
       
       
        if (navigationcounter == 2) {
            firstnameTextField.delegate = self
            lastnameTextField.delegate = self
            maleButton.layer.cornerRadius = 10
            femaleButton.layer.cornerRadius = 10
            maleButton.backgroundColor = .clear
            femaleButton.backgroundColor = .clear
        }
        
        if (navigationcounter == 3) {
            datePicker.delegate = self
        }
        
        if (navigationcounter == 4) {
            usernameTextField.delegate = self
            passwordTextField.delegate = self
            emailTextField.delegate = self
        }
        print("\(navigationcounter)")
      
    }

    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if navigationcounter == 3, textField == datePicker {
            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.backgroundColor = UIColor.white
            datePickerView.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePickerView
           datePickerView.addTarget( self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            print("helloOOooooO")
        }
        
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        continue3Button.isEnabled = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
    
        dateFormatter.timeStyle = DateFormatter.Style.none
        datePicker.text = dateFormatter.string(from: sender.date)
        ui.birthday = sender.date
    }
  
    @IBAction func continue3Button(_ sender: UIButton) {
       // checkDate()
    }
    
    /*override func shouldPerformSegueWtihIdentifier(identifier: String, sender: AnyObject) -> Bool {
        
        if navigationcounter == 3 {
            return checkDate()
        }
    }*/
   
  
    func checkDate() -> Bool{
       
        let now = Date()
        let Birthday: Date = ui.birthday!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: Birthday, to: now)
        let age = ageComponents.year!
        let Age: Int = age

       
        
        if (now < Birthday)
        {
            alert(title: "Careful!",message: "Birthday must be before today's date" )
            return false
        }
        if (Age < 10) {
            alert(title: "Careful!",message: "You must be at least 10 years old!" )
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (navigationcounter == 2) {
            
            if textField == firstnameTextField, firstnameTextField.text!.count < 2 {
                alert(title: "Careful!",message: "Firstname has to be at least 2 letters...")
                
            }
            if textField == lastnameTextField, lastnameTextField.text!.count < 2 {
                alert(title: "Careful!",message: "Lastname has to be at least 2 letters...")
                
            }
            checkfields2()
            
        }
        
        if (navigationcounter == 4) {
           
            if textField == usernameTextField {
                if usernameTextField.text!.count < 2 {
                alert(title: "Careful!",message: "Username has to be at least 2 letters...")
                   
                    
                }
                if thisUser.usernameExists(username: usernameTextField.text!) {
                    alert(title: "Whoops!",message: "Username already exists, try another.")
                    
                    
                }
            }
            if textField == passwordTextField, passwordTextField.text!.count < 6 {
                 alert(title: "Careful!",message: "Password has to be at least 6 characters.")
             
                
            }
            if textField == emailTextField {
                if emailTextField.text!.count < 6 ||
                    !validEmail(email: emailTextField.text!) {
                    alert(title: "Invalid Email",message: "Please input email address properly.")
                  
                    
                }
                if thisUser.emailExists(email: emailTextField.text!) {
                     alert(title: "Whoops!",message: "Email associated with another account, try another one.")
                  
                    
                    
                }
            }
          
                checkfields4()
            
            
        }
    }
    
    
    func validEmail(email: String) -> Bool {
        
        for (_, char) in email.characters.enumerated()
        {
            if (char == "@") {
                return true
            }
        }
        
        return false
    }
    
    @IBAction func username(_ sender: UITextField) {
        
         ui.username = usernameTextField.text
    }
    
    @IBAction func passwordTextField(_ sender: UITextField) {
        ui.password = passwordTextField.text
    }
    
    @IBAction func email(_ sender: UITextField) {
        ui.email = emailTextField.text
    }
    
    
    @IBAction func firstname(_ sender: UITextField) {
        ui.firstname = firstnameTextField.text
    }
    
    @IBAction func lastname(_ sender: UITextField) {
        ui.lastname = lastnameTextField.text
        print("It happened")
        
    }
    
    @IBAction func maleSelected(_ sender: Any) {
        
        if !maleButton.isSelected {
           maleButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1)
            ui.gender = "male"
            femaleButton.isSelected = false
            femaleButton.backgroundColor = .clear
            maleButton.isSelected = true
            firstnameTextField.resignFirstResponder()
            lastnameTextField.resignFirstResponder()
        }
        checkfields2()
    }
    
    @IBAction func femaleSelected(_ sender: Any) {
        
        if !femaleButton.isSelected {
            femaleButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1)
            
            ui.gender = "female"
            maleButton.isSelected = false
            maleButton.backgroundColor = .clear
            femaleButton.isSelected = true
            firstnameTextField.resignFirstResponder()
            lastnameTextField.resignFirstResponder()
        }
        checkfields2()
    }
    
    //MARK: Check fields per navigation count.
    func checkfields2() {
        if firstnameTextField.text!.count > 1, lastnameTextField.text!.count > 1, (maleButton.isSelected || femaleButton.isSelected)
        {
            continue2Button.isEnabled = true
            return
        }
        continue2Button.isEnabled = false
        
    }
    
    func checkfields4() {
        
        //If any of the fields are empty, no need to check with server, just disable signup button.
        if usernameTextField.text!.count < 1 || passwordTextField.text!.count < 1 || emailTextField.text!.count < 1 {
            signupFinalButton.isEnabled = false
            return
        }
        
        //If all fields are filled correctly, enable signup button.
        if usernameTextField.text!.count > 1, !thisUser.usernameExists(username: usernameTextField.text!), passwordTextField.text!.count > 5,
            emailTextField.text!.count > 5, validEmail(email: emailTextField.text!), !thisUser.emailExists(email: emailTextField.text!) {
            signupFinalButton.isEnabled = true
            return
        }
        signupFinalButton.isEnabled = false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if navigationcounter == 3 {
            return checkDate()
        }
        if navigationcounter == 4 {
            return thisUser.registerUser(Ui: ui)
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        super.prepare(for: segue, sender: sender)
       
        
       /* if let  button = sender as? UIButton, button == signupMainButton
        {
            //Handle the text field's user input through delegate callbacks.
             let next = segue.destination as! ViewController
            
          // next.firstnameTextField.delegate = next
          //  next.lastnameTextField.delegate = next
            next.navigationcounter += 1
           
            next.ui = ui
           
            
        }
        */
        if(segue.destination is ViewController){
        let next = segue.destination as! ViewController
        
        // next.firstnameTextField.delegate = next
        //  next.lastnameTextField.delegate = next
        next.navigationcounter = navigationcounter + 1
        
        next.ui = ui
        }
        
        

    }
    
  func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert,animated: true, completion: nil)
        
    }
    
    
   
}
/*
 @IBAction func signup(_ sender: UIButton) {
 /*
 let linkk = URL(string: "http://localhost")!
 
 let postString = "username=\(username!)&password=\(password!)"
 
 // let parameters = ["id": "2", "name": "abdul", "gender": "male"]
 // guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
 
 let request = NSMutableURLRequest(url: linkk);
 request.httpMethod = "POST"
 // request.addValue("application/json", forHTTPHeaderField: "Content--Type")
 // request.addValue("application/json", forHTTPHeaderField: "Accept")
 request.httpBody = postString.data(using: String.Encoding.utf8)
 let task = URLSession.shared
 task.dataTask(with: request as URLRequest){
 (data,response,error) in
 
 if error != nil {
 print("error: \(String(describing: error))")
 }else{
 if data != nil {
 if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
 print("Received data:\n\(str)")
 }
 }
 else{
 print("didnt work")
 }
 }
 
 }.resume()
 */
 //post()
 
 print("this is the result::::")
 print(thisUser.check(username: username!) )
 
 }
 
 func post() {
 
 let linkk = URL(string: "http://localhost/test.php")!
 let data: [String: String] = [
 "object": "customer",
 "id": "4yq6txdpfadhbaqnwp3",
 "email": "john.doe@example.com",
 ]
 
 struct Customer: Codable {
 let object: String
 let id: String
 let email: String
 }
 var request = URLRequest(url: linkk)
 request.httpMethod = "POST"
 print("heeeerererererereererere")
 do {
 let d = try
 JSONEncoder().encode(data)
 request.httpBody = d
 print("FOCUSSS")
 let dd = try JSONDecoder().decode(Customer.self, from: d)
 print(dd)
 } catch let error {
 print("didn't work",error)
 }
 
 URLSession.shared.dataTask(with: request) { (data, respone, error) in
 if error != nil {
 print("error: \(String(describing: error))")
 }else{
 if data != nil {
 if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
 print("Received data:\n\(str)")
 }
 }
 else{
 print("didnt work")
 }
 }
 
 
 
 
 
 
 }.resume()
 }
 */


