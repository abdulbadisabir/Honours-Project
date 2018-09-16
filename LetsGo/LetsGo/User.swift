//
//  User.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-01.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //MARK: Private Properties
    var firstname : String?
    var lastname : String?
    //let photo: UIImage?
    var birthday : Date?
    var rating : Int?
    var eventsattended : Int?
    var eventsrsvped : Int?
    var photopath: String? = nil
    var profilepicture: UIImage? = UIImage(named: "Default")
    
    init? (ui: userinfo) {
        
        self.firstname = ui.firstname
        self.lastname = ui.lastname
        self.birthday = ui.birthday
        self.eventsattended = ui.eventsattended
        self.eventsrsvped = ui.eventsrsvped
        self.rating = ui.rating
        self.photopath = ui.photopath
        if self.photopath != nil {
            let url = URL(string: self.photopath!)
            let data = try? Data(contentsOf: url!)
            self.profilepicture = UIImage(data: data!)
        }
        
        
    }
    
    init? (id: Int) {
        let linkk = URL(string: "\(HOSTPATH)getUserInfo.php")!
        var ui = userinfo()
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        /* do {
         let d = try
         JSONEncoder().encode(Ui)
         request.httpBody = d
         
         } catch let error {
         print("didn't work",error)
         }*/
        var d = Data()
        d.appendStr("id=\(id)")
        request.httpBody = d
        
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
            if error != nil {
                print("error: \(String(describing: error))")
            }else{
                if data != nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Date)
                        let d = try decoder.decode(userinfo.self,from :data!)
                        ui = d
                        
                    }
                    catch let error {
                        print("didn't work",error)
                    }
                    
                    /*if let str =
                     NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                     print("Received data:\n\(str)")
                     }*/
                    
                }
                else{
                    print("didnt work")
                }
            }
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
        
        self.firstname = ui.firstname
        self.lastname = ui.lastname
        self.birthday = ui.birthday
        self.eventsattended = ui.eventsattended
        self.eventsrsvped = ui.eventsrsvped
        self.rating = ui.rating
        self.photopath = ui.photopath
        if self.photopath != nil {
            let url = URL(string: self.photopath!)
            let data = try? Data(contentsOf: url!)
            self.profilepicture = UIImage(data: data!)
        }
        
    }
    
    func getInfo(id: Int) -> userinfo {
        let linkk = URL(string: "\(HOSTPATH)getUserInfo.php")!
        var thisUserInfo = userinfo()
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        /* do {
         let d = try
         JSONEncoder().encode(Ui)
         request.httpBody = d
         
         } catch let error {
         print("didn't work",error)
         }*/
        var d = Data()
        d.appendStr("id=\(id)")
        request.httpBody = d
        
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
            if error != nil {
                print("error: \(String(describing: error))")
            }else{
                if data != nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Date)
                        let d = try decoder.decode(userinfo.self,from :data!)
                        thisUserInfo = d
                        
                    }
                    catch let error {
                        print("didn't work",error)
                    }
                    
                    /*if let str =
                     NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                     print("Received data:\n\(str)")
                     }*/
                    
                }
                else{
                    print("didnt work")
                }
            }
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
        return thisUserInfo;
    }
 
    
    //Getters and setters:
    
    func getFirstName () -> String? {
        return firstname
    }
    
    func getLastName () -> String? {
        return lastname
    }
    
    func getBirthday() -> Date?{
        return birthday
    }
    
    func getRating() -> Int? {
        return rating
    }
    
    func getEventsAttended() -> Int? {
        return eventsattended
    }
    
    func getEventsRsvped() -> Int? {
        return eventsrsvped
    }
    
    func getPhotopath() -> String? {
        return photopath
    }
    
    func getProfilePicture() -> UIImage? {
        return profilepicture
    }

}
