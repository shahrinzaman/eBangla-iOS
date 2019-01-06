//
//  BookListViewController.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import UIKit
import Kingfisher

class BookListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emptyView: UILabel!
    
    
    
    fileprivate let service = BookService()
    fileprivate lazy var presenter = BookPresenter(bookService: service)
    fileprivate var booksData = [BookViewData]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Book List"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter.attachView(self)
        presenter.getListOfBooks()
    }
    
    deinit {
        print("deinit")
        presenter.detachView()
    }
    

}


extension BookListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookCollectionViewCell.self)", for: indexPath) as! BookCollectionViewCell
        let booksViewData = booksData[indexPath.row]
        cell.labelOfTitle.text = booksViewData.title
        cell.labelOfWriter.text = booksViewData.writer
        cell.imageViewOfBook.kf.setImage(with: booksViewData.imageURL)
        return cell
    }
    
}



extension BookListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailBookVC = self.storyboard?.instantiateViewController(withIdentifier: "\(BookDetailsViewController.self)") as? BookDetailsViewController else { return }
        
        //assign presenter to next VC
        let booksViewData = booksData[indexPath.row]
        let presenter = BookDetailsPresenter(bookService: self.service, bookId: booksViewData.id)
        detailBookVC.presenter = presenter
        
        self.navigationController?.pushViewController(detailBookVC, animated: true)
    }
}

extension BookListViewController: BookView {
    
    func startLoading() {
        emptyView.isHidden = true
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    func setBooks(_ books: [BookViewData]) {
        booksData = books
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    func setEmptyBooks() {
        collectionView.isHidden = true
        emptyView.isHidden = false
    }
    
    
}
