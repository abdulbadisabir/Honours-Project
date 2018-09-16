//
//  thisUser.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-02.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//
let HOSTPATH = "http://localhost/"
import UIKit
func encStr (_ str: String) -> Data {
    let enc = str.data(using: String.Encoding.utf8)
    return enc!
}

class thisUser: NSObject {
    static var id: Int? = nil
    static var username: String? = nil
    private static var password: String? = nil
    static var email: String? = nil
    static var firstname : String? = nil
    static var lastname : String? = nil
    static var birthday : Date? = nil
    static var age: Int? = nil
    static var rating : Int? = nil
    static var gender : String? = nil
    static var eventsattended : Int? = nil
    static var eventsrsvped : Int? = nil
    static var photopath: String? = nil
    static var profilepicture: UIImage? = UIImage(named: "Default")
    init? (Ui: userinfo) {
        thisUser.id = Ui.id
        thisUser.username = Ui.username
        thisUser.password = Ui.password
        thisUser.email = Ui.email
        thisUser.firstname = Ui.firstname
        thisUser.lastname = Ui.lastname
        thisUser.birthday = Ui.birthday
        thisUser.age = Ui.age
        thisUser.gender  = Ui.gender
        if (thisUser.birthday != nil) {
            thisUser.age = thisUser.calculateAge(thisUser.birthday!)
        }
        thisUser.rating = Ui.rating
        thisUser.eventsattended = Ui.eventsattended
        thisUser.eventsrsvped = Ui.eventsrsvped
        thisUser.photopath = Ui.photopath
        if thisUser.photopath != nil {
            let url = URL(string: thisUser.photopath!)
            let data = try? Data(contentsOf: url!)
            thisUser.profilepicture = UIImage(data: data!)
        }
    }
   //Called when user signs up.
    static func registerUser(Ui: userinfo) -> Bool {
        let linkk = URL(string: "\(HOSTPATH)registeruser.php")!
       

        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let d = try
                encoder.encode(Ui)
            request.httpBody = d
            
        } catch let error {
            print("didn't work",error)
        }
        
