//
//  testViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-23.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var agesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var unJoinButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var cancelEventButton: UIButton!
    
    var event: Event?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if event?.getOwner() != thisUser.getId() {
            if !event!.getUsers()!.contains(thisUser.getId()!) {
                joinButton.isHidden = false
                joinButton.isEnabled = true
            }  else {
                unJoinButton.isHidden = false
                unJoinButton.isEnabled = true
                unJoinButton.frame.origin.y = joinButton.frame.origin.y
                unJoinButton.frame.origin.x = joinButton.frame.origin.x
            }
            
        } else {
            
            cancelEventButton.isHidden = false
            cancelEventButton.isEnabled = true
        }
        titleLabel.text = event?.getTitle()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateLabel.text = dateFormatter.string(from: (event?.getStartTime() ?? nil)!)
        genderLabel.text = displayGenderRestriction()
        
        let hours = Int(floor((event?.getDuration())!))
        let minutes = Int(((event?.getDuration())! - Double(hours))  * 60)
        
        if(minutes != 0) {
        durationLabel.text = "\(hours)h and \(minutes)m"
        }
        else {
            durationLabel.text = "\(hours)h"
        }
        
        if event?.getMaxAge() != nil {
            agesLabel.text = "\(event!.getMinAge()!) to \(event!.getMaxAge()!)"
        }
        else {
         agesLabel.text = "\(event?.getMinAge()!) and over"
        }
        
        addressTextView.text = event?.getAdress()
        eventImageView.image = event?.getEventPhoto()
        descriptionTextView.text = event?.getDescription()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(_ sender: UIButton) {
       /*
            let test = UIImage(named: "Event")
            let ei = Event.getEventInfo(id: 1)
            let event = Event(ei: ei)
            print("\(event!.id)")
        event?.updateImage(photo: test) 
            */
            
            
        
    }
    
    @IBAction func joinEventClicked(_ sender: UIButton) {
        thisUser.joinEvent(eventid: event!.getId()!)
        thisUser.incEventsRsvped()
        thisUser.updateInfo()
        
        unJoinButton.isHidden = false
        unJoinButton.isEnabled = true
        joinButton.isHidden = true
        joinButton.isEnabled = false
    }
    
    
    @IBAction func unjoinEventCllicked(_ sender: UIButton) {
        thisUser.unjoinEvent(eventid: event!.getId()!)
        
        joinButton.isHidden = false
        joinButton.isEnabled = true
        unJoinButton.isHidden = true
        unJoinButton.isEnabled = false
    }
    
    @IBAction func cancelEventClicked(_ sender: UIButton) {
        thisUser.deleteEvent(eventid: event!.getId()!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func displayGenderRestriction() -> String {
        if ((event?.getMaleBool()!)! && (event?.getFemaleBool()!)!) {
            return "Males and Females"
        }
        if (event?.getMaleBool()!)! {
            return "Males Only"
        }
        if (event?.getFemaleBool()!)! {
            return "Females Only"
        }
        
        return "Males and Females"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
