//
//  Event.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-14.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import Foundation
import UIKit
/*
struct eventinfo: Codable{
    var id: Int?
    var Owner: Int?
    var StartTime: Date?
    var EndTime: Date?
    var Title: String?
    var Description: String?
    var Users: [String?]
    var Male: Bool
    var Female: Bool
    var LeastAge: Int?
    var MaxAge: Int?
  
}*/

class Event: NSObject {
    var id: Int?
    var Owner: Int?
    var StartTime: Date?
    var EndTime: Date?
    var Title: String?
    var Description: String?
    //var Users: [User?]
    var Male: Bool?
    var Female: Bool?
    var LeastAge: Int?
    var MaxAge: Int?
    var Address: String?
    var longitude: Double?
    var lattitude: Double?
    var Duration: Double?
    var photopath: String?
    var EventPhoto: UIImage? = UIImage(named: "Event")
    init? (ei: eventinfo) {
        self.id = ei.id
        self.Owner = ei.Owner
        self.StartTime = ei.StartTime
        self.EndTime = ei.EndTime
        self.Title = ei.Title
        self.Description = ei.Description
       // self.Users = ei.Users
        self.Male = ei.Male
        self.Female = ei.Female
        self.LeastAge = ei.LeastAge
        self.MaxAge = ei.MaxAge
        self.Address = ei.Address
        self.longitude = ei.longitude
        self.lattitude = ei.lattitude
        self.Duration = ei.Duration
        self.photopath = ei.photopath 
        if self.photopath != nil {
            let url = URL(string: self.photopath!)
            let data = try? Data(contentsOf: url!)
            self.EventPhoto = UIImage(data: data!)
        }
        
    }
    
    //Creates a new event and returns it's id.
    static func createEvent(_ Ei: eventinfo) -> Int {
        
        let linkk = URL(string: "\(HOSTPATH)createEvent.php")!
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        
        
        do {
               let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
             let d = try   encoder.encode(Ei)
            request.httpBody = d
            
        } catch let error {
            print("didn't work",error)
        }
      
        var retId: Int?
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
            if error != nil {
                print("error: \(String(describing: error))")
            }else{
                if data != nil {
                    /*do {
                        let d = try JSONDecoder().decode(eventinfo.self,from :data!)
                        thisEventInfo = d
                        
                    }
                    catch let error {
                        print("didn't work",error)
                        return
                    }*/
                    
                    if let str =
                     NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                     print("Received data:\n\(str)")
                        retId = Int(str as String)
                     }
                    
                }
                else{
                    print("didnt work")
                    sem.signal()
                }
            }
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
        return retId!;
        
    }
    
     func getUsers() -> [Int]? {
        var list: [Int]?
        let linkk = URL(string: "\(HOSTPATH)getEventUsers.php")!
        
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        
        var d = Data()
        d.appendStr("id=\(self.id!)")
        request.httpBody = d
        
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
            if error != nil {
                print("error: \(String(describing: error))")
            }else{
                if data != nil {
                    /*do {
                     
                     let d = try JSONDecoder().decode(el.self,from :data!)
                     
                     
                     
                     }
                     catch let error {
                     print("didn't work",error)
                     return
                     }*/
                    
                    if let str =
                        NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                        print("Received data:\n\(str)")
                        
                        if (str != "false") {
                            list = String(str).components(separatedBy: ",").flatMap {Int($0)}
                            
                            print("\(String(str).components(separatedBy: ","))")
                            
                        }
                    }
                    
                    
                    
                    
                }
                else{
                    print("didnt work")
                }
            }
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
        return list
    }
    
    
   
    
    static func getEventInfo(id: Int) -> eventinfo {
        let linkk = URL(string: "\(HOSTPATH)getEventInfo.php")!
        var thisEventInfo = eventinfo()
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        
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
                       
                        let d = try JSONDecoder().decode(eventinfo.self,from :data!)
                        thisEventInfo = d
                        
                    }
                    catch let error {
                        print("didn't work",error)
                        return
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
        return thisEventInfo;
        
    }
    
     
    
         func getInfo() -> eventinfo {
        let linkk = URL(string: "\(HOSTPATH)getEventInfo.php")!
        var thisEventInfo = eventinfo()
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
       
        var d = Data()
        d.appendStr("id=\(self.id!)")
        request.httpBody = d
        
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
            if error != nil {
                print("error: \(String(describing: error))")
            }else{
                if data != nil {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dataDecodingStrategy = .deferredToData
                        let d = try decoder.decode(eventinfo.self,from :data!)
                        thisEventInfo = d
                        
                    }
                    catch let error {
                        print("didn't work",error)
                        return
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
        return thisEventInfo;
    }
    
    func updateImage(photo: UIImage?) {
    let linkk = URL(string: "\(HOSTPATH)updateEventPhoto.php")!
    
    let image = photo
    let imagedata = UIImageJPEGRepresentation(image!, 0.1)
    var request = URLRequest(url: linkk)
    request.httpMethod = "POST"
    let boundary = "Boundary-\(UUID().uuidString)"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let objname = "id"
    let objname2 = "hostpath"
    let name = "file"
    let filename = "eventphoto.jpg"
    let pboundary = "--\(boundary)\r\n"
    let mimetype = "image/jpg"
    var data = Data()
    
    
    data.appendStr(pboundary)
    data.appendStr("Content-Disposition: form-data; name=\"\(objname)\"\r\n\r\n")
    data.appendStr("\(self.id!)\r\n")
    //data.appendStr("--".appending(boundary.appending("--")))
    
    data.appendStr(pboundary)
    data.appendStr("Content-Disposition: form-data; name=\"\(objname2)\"\r\n\r\n")
    data.appendStr("\(HOSTPATH)\r\n")
    
    data.appendStr(pboundary)
    data.appendStr("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
    data.appendStr("Content-Type: \(mimetype)\r\n\r\n")
    data.append(imagedata!)
    data.appendStr("\r\n")
    data.appendStr("--".appending(boundary.appending("--")))
    
    
    
    request.httpBody = data
    
    
    
    
    
    let sem = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: request) { (data, respone, error) in
    if error != nil {
    print("error: \(String(describing: error))")
    }else{
    if data != nil {
    if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
    print("Received data:\n\(str)")
    }
    self.EventPhoto = photo!
    }
    else{
    print("didnt work")
    }
    }
    
    
    
    
    
    sem.signal()
    }.resume()
    sem.wait()
    
    }
    
    
    
    //Getters and setters
    
    func getId() -> Int? {
        return id
    }
    
    func getOwner() -> Int? {
        return Owner
    }
    
    func getTitle() -> String? {
        return Title
    }
    
    func getStartTime() -> Date? {
        return StartTime
    }
    func getEndTime() -> Date? {
        return EndTime
    }
    
    func getMaleBool() -> Bool? {
        if Male == nil {
            return false
        }
        return Male
    }
    
    func getFemaleBool() -> Bool? {
        if Female == nil {
            return false
        }
        return Female
    }
    func getDescription() -> String? {
        return Description
    }
    
    func getMinAge() -> Int? {
        return LeastAge
    }

    func getMaxAge() -> Int? {
        return MaxAge
    }
   
    func getAdress() -> String? {
        return Address
    }
    
    func getLattitude() -> Double? {
        return lattitude
    }
    
    func getLongitude() -> Double? {
        return longitude
    }
   
    func getDuration() -> Double? {
        return Duration
    }
    
    func getPhotoPath() -> String? {
        return photopath
    }
    
    func getEventPhoto() -> UIImage? {
        return EventPhoto
    }
    
    
}
