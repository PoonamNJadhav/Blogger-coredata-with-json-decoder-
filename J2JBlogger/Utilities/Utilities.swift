//
//  Utilities.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 18/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit
import AVKit

class Utilities {
    
class func heightForView(text:String, font:(fontName: String, fontSize: CGFloat), width:CGFloat) -> CGFloat{
    
    let label:UITextView = UITextView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width-width, height: CGFloat.greatestFiniteMagnitude))
//    label.numberOfLines = 0
//    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont(name: font.fontName, size: font.fontSize)
    label.text = text
    label.sizeToFit()
    return label.frame.height
}
    class func dateConvertor(fromString:String)->Date {
        var date = Date()
      //  let testDate = "2020-04-17T01:30:57.213Z"//2020-04-17T01:30:57.213Z
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        date = dateFormatter.date(from:fromString)!
        return date
    }
    class func relativeTime(_ fromDate: Date)->String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        let relativeDuration = formatter.localizedString(for: fromDate, relativeTo: Date())
        return relativeDuration
    }
}
