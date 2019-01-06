//
//  BookService.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import Foundation


class BookService {
    
    //Books info were taken from rokomari.com
    fileprivate let books:[Book] = [
        Book(id: 20001, name: "দ্বিতীয় বিশ্বযুদ্ধ", writer: "মেজর মোঃ দেলোয়ার হোসেন", publications: "নালন্দা", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/7f83255f3_175098.jpg"),
        Book(id: 202501, name: "পাকিস্তানি জেনারেলদের মন : বাঙালি বাংলাদেশ মুক্তিযুদ্ধ (হার্ডকভার)", writer: "মুনতাসীর মামুন", publications: "সময় প্রকাশন", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/7cbf07cc3_3632.jpg"),
        Book(id: 200801, name: "চরমপত্র (হার্ডকভার)", writer: "এম আর আখতার মুকুল", publications: "অনন্যা", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/975eab625_195.jpg"),
        Book(id: 2720001, name: "শম্ভুনাথ চট্টোপাধ্যায়: কবিতার দিকে একজন (হার্ডকভার)", writer: "নূরুল হক", publications: "বেহুলাবাংলা", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/f73274595994_132326.jpg"),
        Book(id: 454758, name: "দূরবীন (হার্ডকভার)", writer: "শীর্ষেন্দু মুখোপাধ্যায়", publications: "আনন্দ পাবলিশার্স (ভারত)", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/9265ddfefc44_43691.gif"),
        Book(id: 323454, name: "সাতকাহন (হার্ডকভার)", writer: "সমরেশ মজুমদার", publications: "নবযুগ প্রকাশনী", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/c8305ca08_27935.jpg"),
        Book(id: 777765, name: "সুখে থাকো তুমি", writer: "জালাল আহমেদ", publications: "মহাকাল", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/rokimg_20140203_76851.GIF"),
        Book(id: 436755, name: "আপন আলয় (পেপারব্যাক)", writer: "সুপ্রিয় কুমার চক্রবর্তী", publications: "মহাকাল", imgUrlStr: "https://s3-ap-southeast-1.amazonaws.com/rokomari110/productNew/260X372/f66626236ee4_111558.gif")
    ]
    
    //the service delivers mocked data with a delay
    func getBooks(_ onCompletion:@escaping ([Book]) -> Void){
        
        let delayTime = DispatchTime.now() + Double(Int64(1.7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {[weak self] in
            guard let strongSelf = self else { return onCompletion([]) }
            onCompletion(strongSelf.books)
        }
    }
    
    //get any book via book id
    func getBook(byId id:Int,onCompletion:@escaping (Book?) -> Void ){
        onCompletion( books.filter{($0.id == id)}.first )
    }
    
}
