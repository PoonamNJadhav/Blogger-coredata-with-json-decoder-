//
//  AsyncImageView.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 18/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//
import UIKit

class AsyncImageView :UIImageView {
    var imageURL:URL?
    var dataTask:URLSessionDataTask? = nil
    var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Adding Extra design
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x:self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        activityIndicator.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin , .flexibleRightMargin, .flexibleBottomMargin]
        activityIndicator.removeFromSuperview()
        self.addSubview(activityIndicator)
    }
    init(_ frame: CGRect) {
        super.init(frame:frame)
    }
    init(_ imageURL:URL) {
        super.init(frame:CGRect.zero)
        setImageURL(imageURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    deinit {
        
        self.dataTask?.cancel()
    }
    
    
    func cancelDownload(){
        guard self.dataTask != nil else {
            return
        }
        //print("Cancel Task------>")
        
        self.dataTask?.cancel()
        self.dataTask = nil
        self.image = nil
        
    }
    func setImageURL(_ imageURL:URL){
        self.buildAsyncTask(imageURL)
    }
    
    func buildAsyncTask(_ imageURL:URL){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            let request = URLRequest(url: imageURL,
                                     cachePolicy: .returnCacheDataElseLoad,
                                     timeoutInterval: 30)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    return
                }
                
                guard let data = data else {
                    return
                }
                DispatchQueue.main.sync {
                    self.activityIndicator.stopAnimating()
                
                        self.image = UIImage(data: data)
                        
                   
                }
            }
            self.dataTask = task
            task.resume()
            
        }
    }
}
