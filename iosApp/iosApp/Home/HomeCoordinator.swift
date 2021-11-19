//
//  HomeCoordinator.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import shared

enum HomeTab {
    case news
    case results
    case settings

    func title() -> String {
        switch self {
        case .news:
            return "Новости"
        case .results:
            return "Каталог"
        case .settings:
            return "Настройки"
        }
    }


    func image() -> String {
        switch self {
        case .news:
            return "newspaper"
        case .results:
            return "folder.fill"
        case .settings:
            return "gear"
        }
    }
}

class HomeCoordinator: ObservableObject {

    // MARK: Stored Properties

    @Published var tab = HomeTab.news
    @Published var newsCoordinator: NewsListCoordinator!
    @ObservedObject var model = NewsListModel()
    //@Published var resultCoordinator: DeviceListCoordinator!

    @Published var openedURL: URL?

//    private let deviceService: DeviceService

    // MARK: Initialization

    init() {
//        self.deviceService = deviceService

        self.newsCoordinator = .init(
            title: HomeTab.news.title(),
            //deviceService: deviceService,
            parent: self,
            viewModel: model
            //filter: { $0.isVegetarian }
        )
        model.coordinator = newsCoordinator

//        self.resultCoordinator = .init(
//            title: HomeTab.results.title(),
//            deviceService: deviceService,
//            parent: self,
//            filter: { !$0.isVegetarian }
//        )
    }

    // MARK: Methods

    func open(_ url: URL) {
        self.openedURL = url
    }

}
