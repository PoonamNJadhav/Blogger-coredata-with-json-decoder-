//
//  ArticleViewModel.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 17/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    let userFullName: String
    let userDesignation:String
    let userProfilePicURL:URL?
    let articleCreatedAt:String?
    var articleImageURL:URL?
    let articleContent:String?
    let articleTitle:String?
    let articlePageURL:String?
    let articleLikes:String?
    let articleComments:String?
    let lastModified:String?
    
    // Dependency Injection
       init(_ article: Article) {
        self.userFullName =  (article.user?.first?.name ?? " ") + " " + (article.user?.first?.lastname ?? "")
        self.userDesignation = article.user?.first?.designation ?? ""
        
        if let airticlePic = article.user?.first?.avatar , let url = URL(string:airticlePic)  {
                   self.userProfilePicURL = url
               }
        else {
                   self.userProfilePicURL = nil
               }
        self.articleCreatedAt = article.media?.first?.createdAt
        self.articleImageURL = nil
        if let airticlePic = article.media?.first?.image , let url = URL(string:airticlePic)  {
            self.articleImageURL = url
        }
        
        self.articleContent = article.content
        self.articleTitle = article.media?.first?.title ?? ""
        self.articlePageURL = article.media?.first?.url ?? ""
        self.articleLikes = article.likes
        self.articleComments = article.comments
        
        let timePassed = Utilities.dateConvertor(fromString: article.createdAt ?? "")
        self.lastModified = Utilities.relativeTime(timePassed).replacingOccurrences(of: "ago", with: "")
        
    }
   
   func calculatedModelHeight()-> Float {
        var height:Float = 186.0
        
        if(self.articleImageURL != nil) {
            height += 111
        }
        if let content = self.articleContent , content != "" {
           height +=  Float(Utilities.heightForView(text: content, font:(fontName: "Helvetica", fontSize: 17.0) , width: 29))
        }
        if (self.articleTitle == "") {
            height -= 25
        }
        if (self.articlePageURL == nil) {
            height -= 25
        }
       
        return height
    }
   
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

