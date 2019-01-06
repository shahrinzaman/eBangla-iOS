//
//  CartService.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import UIKit


class CartItem {
    let id:Int
    let price:Double
    let title:String
    let description:String?
    
    var totalCount:Int = 1 //need validation
    
    init(id:Int,price:Double,title:String,description:String?) {
        self.id = id
        self.price = price
        self.title = title
        self.description = description
    }
    
    
}
extension CartItem:Hashable,Equatable{
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool{
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
}


extension Notification.Name {
    static let didAddToCart = Notification.Name("me.shahrin.didAddToCart")
}

class CartService {
    
    static let shared = CartService()
    
    fileprivate var carts:Array<CartItem> = []
    
    func addToCart(item:CartItem) {
        if let indexOfCart = carts.index(where: {$0.id == item.id}){
            
            let mutedItem = item
            mutedItem.totalCount += 1
            carts[indexOfCart] = mutedItem
            notifyOnNewCartDidAdded(cart: mutedItem)
        }else{
            
            carts.append(item)
            notifyOnNewCartDidAdded(cart: item)
            
        }
        
        
    }
    
    func getAllCartItems() -> [CartItem]{
        return carts
    }
    
    
    func getAllCartItemCountWithPrice() -> (Int,Double) {
        let totalItemCountWithPrice: ( count:Int,price:Double ) = carts.reduce((0,0.0)) { (prevItemCountWithPrice, cartItem) -> (Int,Double) in
            
            let totalItemCount = cartItem.totalCount + prevItemCountWithPrice.0
            let totalPrice = prevItemCountWithPrice.1 + (Double(cartItem.totalCount) * cartItem.price)
            return (totalItemCount,totalPrice)
        }
        return totalItemCountWithPrice
        
    }
    
    
    func notifyOnNewCartDidAdded(cart:CartItem){
        NotificationCenter.default.post(name: .didAddToCart, object: nil, userInfo: [Notification.Name.didAddToCart.rawValue : cart])
    }
    
    
}