        let sem = DispatchSemaphore(value: 0)
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
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
        return true
    }
    static func convertInfo() -> userinfo {
        var Ui = userinfo()
        Ui.id = id
        Ui.username = username
        Ui.password = password
        Ui.email = email
        Ui.firstname = firstname
        Ui.lastname = lastname
        Ui.birthday = birthday
        Ui.age = age
        Ui.rating = rating
        Ui.eventsattended = eventsattended
        Ui.eventsrsvped = eventsrsvped
        Ui.gender = gender
        Ui.photopath = photopath
        return Ui
        
        
    }
    
    //Reset all user values using server data.
    static func refreshInfo() {
        let Ui = thisUser.getInfo()
        thisUser.username = Ui.username
        thisUser.password = Ui.password
        thisUser.email = Ui.email
        thisUser.firstname = Ui.firstname
        thisUser.lastname = Ui.lastname
        thisUser.birthday = Ui.birthday
        thisUser.age = calculateAge(thisUser.birthday!)
        thisUser.rating = Ui.rating
        thisUser.gender = Ui.gender
        thisUser.eventsattended = Ui.eventsattended
        thisUser.eventsrsvped = Ui.eventsrsvped
        thisUser.photopath = Ui.photopath
        if thisUser.photopath != nil {
            let url = URL(string: thisUser.photopath!)
            let data = try? Data(contentsOf: url!)
            thisUser.profilepicture = UIImage(data: data!)
        }
    }
    
    
    //Update server-side info.
    static func updateInfo() {
        let linkk = URL(string: "\(HOSTPATH)updateUserInfo.php")!
        if (eventsattended == nil) {
            eventsattended = 0
        }
        
        if (eventsrsvped == nil) {
            eventsrsvped = 0
        }
      
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let d = try
                encoder.encode(convertInfo())
            request.httpBody = d
            
        } catch let error {
            print("didn't work",error)
        }
        let sem = DispatchSemaphore(value: 0)
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
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
    }
    
    //Sign-up functions:
    static func checkPassword(username: String, password: String) -> Bool {
        
        var correct = false
        let linkk = URL(string: "\(HOSTPATH)checkpassword.php")!
        
        let postString = "username=\(username) & password=\(password)"
        
        var request = URLRequest(url: linkk);
        
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared
        let sem = DispatchSemaphore(value: 0)
        task.dataTask(with: request as URLRequest){ (data,response,error) in
        
            if error != nil {
                print("error: \(String(describing: error))")
                return
                
            }else{
                if data != nil {
                    if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                        print("Received data:\n\(str)")
                        
                        if (str.isEqual(to: "true" ))
                        {
                            correct = true;
                        }
                        else if (str.isEqual(to: "false" ))
                        {
                            correct = false;
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
        
        print(correct)
       
        
        return correct
    }
    
    
   static func  usernameExists(username: String) -> Bool {
        
        let linkk = URL(string: "\(HOSTPATH)checkusername.php")!
        
        let postString = "username=\(username)"
        
    var exists: Bool?
        
        let request = NSMutableURLRequest(url: linkk);
        request.httpMethod = "POST"
    
    let sem = DispatchSemaphore(value: 0)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared
    
        task.dataTask(with: request as URLRequest){
            (data,response,error) in
            
            if error != nil {
                print("error: \(String(describing: error))")
                return
            
            }else{
                if data != nil {
                    if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                        print("Received data:\n\(str)")
                        
                        if (str.isEqual(to: "true" ))
                        {
                            exists = true;
                        }
                        else if (str.isEqual(to: "false" ))
                        {
                            exists = false;
                        }
                        print("real value here")
                        print(exists!)
                    }
                    
                }
                else{
                    print("didnt work")
                }
            }
            sem.signal()
            }.resume()
    sem.wait()
   
    print(exists!)
        return exists!;
    }
    
    static func emailExists(email: String) -> Bool {
        let linkk = URL(string: "\(HOSTPATH)checkemail.php")!
        
        let postString = "email=\(email)"
        
        var exists = true
        
        let request = NSMutableURLRequest(url: linkk);
        request.httpMethod = "POST"
        
        let sem = DispatchSemaphore(value: 0)
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
                        
                        if (str.isEqual(to: "true" ))
                        {
                            exists = true;
                        }
                        else if (str.isEqual(to: "false" ))
                        {
                            exists = false;
                        }
                        print("real value here")
                        print(exists)
                    }
                    
                }
                else{
                    print("didnt work")
                }
            }
            sem.signal()
            }.resume()
        sem.wait()
        
        print(exists)
        return exists;
    }
    
    
    static func getUserEvents() -> [Int]? {
        var list: [Int]?
        let linkk = URL(string: "\(HOSTPATH)getEventList.php")!
        
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        
        var d = Data()
         d.appendStr("id=\(id!)")
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
    
    static func getEventsByProximity(longitude: Double, lattitude: Double, searchValue: String) -> [Int]? {
        var list: [Int]?
        let linkk = URL(string: "\(HOSTPATH)getEventListByProximity.php")!
        
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        
        var d = Data()
        
d.appendStr("searchValue=\(searchValue)&longitude=\(longitude)& lattitude=\(lattitude)")
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
    
    static func  updateImage(photo: UIImage?) {
        let linkk = URL(string: "\(HOSTPATH)uploadphoto.php")!
        
        let image = photo
        let imagedata = UIImageJPEGRepresentation(image!, 0.1)
        var request = URLRequest(url: linkk)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let objname = "username"
        let objname2 = "hostpath"
        let name = "file"
        //let filename = "pprofilepicture.jpg"
        let filename = "pprofilepicture.jpg"
        let pboundary = "--\(boundary)\r\n"
        let mimetype = "image/jpg"
        var data = Data()
        
        
        data.appendStr(pboundary)
        data.appendStr("Content-Disposition: form-data; name=\"\(objname)\"\r\n\r\n")
        data.appendStr("\(self.username!)\r\n")
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
        
        
        
        /*let imagedata = UIImageJPEGRepresentation(testimage!, 1)
        var d = Data()
        let d1 = "photo="
        let d2 = "yoyo"
        let dd1 = d1.data(using: String.Encoding.utf8)
        d.append(dd1!)
        let dd2 = imagedata
        d.append(dd2!)*/
        
        //d.append(imagedata!)
        
      //  let tsst = "email=yoyo"
        //let postString = tsst.data(using: String.Encoding.utf8)
      
        
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
                    thisUser.profilepicture = photo!
                }
                else{
                    print("didnt work")
                }
            }
            
            
            
            
            
            sem.signal()
            }.resume()
        sem.wait()
      
    }
   
    static func joinEvent(eventid: Int) {
        
        
        let linkk = URL(string: "\(HOSTPATH)joinEvent.php")!
        
        let postString = "eventid=\(eventid) & userid=\(self.id!)"
        
        
        
        let request = NSMutableURLRequest(url: linkk);
        request.httpMethod = "POST"
        
        let sem = DispatchSemaphore(value: 0)
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
            sem.signal()
            }.resume()
        sem.wait()
        
        
        
        
    }
    
    static func unjoinEvent(eventid: Int) {
        
        
        let linkk = URL(string: "\(HOSTPATH)unjoinEvent.php")!
        
        let postString = "eventid=\(eventid) & userid=\(self.id!)"
        
        
        
        let request = NSMutableURLRequest(url: linkk);
        request.httpMethod = "POST"
        
        let sem = DispatchSemaphore(value: 0)
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
            sem.signal()
            }.resume()
        sem.wait()
        
        
        
        
    }
    
    static func deleteEvent(eventid: Int) {
        
        
        let linkk = URL(string: "\(HOSTPATH)deleteEvent.php")!
        
        let postString = "eventid=\(eventid) & userid=\(self.id!)"
        
        
        
        let request = NSMutableURLRequest(url: linkk);
        request.httpMethod = "POST"
        
        let sem = DispatchSemaphore(value: 0)
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
            sem.signal()
            }.resume()
        sem.wait()
        
        
        
        
    }
    //MARK: Getters and setters
    static func getInfo() -> userinfo {
        let linkk = URL(string: "\(HOSTPATH)getThisUserInfo.php")!
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
        d.appendStr("username=\(self.username!)&password = \(self.password!)")
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
    
    static func getId() -> Int? {
        return id
    }
    
    static func getUsername() -> String? {
        
        return username
    }
    
    static func getPassword() -> String? {
        
        return password
    }
    
    static func getFirstname() -> String? {
        return firstname
    }
    
    static func getLastname() -> String? {
        return lastname
    }
    
    static func getEmail() -> String? {
        return email
    }
    static func getBirthday() -> Date? {
        return birthday
    }
    
    static func getAge() -> Int? {
        return age
    }
    
    static func getRating() -> Int? {
        return rating
    }
    
    static func getEventsAttended() -> Int? {
        return eventsattended
    }
    
    static func getEventsRsvped() -> Int? {
        return eventsrsvped
    }
    
    static func getProfilePicture() -> UIImage? {
        return profilepicture
    }
    
    static func getGender() -> String? {
        return gender
    }
    
    
    static func setUsername(_ username: String)  {
        self.username = username
    }
    
    static func setPassword(_ password: String) {
        self.password = password
    }
    
    static func incEventsAttended() {
        if (self.eventsattended == nil) {
            self.eventsattended = 0
        }
        self.eventsattended! += 1
    }
    
    static func incEventsRsvped() {
        if (self.eventsrsvped  == nil) {
            self.eventsrsvped = 0
        }
       self.eventsrsvped! += 1
    }
    
   
    //Helper functions:
    static func calculateAge(_ birthday: Date) -> Int{
        let now = Date()
        let Birthday: Date = birthday
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: Birthday, to: now)
        let age = ageComponents.year!
        return age
    }
    
    
}

extension Data {
    mutating func appendStr(_ str: String){
        let d = str.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(d!)
    }
}

extension DateFormatter {
    static let iso8601Date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
       
        return formatter
        
        
        
    }()
    
    
    
}
/*
static func registerUser(Ui: userinfo) -> Bool {
    let linkk = URL(string: "http://localhost/registeruser.php")!
    
    var request = URLRequest(url: linkk)
    request.httpMethod = "POST"
    print("heeeerererererereererere")
    do {
        let d = try
            JSONEncoder().encode(Ui)
        request.httpBody = d
        print("FOCUSSS")
        let dd = try JSONDecoder().decode(userinfo.self, from: d)
        //print(dd)
    } catch let error {
        print("didn't work",error)
    }
    
    let sem = DispatchSemaphore(value: 0)
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
        
        
        
        
        
        sem.signal()
        }.resume()
    sem.wait()
    return false
}*/
