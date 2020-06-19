//
//  ArticleViewController.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 17/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet var articleCollectionview: UICollectionView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    var articleModelList = [ArticleViewModel]()
    var currentPage : Int = 1
    var pageLimit : Int = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.title = "Articles"
        self.navigationController?.navigationBar.topItem?.title = "Articles"
        self.fetchAndShowArticles()
        
    }
    func showActivityIndicator(){
        self.activityView.isHidden = false
        self.activityView.startAnimating()
    }
    func hideActivityIndicator(){
           self.activityView.isHidden = true
           self.activityView.stopAnimating()
       }
    func fetchAndShowArticles(){
        self.showActivityIndicator()
         ClientService.shared.fetchArticles(page:currentPage,completion: {[weak self] (result) in
            switch result{
                
            case .success(let data):
               
                if let dataToParse = data {
                    self?.articleModelList += DataHelper.shareInstance.parseAndSaveData(jsonData: dataToParse)
                    DispatchQueue.main.async {
                        self?.hideActivityIndicator()
                        self?.articleCollectionview.reloadData()
                       }
                }
            case .error(let error):
                //self?.showError("Error", message: error?.localizedDescription ?? "No networkout connection")
                //fetch data in offline
                //if(error.debugDescription.contains("offline")){
                  
                    self?.articleModelList += (DataHelper.shareInstance.fetchFromDataBase(self?.currentPage ?? 1, self?.pageLimit ?? 10) ?? [])
                    DispatchQueue.main.async {
                        self?.articleCollectionview.reloadData()
                      
                                          }
               // }
                print(error.debugDescription)
            }
        })
    }
    func loadNextPage(){
        currentPage += 1
        fetchAndShowArticles()
        
    }

}
//MARK - Delegate and datasource methods
extension ArticleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleModelList.count
      }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell:ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
          let model = articleModelList[indexPath.row]
          cell.articleViewModel = model
       
          return cell
          
      }
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Loading next page here we can add on scroll event also..
          if (indexPath.row == (currentPage*pageLimit - 1 ) ) { //it's your last cell
            //Load more data & reload your collection view
            self.loadNextPage()
          }
     }
    
}
extension ArticleViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !articleModelList.isEmpty {
                    let height = articleModelList[indexPath.row].calculatedModelHeight()
                   return CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat(height))
                   }
                     return CGSize.zero
    }
    
}
extension UIViewController {
    func showError(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
         DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
