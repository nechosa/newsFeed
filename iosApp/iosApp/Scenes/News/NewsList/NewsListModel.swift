//
//  NewsListModel.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 18.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import shared
import Foundation

class NewsListModel : ObservableObject {
    @Published var newsItems: [NewsItem] = [NewsItem]()
    unowned var coordinator: NewsListCoordinator!

    lazy var store: NewsListStore = {
       let store = NewsListStore()
        store.observeState().collect(collector: collector) { (_, _) in}
        return store
    }()

    lazy var collector: Observer = {
        let colletor = Observer { value in
            if let value = value as? NewsStoreState {
                self.newsItems = value.component2()
                for n in self.newsItems {
                    print(n)
                }
            }
        }
        return colletor
    }()


    func loadNews() {
        self.store.refresh()
    }

    func open(_ newsItem: NewsItem) {
       self.coordinator.open(newsItem)
    }
}

typealias Collector = Kotlinx_coroutines_coreFlowCollector

class Observer : Collector {
    let callback: (Any?)->Void
    init(callback: @escaping(Any?)->Void) {
        self.callback = callback
    }

    func emit(value: Any?, completionHandler: @escaping (KotlinUnit?, Error?) -> Void) {
        callback(value)
        completionHandler(KotlinUnit(),nil)
    }
}


