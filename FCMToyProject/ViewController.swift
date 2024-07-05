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
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextfield: UITextField!
    @IBOutlet weak var sendUserNotificationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: Notification.Name.fcmToken, object: nil)
        sendUserNotificationButton.addTarget(self, action: #selector(sendNotiButtonTapped(_:)), for: .touchUpInside)
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
    
    @objc 
    func sendNotiButtonTapped(_ sender: UIButton) {
        let title = titleTextField.text ?? "title"
        let body = bodyTextfield.text ?? "body"
        presentNotificationAfter(seconds: 1.0, title: title, body: body)
    }
    
    func presentNotificationAfter(seconds: TimeInterval, title: String, body: String) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = title
        notiContent.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(
            identifier: "testNotification",
            content: notiContent,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                Swift.print("Notification Error: ", error)
            }
        }
    }
}

