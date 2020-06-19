//
//  ArticleCell.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 18/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    @IBOutlet weak fileprivate var avtarImage: AsyncImageView!
    @IBOutlet weak fileprivate var userNameLabel: UILabel!
    @IBOutlet weak fileprivate var userDesigLabel: UILabel!
    @IBOutlet weak fileprivate var lastUpdatedLabel: UILabel!
    @IBOutlet weak fileprivate var articleImage: AsyncImageView!
    @IBOutlet weak fileprivate var articleMediaView: UIView!
    @IBOutlet weak fileprivate var articleContents: UITextView!
    @IBOutlet weak fileprivate var articleTitle: UILabel!
    @IBOutlet weak fileprivate var articlePage: UILabel!
    @IBOutlet weak fileprivate var articleLikes: UILabel!
    @IBOutlet weak fileprivate var articleComments: UILabel!
   @IBOutlet weak fileprivate var contentHeightConstraints:NSLayoutConstraint!
   @IBOutlet weak fileprivate var articleWebHeightConstraints:NSLayoutConstraint!
   @IBOutlet weak fileprivate var articleTitleHeightConstraints:NSLayoutConstraint!
    
   
    var articleViewModel: ArticleViewModel! {
        didSet {
            if let url =  articleViewModel.userProfilePicURL {
                avtarImage.setImageURL(url)
            }
            self.userNameLabel.text = articleViewModel.userFullName
            self.userDesigLabel.text = articleViewModel.userDesignation
           
          if let url =  articleViewModel.articleImageURL {
                articleMediaView.isHidden = false
                articleImage.setImageURL(url)
            }
            
            if let title = articleViewModel.articleTitle {
            articleTitle.text = title
            }
            if articleViewModel.articlePageURL != nil {
               articlePage.text = articleViewModel.articlePageURL ?? ""
            }
            articleComments.text = (articleViewModel.articleComments ?? "0 K") + " Comments"
            articleLikes.text = (articleViewModel.articleLikes ?? "0 K") + " Likes"
            
            articleContents.text = articleViewModel.articleContent ?? ""
            lastUpdatedLabel.text = articleViewModel.lastModified 
            setUpContentView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avtarImage.setRoundedBorder()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
         self.avtarImage.image = UIImage(named: "AvtarImage")
         self.articleImage.image = nil
         articleMediaView.isHidden = true
        
    }
       
    func setUpContentView(){
    let contentText = articleViewModel.articleContent ?? ""
    let height = Utilities.heightForView(text: contentText, font:(fontName: "Helvetica", fontSize: 17.0) , width: 29)
    contentHeightConstraints.constant = height

        if self.articleTitle.text == "" {
        articleTitleHeightConstraints.constant = 0
      }
        if self.articlePage.text == "" {
               articleWebHeightConstraints.constant = 0
             }
        
    needsUpdateConstraints()
        
    }
}
extension UIImageView {
 func setRoundedBorder() {
   self.layer.borderWidth = 1
   self.layer.masksToBounds = false
    self.layer.borderColor = UIColor.darkGray.cgColor
   self.layer.cornerRadius = self.frame.height / 2
   self.clipsToBounds = true
   }
}
