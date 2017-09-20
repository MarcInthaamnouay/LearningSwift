//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

// Enum which is use to define the factor of size of the recipient
enum BobbaSize: Int {
    case small  = 10
    case medium = 20
    case big    = 30
    
    case commW  = 25
    case commH  = 35
}


// Create a class which will handle the view
class ViewManager {
    
    // Constant of the Manager
    let left  = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var view: UIView
    var size: Double
    
    /**
     *  Init
     */
    init(bobbaSize: Double) {
        self.view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.left, height: self.height))
        self.size = bobbaSize
    }
    
    
    /**
     *  Prepare the view of recipient of the bobba
     */
    public func prepareRecipientView(getSizeFactor: (Double) -> BobbaSize) {
        let factor: CGFloat = CGFloat(Float(getSizeFactor(self.size).rawValue))
        
        // Create a recipient based on the size of the bobba size
        let recipient = UIView(frame: CGRect(x: self.left - factor, y: self.height, width: CGFloat(BobbaSize.commW.rawValue) + factor, height: CGFloat(BobbaSize.commH.rawValue) + factor))
        
        // Put the recipient in the center of the view
        recipient.center = self.view.center
        
        // Append the recipient to the main view
        self.view.addSubview(recipient)
    }
    
    public func prepareInputView() {
        let textView = UITextView(frame: CGRect(x: 0.0, y: 0.0, width: self.left - 100, height: 30))
        print(textView.text)
    }
    
    
    /**
     * Add Bobba
     */
    private func addBobba(b: Bobba) {
        // Create a bobba using the inputs from the user
    }
}


