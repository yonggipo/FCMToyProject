//
//  ViewController.swift
//  FCMToyProject
//
//  Created by 조기열 on 7/4/24.
//

import UIKit

extension Notification.Name {
    static let fcmToken = Notification.Name("FCMToken")
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tokenTextView: UITextView!
    @IBOutlet weak var userInfoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: Notification.Name.fcmToken, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            userInfoTextView.text = userInfo.description
            
            if let token = userInfo["token"] as? String {
                tokenTextView.text = token
            }
        }
    }
}

