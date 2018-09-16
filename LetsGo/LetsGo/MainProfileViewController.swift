//
//  MainProfileViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-12.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit
import Photos
import MapKit

class MainProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
   
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameLabel.text = "\(thisUser.getFirstname()!)  \(thisUser.getLastname()!)"
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        print("\(dateFormatter.string(from: thisUser.getBirthday()!))")
        birthdayLabel.text = dateFormatter.string(from: thisUser.getBirthday()!)
        
        profilePictureImage.layer.borderWidth = 1
        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.size.height/2
        profilePictureImage.clipsToBounds = true
       
        profilePictureImage.image = thisUser.getProfilePicture()!
      
     
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapPP(_ sender: UITapGestureRecognizer) {
     /*   let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)*/
       /* let m = UIImageJPEGRepresentation(profilePictureImage.image!, 0.1)
        profilePictureImage.image = UIImage(data: m!, scale: 1.0)
           thisUser.test(photo: profilePictureImage.image)*/
        
        thisUser.updateImage(photo: profilePictureImage.image!)
    }
    
    @IBAction func changePP(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        
        imagePickerController.delegate = self 
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected dictionary containing an image \(info)")
        }
   
        profilePictureImage.image = selectedImage
        thisUser.updateImage(photo: selectedImage)
        dismiss(animated: true, completion: nil)
        
    }
    
   
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "MyEvents" {
            let list = thisUser.getUserEvents() 
            if list == nil {
                return false
            }
            
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EventsViewController {
            let next = segue.destination as! EventsViewController
            
            var tempEvents = [Event]()
            
            let list = thisUser.getUserEvents()!
            for evid in list {
               let tempEvent = Event(ei: Event.getEventInfo(id: evid))!
                tempEvents.append(tempEvent)
                print("\(tempEvent.getTitle()!)")
                
            }
            next.Events = tempEvents
            
        }
        
    }
    
   
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */



