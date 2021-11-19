//
//  NewsViewModel.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import shared
import Foundation

class NewsViewModel: ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published var newsItem: NewsItem

    private unowned let coordinator: NewsListCoordinator

    // MARK: Initialization

    init(newsItem: NewsItem, coordinator: NewsListCoordinator) {
        self.coordinator = coordinator
        self.newsItem = newsItem
    }

    // MARK: Methods

    func openRatings() {
        //self.coordinator.openRatings(for: newsItem)
    }

    func open(_ url: URL) {
        //self.coordinator.open(url)
    }

}
