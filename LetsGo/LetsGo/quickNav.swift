//
//  quickNav.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-30.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class quickNav: UIStackView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   /* override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
    }*/
 
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    setupButtons()
       
      
       
        
    }
    
    required init (coder: NSCoder) {
        super.init(coder: coder)
       setupButtons()
        
    }

    func setupButtons() {
        
       
        
        let button1 = UIButton()
        button1.backgroundColor = UIColor.darkGray
       
        
          button1.setTitle("+E", for: .normal)
            
        button1.addTarget(self, action: #selector(self.crEventTapped), for: .touchUpInside)
          
            
        addArrangedSubview(button1)
        
        let button2 = UIButton()
        button2.backgroundColor = UIColor.darkGray
        
        
        button2.setTitle("GO", for: .normal)
        button2.addTarget(self, action: #selector(self.GoButtonTapped), for: .touchUpInside)
       
        
        
        addArrangedSubview(button2)
        
        let button3 = UIButton()
        button3.backgroundColor = UIColor.darkGray
        
        
        button3.setTitle("P", for: .normal)
        button3.addTarget(self, action: #selector(self.profButtonTapped), for: .touchUpInside)

        
        
        addArrangedSubview(button3)
        
    }
    
     @objc func crEventTapped() {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyb.instantiateViewController(withIdentifier: "CreateEvent") as! CreateEventViewController
        //self.window?.rootViewController?.present(destination, animated: true, completion: nil)
        let navigator = UINavigationController(rootViewController: destination)
        
        
        
        
        self.window?.visibleViewController()?.present(navigator,animated: true)
        
    }
    
    @objc func profButtonTapped() {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyb.instantiateViewController(withIdentifier: "MainProfile") as! MainProfileViewController
       
          //self.window?.visibleViewController()?.present(destination, animated: false, completion: nil)
        let navigator = UINavigationController(rootViewController: destination)
        
       
      
    
        self.window?.visibleViewController()?.present(navigator,animated: true)
        
    }
    
    @objc func GoButtonTapped() {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyb.instantiateViewController(withIdentifier: "EventTableView") as! EventsViewController
        
        let navigator = UINavigationController(rootViewController: destination)
        
        
        
        
        self.window?.visibleViewController()?.present(navigator,animated: true)
        
    }
    
    
    
    
    
}


extension UIView {
    @discardableResult func addRightBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(layer)
        return self
    }
}

//Gets the top most view controller. Source: https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller
extension UIWindow {
    
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.self) {
            
            let navigationController = vc as! UINavigationController
            return UIWindow.getVisibleViewControllerFrom( vc: navigationController.visibleViewController!)
            
        } else if vc.isKind(of: UITabBarController.self) {
            
            let tabBarController = vc as! UITabBarController
            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController!)
            
        } else {
            
            if let presentedViewController = vc.presentedViewController {
                
                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
                
            } else {
                
                return vc;
            }
        }
    }
}
