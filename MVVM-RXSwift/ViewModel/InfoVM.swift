//
//  InfoVM.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import Foundation
import RxSwift
import RxCocoa

class InfoListVM {
    init() {
        self.populateData()
    }
    
    var actionHandler: ActionHandler?
    
    var infoList: DynamicType<[InfoVM]> = DynamicType([])
    
    private let disposeBag = DisposeBag()
}

extension InfoListVM {
    func populateData() {
        guard let url = URL(string: ApiEndpoints.newsApi) else {
            print("Valid Endpoint missing")
            return
        }
        let resource = Request<ArticleList>(url: url)
        URLRequest.loadData(resource)
            .observeOn(MainScheduler.instance)
            .catchError {
                print("Data Loading Failed. Error: \($0.localizedDescription)")
                return Observable<ArticleList?>.just(nil)
            }
            .subscribe(onNext: {[weak self] articles in
                self?.infoList.value = articles?.articles.compactMap(InfoVM.init) ?? []
            })
            .disposed(by: disposeBag)
    }
    
    func info(at index: Int) -> InfoVM {
        return infoList.value[index]
    }
    
    func numberOfItems() -> Int {
        return infoList.value.count
    }
}

struct InfoVM {
    init(_ article: Article) {
        self.article = article
    }
    
    private let article: Article
}

extension InfoVM {
    
    var title: Observable<String?> {
        Observable<String?>.just(article.title)
    }
    
    var description: Observable<String?> {
        Observable<String?>.just(article.description)
    }
    
    var author: Observable<String?> {
        Observable<String?>.just(article.author)
    }
    
    var imageURL: Observable<URL?> {
        let url = URL(string: article.imageURL ?? "")
        return Observable<URL?>.just(url)
    }
    
    var navigationURL: Observable<URL?> {
        let url = URL(string: article.navigationURL ?? "")
        return Observable<URL?>.just(url)
    }
}
