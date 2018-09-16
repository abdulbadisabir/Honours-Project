//
//  UserPhotosStackView.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-12-02.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class UserPhotosStackView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 
    var list: [Int]?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
   
        setupButtons()
        
        print("GOT RELOADED: \(list)")
        
        
    }
    
    required init (coder: NSCoder) {
        super.init(coder: coder)
      print("GOT RELOADED: \(list)")
        setupButtons()
        
    }
    
   
    func setupButtons() {
        for x in self.subviews {
         x.removeFromSuperview()
        }
        
        
        if (list != nil) {
            var count = 0
        
        for id in list! {
            if count == 10 {
                break
            }
            let user = User(id: id)
            let image = user!.getProfilePicture()!
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            
            button.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            
            button.setBackgroundImage(image, for: .normal)
            button.layer.cornerRadius = 9
            button.clipsToBounds = true
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            addArrangedSubview(button)
            count += 1
        }
        
  
    }
        
        
        
        
       
        
        
        
    }

}
