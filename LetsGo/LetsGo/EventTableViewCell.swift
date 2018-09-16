//
//  EventTableViewCell.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-27.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ageLimitLabel: UILabel!
    
    @IBOutlet weak var genderRestrictionLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField1: UILabel!
    
    @IBOutlet weak var descriptionTextField2: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var userStackView: UserPhotosStackView!
    
    var event: Event?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
      
      
        
        
        
        
    }
    
    func load(_ ev: Event) {
        self.event = ev
        if event != nil {
            titleLabel.text = event!.getTitle()
            ageLimitLabel.text = displayAgeLimit()
            genderRestrictionLabel.text = displayGenderRestriction()
            dateLabel.text = displayDate()
            timeLabel.text = displayTime()
            let description = ev.getDescription()
            if description != nil {
                if description!.count < 100 {
                    descriptionTextField1.text = getDescription(lower: 0, upper: description!.count-1, desc: description!)
                } else if description!.count < 200 {
                    descriptionTextField1.text = getDescription(lower: 0, upper: 99, desc: description!)
                    
                   descriptionTextField2.text = getDescription(lower: 100, upper: description!.count-1, desc: description!)
                }
                else {
                    descriptionTextField1.text = getDescription(lower: 0, upper: 99, desc: description!)
                    
                    descriptionTextField2.text = getDescription(lower: 100, upper: 199, desc: description!)
                }
               
                
                
            }
           addressLabel.text = event!.getAdress()
            photoImageView.image = event!.getEventPhoto()
            userStackView.list = ev.getUsers()
           userStackView.setupButtons()
            if event!.getOwner()! == thisUser.getId()! || event!.getUsers()!.contains(thisUser.getId()!) {
                checkButton.isHidden = false
                goButton.isHidden = true
                
            } else {
                
                checkButton.isHidden = true
                goButton.isHidden = false
            }
           
            
        }
    }
    
    func displayAgeLimit() -> String {
        
        if event != nil {
            
            if event?.getMinAge() != nil {
                
                if event?.getMaxAge() != nil {
                    return ("Age limit:     \(event!.getMinAge()!)  to  \(event!.getMaxAge()!)")
                    
                }
                
                return ("Age limit:     \(event!.getMinAge()!) and over")
                
            }
            
            
            
            
        }
        
        return "Age limit:"
        
    }
    
    func displayGenderRestriction() -> String {
        if event != nil {
            if event!.getMaleBool()! == true && event!.getFemaleBool() == true {
                return "Males & Females"
            }
            if event!.getMaleBool()! == true {
                return "Males Only"
            }
            
            if event!.getFemaleBool()! == true {
                return "Females Only"
            }
            
        }
        return "Males & Females"
    }
    
    func displayDate() -> String {
        
        if event != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd, MMM"
            return dateFormatter.string(from: event!.getStartTime()!)
        }
        return ""
        
    }
    
    func displayTime() -> String {
        
        if event != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H:mm"
            return dateFormatter.string(from: event!.getStartTime()!)
        }
        
        return ""
    }
    
    func getDescription(lower: Int, upper: Int, desc: String) -> String {
        let start = desc.index(desc.startIndex, offsetBy: lower)
        let end = desc.index(desc.startIndex, offsetBy: upper)
        
        let str = desc[start...end]
        return String(str)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if event!.getOwner() == thisUser.getId()! {
            alert(title: "Careful!", message: "You are the owner. Please delete the event if you don't want to go.")
            return
        }
        
        thisUser.unjoinEvent(eventid: event!.getId()!)
        checkButton.isHidden = true
        checkButton.isEnabled = false
        goButton.isHidden = false
        goButton.isEnabled = true
        let superview = self.window?.visibleViewController() as! EventsViewController
        superview.eventsTable.reloadData()
        
    }
    
    @IBAction func goButtonClicked(_ sender: UIButton) {
        let age = thisUser.getAge()!
        if age > event!.getMinAge()! && age < (event!.getMaxAge() ?? 1000) && genderElgibility() {
        thisUser.joinEvent(eventid: event!.getId()!)
        checkButton.isHidden = false
        checkButton.isEnabled = true
        goButton.isHidden = true
        goButton.isEnabled = false
        thisUser.incEventsRsvped()
        thisUser.updateInfo()
            let superview = self.window?.visibleViewController() as! EventsViewController
        superview.eventsTable.reloadData()
        } else {
            alert(title: "Woops", message: "You are uneligible for this event.")
           
        }
        
    }
    
    func genderElgibility() -> Bool {
        if thisUser.getGender()! == "male" && event!.getMaleBool()! == true {
            return true
        }
        
        if thisUser.getGender()! == "female" && event!.getFemaleBool()! == true {
            return true
        }
        return false
        
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.window?.visibleViewController()?.present(alert,animated: true, completion: nil)
        
    }
    
    
    
    
    
}
