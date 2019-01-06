//
//  BookDetailsPresenter.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import Foundation


struct BookDetailsViewData{
    let id:Int
    let title: String
    let price: Double
    let writer: String
    let imageURL: URL?
    let publisher: String
    let bookDescription: String?
}

protocol BookDetailsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setBookDetails(_ book: BookDetailsViewData)
    func setEmptyBook()
}

class BookDetailsPresenter {
    
    fileprivate let bookService:BookService
    fileprivate let bookId:Int
    weak fileprivate var bookDetailsView : BookDetailsView?
    
    init(bookService:BookService, bookId:Int){
        self.bookService = bookService
        self.bookId = bookId
    }
    
    func attachView(_ view: BookDetailsView){
        bookDetailsView = view
    }
    
    func detachView() {
        bookDetailsView = nil
    }
    
    func getBookDetails(){
        self.bookDetailsView?.startLoading()
        self.bookService.getBook(byId: self.bookId){ [weak self] book in
            self?.bookDetailsView?.finishLoading()
            
            guard let book = book else {
                self?.bookDetailsView?.setEmptyBook()
                return
            }
            
            let bookDetailViewData = BookDetailsViewData.init(id: book.id, title: book.name, price: 40.0, writer: book.writer, imageURL: book.imgUrl, publisher: book.publications, bookDescription: "Lorem ipsum dolor...dsklfsjfj akfjkdjk")
            self?.bookDetailsView?.setBookDetails(bookDetailViewData)
            
            
        }
    }
}
