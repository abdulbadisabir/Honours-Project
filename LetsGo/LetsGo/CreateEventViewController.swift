//
//  CreateTableViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-17.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit
import MapKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    
    @IBOutlet weak var charCounterLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var durationHoursTextField: UITextField!
    
    @IBOutlet weak var durationMinutesTextField: UITextField!
    
    @IBOutlet weak var timeMinutesTextField: UITextField!
    @IBOutlet weak var timeHoursTextField: UITextField!
    @IBOutlet weak var minAgeTextField: UITextField!
    @IBOutlet weak var maxAgeTextField: UITextField!
    @IBOutlet weak var genderPickerTextField: NoCursorTextField!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    
    @IBOutlet weak var pickLocationTextField: NoCursorTextField!
    @IBOutlet weak var restrictionTextField: NoCursorTextField!
    var address:String? = nil
    var long:Double? = nil
    var lat:Double? = nil
    var Startdate: Date? = nil
    var eventPicture: UIImage?
    var ei = eventinfo()
    @IBOutlet weak var descriptionTextView: UITextView!
    let genderRestrictionList = ["Males and Females", "Males Only", "Females Only"]
    
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleTextField.delegate = self
        timeHoursTextField.delegate = self
        timeMinutesTextField.delegate = self
        durationHoursTextField.delegate = self
        durationMinutesTextField.delegate = self
        restrictionTextField.delegate = self
        minAgeTextField.delegate = self
        maxAgeTextField.delegate = self
        pickLocationTextField.delegate = self
        
        
        dateTextField.delegate = self
        addDoneButton(dateTextField)
       addDoneButton(restrictionTextField)
        
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 0.3
        dateTextField.delegate = self
        
        
        let restPickerView = UIPickerView()
        restPickerView.delegate = self
        restPickerView.backgroundColor = .white
        restrictionTextField.inputView = restPickerView
       
        // Do any additional setup after loading the view.
    }

  
    override func viewDidAppear(_ animated: Bool) {
        if address != nil {
            pickLocationTextField!.text = address!
        }
        super.viewDidAppear(true)
    }
    
   
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        if (textField == pickLocationTextField) {
             pickLocationTextField.resignFirstResponder()
       performSegue(withIdentifier: "LocationPicker", sender: self)
           return false
        }
        
        
        if (textField == dateTextField) {
            let datePickerView: UIDatePicker = UIDatePicker()
           
            datePickerView.backgroundColor = UIColor.white
            datePickerView.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePickerView
            datePickerView.addTarget( self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            return true
        }
        
        
        
 
        
        return true
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        
        dateFormatter.timeStyle = DateFormatter.Style.none
 
       dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateTextField.text = dateFormatter.string(from: sender.date)
        Startdate = dateFormatter.date(from: dateTextField.text!)
       
     
       
        //Startdate = Cal.startOfDay(for: sender.date)*/
        
       // dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss a"
 
        
        
        
    }
    
    func checkDate() -> Bool {
        
        let now = Date()
        guard let Eventdate = ei.StartTime else {return true}
       
        
        
        
        if (Eventdate < now)
        {
            alert(title: "Careful!",message: "Birthday must be before today's date" )
            ei.StartTime = nil
            return false
        }
        
        return true
        
        
    }
    
    
  
   
    
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderRestrictionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderRestrictionList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        restrictionTextField.text = genderRestrictionList[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if titleTextField.text! == "" || titleTextField.text!.count < 3 {
            alert(title: "Careful!", message: "Event needs to have a title of at least 3 characters")
            return false
        }
        
        if titleTextField.text!.count > 30 {
            alert(title: "Careful!", message: "Please make sure the title is less than 30 chars")
        }
        
        if dateTextField.text! == "" {
            alert(title: "Careful!", message: "Event needs to have a date")
            return false
        }
        
        if dateTextField.text! == "" {
            alert(title: "Careful!", message: "Event needs to have a date")
            return false
        }
        
        if timeHoursTextField.text! == "" {
            alert(title: "Careful!", message: "Event needs to have a time")
            return false
            
        }
        
        if durationHoursTextField.text! == "" {
            alert(title: "Careful!", message: "Please specify how long your event is going to be by filling out the 'Duration:' textfield.")
            durationMinutesTextField.isEnabled = false
            return false
            
        }
        
        if genderPickerTextField.text! == "" {
            alert(title: "Careful!", message: "Please specify the gender restriction for your event.")
            return false
        }
        
        if minAgeTextField.text! == "" {
            alert(title: "Careful!", message: "Your event needs to have a minimum age restriction.")
            return false
        }
        if pickLocationTextField.text! == "" {
            alert(title: "Careful!", message: "Please pick a location for your event.")
            return false
        }
        
        return true
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is SearchAddressViewController){
            let next = segue.destination as! SearchAddressViewController
            
            // next.firstnameTextField.delegate = next
            //  next.lastnameTextField.delegate = next
            let backItem = UIBarButtonItem()
            
            backItem.title = "Cancel"
            next.navigationItem.leftBarButtonItem = backItem
            
            
        }
    }*/
    
    @IBAction func createEvent(_ sender: UIButton) {
        
       
        
        
        
        /*
        var id: Int?
        var Owner: Int?
        var StartTime: Date?
        var EndTime: Date?
        var Title: String?
        var Description: String?
        //var Users: [String?]
        var Male: Bool?
        var Female: Bool?
        var LeastAge: Int?
        var MaxAge: Int?
        var Address: String?
        var longitude: Double?
        var lattitude: Double?
        var Duration: Double?
        */
        
    }
    
    
  
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // textField.borderStyle = UITextBorderStyle.none
     
        if textField == titleTextField {
            if textField.text!.count > 30 {
                alert(title: "Careful!", message: "Title can only be 30 characters.")
                 return
            }
           charCounterLabel.isHidden = true
            return
        }
        
        
        if (textField == dateTextField) {
            if !checkDate() {
                textField.text = ""
                alert(title: "Careful!", message: "Event date should be more than today's date")
                return
            }
            
            
            
        }
        
        if textField == restrictionTextField {
            if restrictionTextField.text == "" {
                restrictionTextField.text = "Males and Females"
            }
            
            return
        }
        
        if textField == timeHoursTextField {
            if ((textField.text!).isInt() ) {
                if Int(textField.text!)! > 23 || Int(textField.text!)! < 0 {
                    alert(title: "Careful!", message: "Invalid Input, must be a time value less than 24 hours.")
                    textField.text = ""
                    timeMinutesTextField.isEnabled = false
                    return
                }
                else {
                    ei.StartTime?.addTimeInterval(Double(textField.text!)! * 60.0 *  60.0)
                }
                timeMinutesTextField.isEnabled = true
                return
            }
            else {
                if (textField.text! == "") {
                    alert(title: "Woops", message: "Event needs a start time.")
                     timeMinutesTextField.isEnabled = false
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                timeMinutesTextField.isEnabled = false
                return
            }
            
            
        }
        
        if textField == timeMinutesTextField {
            if ((textField.text!).isInt() ) {
                if Int(textField.text!)! >= 60 || Int(textField.text!)! < 0 {
                    alert(title: "Careful!", message: "Invalid Input, must be a value value less than 60.")
                    textField.text = ""
                
                }
                else {
                    
                }
                
                return
            }
            else {
                if (textField.text! == "") {
                    textField.text = "00"
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                return
            }
            
        }
        
        if textField == durationHoursTextField {
            if ((textField.text!).isInt() ) {
                if Int(textField.text!)! >= 24 || Int(textField.text!)! < 0 {
                    alert(title: "Careful!", message: "Invalid Input, must be a value value less than 60.")
                    textField.text = ""
                    durationMinutesTextField.isEnabled = false
                    return
                }
                durationMinutesTextField.isEnabled = true
                return
            }
            else {
                if (textField.text! == "") {
                    alert(title: "Woops", message: "Event needs a duration..")
                    durationMinutesTextField.isEnabled = false
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                durationMinutesTextField.isEnabled = false
                return
            }
        }
        
        if textField == durationMinutesTextField {
            if ((textField.text!).isInt() ) {
                if Int(textField.text!)! >= 60 ||  Int(textField.text!)! < 0 {
                    alert(title: "Careful!", message: "Invalid Input, must be a value value less than 60.")
                    textField.text = ""
                }
                
                return
            }
            else {
                if (textField.text! == "") {
                    textField.text = "00"
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                return
            }
        }
        
        if textField == minAgeTextField {
            if ((textField.text!).isInt() ) {
                if Int(textField.text!)! < 10 {
                    alert(title: "Careful!", message: "Must be at least 10 years old.")
                    textField.text = ""
                    return
                    
                }
                if Int(textField.text!)! >= 110 {
                    alert(title: "Hello", message: "Must be less than 110 years old.")
                    textField.text = ""
                    return
                }
                maxAgeTextField.isEnabled = true
                return
            }
            else {
                if (textField.text! == "") {
                    alert(title: "Woops", message: "Please set the minimum age, thank you.")
                    maxAgeTextField.isEnabled = false
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                maxAgeTextField.isEnabled = false
                return
            }
        }
        
        if textField == maxAgeTextField {
            if ((textField.text!).isInt() ) {
                if minAgeTextField.text != "" && Int(textField.text!)! < Int(minAgeTextField.text!)! {
                    alert(title: "Careful!", message: "Must be more than min age.")
                    textField.text = ""
                    
                }
                if Int(textField.text!)! < 10 {
                    alert(title: "Careful!", message: "Must be at least 10 years old.")
                    textField.text = ""
                    
                }
                if Int(textField.text!)! >= 110 {
                    alert(title: "Hello", message: "Must be less than 110 years old.")
                    textField.text = ""
                }
                return
            }
            else {
                if (textField.text! == "") {
                    
                    return
                }
                alert(title: "Careful!", message: "Invalid Input")
                textField.text = ""
                return
            }
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == timeHoursTextField {
            timeMinutesTextField.isEnabled = true
        }
        
        if textField == durationHoursTextField {
            durationMinutesTextField.isEnabled = true
        }
        if textField == minAgeTextField {
           maxAgeTextField.isEnabled = true
        }
    }
    
    @IBAction func changeEventPicture(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    
    func addDoneButton(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done",style: .plain, target: self, action:
            #selector( self.dismissKeyboard))
        toolbar.setItems([doneButton],animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is EventViewController){
            ei.Owner = thisUser.getId()
            ei.StartTime = Startdate
            ei.StartTime?.addTimeInterval(Double(timeHoursTextField.text!)! * 60.0 * 60.0)
            
            /*let dateFormatter = DateFormatter()
             //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
             dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
             let temp = dateFormatter.string(from: ei.StartTime!)
             ei.StartTime = dateFormatter.date(from: temp)*/
            if timeMinutesTextField.text != "" {
                ei.StartTime?.addTimeInterval(Double(timeMinutesTextField.text!)! * 60.0)
                
            }
            ei.EndTime = ei.StartTime
            ei.EndTime?.addTimeInterval(Double(durationHoursTextField.text!)! * 60.0 * 60.0)
            if durationMinutesTextField.text != "" {
                ei.EndTime?.addTimeInterval(Double(durationMinutesTextField.text!)! * 60.0)
                
            }
            
            
            ei.Title = titleTextField.text!
            ei.Description = descriptionTextView.text!
            
            
            if restrictionTextField.text! == "Males and Females" {
                ei.Male = true
                ei.Female = true
            }
            
            if restrictionTextField.text! == "Males Only" {
                ei.Male = true
                ei.Female = false
            }
            
            if restrictionTextField.text! == "Females Only" {
                ei.Male = false
                ei.Female = true
            }
            
            
            
            ei.LeastAge = Int(minAgeTextField.text!)
            ei.MaxAge = Int(maxAgeTextField.text!)
            ei.Address = self.address
            ei.longitude = self.long
            ei.lattitude = self.lat
            ei.Duration = Double(durationHoursTextField.text!)
            if (durationMinutesTextField.text != nil || Double(durationMinutesTextField.text!)! > 0.0)
            {
                ei.Duration = ei.Duration! + Double(durationMinutesTextField.text!)! / 100
            }
            
            ei.id = Event.createEvent(ei)
            let event = Event(ei: ei)
            if (eventPicture != nil) {
                event?.updateImage(photo: eventPicture)
            }
            
            let next = segue.destination as! EventViewController
            next.event = event
            
        }
        
        
        
        
        //var Users: [String?]
     
        
        
    }
    
    @IBAction func charCounter(_ sender: UITextField) {
        charCounterLabel.isHidden = false
        charCounterLabel.text = String(titleTextField.text!.count)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        restrictionTextField.borderStyle = UITextBorderStyle.none
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected dictionary containing an image \(info)")
        }
        
        eventPicture = selectedImage
        eventImageView.image = selectedImage
       
        dismiss(animated: true, completion: nil)
        
    }
    
    func alert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(actoin) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert,animated: true, completion: nil)
        
    }
    
}
extension String {
    func isInt() -> Bool {
    return Int(self) != nil
    
    }
}



