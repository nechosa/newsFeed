//
//  NewsListCoordinator.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI
import shared

class NewsListCoordinator: ObservableObject, Identifiable {

    // MARK: Stored Properties

    //@ObservedObject var viewModel: NewsListModel = NewsListModel()
    @Published var newsViewModel: NewsViewModel?
    @Published var viewModel: NewsListModel!

    //private let deviceService: DeviceService
    private unowned let parent: HomeCoordinator

    // MARK: Initialization

    init(
        title: String,
        parent: HomeCoordinator,
        viewModel: NewsListModel
    ) {
        self.parent = parent
        self.viewModel = viewModel
    }

//    init(title: String,
//         //deviceService: DeviceService,
//         parent: HomeCoordinator,
//        // filter: @escaping (News) -> Bool
//    ) {
//        self.parent = parent
//        //self.deviceService = deviceService
//
////        self.viewModel = .init(
////            title: title,
////           // deviceService: deviceService,
////            coordinator: self//,
////           // filter: filter
////        )
//    }

    // MARK: Methods

    func loadNews() {
        //viewModel.loadNews()
    }

    func open(_ newsItem: NewsItem) {
        self.newsViewModel = .init(newsItem: newsItem, coordinator: self)
    }
//
//    func openRatings(for device: Device) {
//        self.ratingViewModel = .init(device: device, deviceService: deviceService, coordinator: self)
//    }
//
//    func closeRatings() {
//        self.ratingViewModel = nil
//    }

    func open(_ url: URL) {
        self.parent.open(url)
    }

}

