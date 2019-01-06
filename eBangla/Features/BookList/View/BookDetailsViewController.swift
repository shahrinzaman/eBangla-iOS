//
//  BookDetailsViewController.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageViewBook: UIImageView!
    
    @IBOutlet weak var labelBookTitle: UILabel!
    
    @IBOutlet weak var labelBookWriter: UILabel!
    
    @IBOutlet weak var labelBookPublisher: UILabel!
    
    @IBOutlet weak var labelBookDetails: UILabel!
    
    //CART VIEW
    @IBOutlet weak var labelCartItemCount: UILabel!
    var cartItemCount:Int = 0{
        didSet{
            labelCartItemCount.text = " \(cartItemCount) item "
        }
    }
    @IBOutlet weak var labelCartItemPrice: UILabel!
    var cartItemPrice:Double = 0{
        didSet{
            labelCartItemPrice.text = " $\(cartItemPrice) "
        }
    }
    
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        startAddToCart()
    }
    
    
    
    //presenter
    var presenter:BookDetailsPresenter!
    
    var bookData:BookDetailsViewData?{
        didSet{
            guard let bookData = bookData else { return }
            self.labelBookTitle.text = bookData.title
            self.labelBookWriter.text = bookData.writer
            self.labelBookPublisher.text = bookData.publisher
            self.labelBookDetails.text = bookData.bookDescription
            self.imageViewBook.kf.setImage(with: bookData.imageURL)
        }
    }
    
    var cartItem:CartItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Book Details"
        presenter.attachView(self)
        presenter.getBookDetails()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidAddToCart(_:)), name: .didAddToCart, object: nil)
        
        
    }
    
    deinit {
        print("deinit from book details")
        NotificationCenter.default.removeObserver(self, name: .didAddToCart, object: nil)
        presenter.detachView()
    }
    
    //MARK:- On cart update
    @objc func onDidAddToCart(_ notification: Notification){
        print("on detail vc")
        if let cartItemNotification = notification.userInfo as? [String: CartItem],
            let cartItem = cartItemNotification[Notification.Name.didAddToCart.rawValue]{
            
            self.cartItemCount = cartItem.totalCount
            self.cartItemPrice = Double(cartItem.totalCount) * cartItem.price
        }
    }
    
    
    func startAddToCart(){
        
        
        //TODO:- need to do this work in presenter
        guard let bookData = bookData else { return }
        if cartItem == nil{
            cartItem = CartItem.init(id: bookData.id, price: bookData.price, title: bookData.title, description: nil)
        }
        
        CartService.shared.addToCart(item: cartItem!)
        
    }
    
    
}


extension BookDetailsViewController: BookDetailsView {
    
    
    
    func startLoading() {
    }
    
    func finishLoading() {
    }
    
    func setBookDetails(_ book: BookDetailsViewData) {
        self.bookData = book
        
    }
    
    func setEmptyBook() {
    }
    
    
}
