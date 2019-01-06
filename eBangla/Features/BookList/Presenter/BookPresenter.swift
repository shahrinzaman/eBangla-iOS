//
//  BookPresenter.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import Foundation


struct BookViewData{
    let id:Int
    let title: String
    let writer: String
    let imageURL: URL?
}

protocol BookView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setBooks(_ books: [BookViewData])
    func setEmptyBooks()
}

class BookPresenter {
    
    fileprivate let bookService:BookService
    weak fileprivate var bookView : BookView?
    
    init(bookService:BookService){
        self.bookService = bookService
    }
    
    func attachView(_ view: BookView){
        bookView = view
    }
    
    func detachView() {
        bookView = nil
    }
    
    func getListOfBooks(){
        self.bookView?.startLoading()
        self.bookService.getBooks{ [weak self] books in
            self?.bookView?.finishLoading()
            if(books.count == 0){
                self?.bookView?.setEmptyBooks()
            }else{
                let mappedUsers = books.map{ (book) in
                    return BookViewData(id: book.id, title: book.name, writer: book.writer, imageURL: book.imgUrl)
                }
                self?.bookView?.setBooks(mappedUsers)
            }
            
        }
    }
}
