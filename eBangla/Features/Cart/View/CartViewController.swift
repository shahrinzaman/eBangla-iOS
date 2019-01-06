//
//  CartViewController.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    
    let cartService = CartService.shared
    var cartItems:[CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cart Details"
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        cartItems = cartService.getAllCartItems()
        cartLabelsUpdate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidAddToCart(_:)), name: .didAddToCart, object: nil)
    }
    
    deinit {
        print("deinit from cart vc")
        NotificationCenter.default.removeObserver(self, name: .didAddToCart, object: nil)
    }
    
    //MARK:- On cart update
    @objc func onDidAddToCart(_ notification: Notification){
        print("on cart vc")
        if let cartItemNotification = notification.userInfo as? [String: CartItem],
            let _ = cartItemNotification[Notification.Name.didAddToCart.rawValue]{
            cartItems = CartService.shared.getAllCartItems()
            tableView.reloadData()
            cartLabelsUpdate()
        }
    }
    
    func cartLabelsUpdate(){
        let totalItemCountWithPrice: ( count:Int,price:Double ) = cartService.getAllCartItemCountWithPrice()
        self.cartItemCount = totalItemCountWithPrice.count
        self.cartItemPrice = totalItemCountWithPrice.price
    }
    

}



extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let cartItem = cartItems[indexPath.row]
        cell?.textLabel?.text = "Item: \(cartItem.title)"
        cell?.detailTextLabel?.text = "x\(cartItem.totalCount) Price: \(cartItem.price)"
        return cell!
    }
    
}
