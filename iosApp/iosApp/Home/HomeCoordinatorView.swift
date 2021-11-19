//
//  HomeCoordinatorView.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

struct HomeCoordinatorView: View {

    // MARK: Stored Properties

    @ObservedObject var coordinator: HomeCoordinator

    // MARK: Views

    var body: some View {
        TabView(selection: $coordinator.tab) {

            NewsListCoordinatorView(coordinator: coordinator.newsCoordinator)
            .tabItem { Label(HomeTab.news.title(), systemImage: HomeTab.news.image()) }
            .tag(HomeTab.news)

            NavigationView {
                SettingsView(coordinator: coordinator)
            }
            .tabItem { Label(HomeTab.results.title(), systemImage: HomeTab.results.image()) }
            .tag(HomeTab.results)

            NavigationView {
                SettingsView(coordinator: coordinator)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem { Label(HomeTab.settings.title(), systemImage: HomeTab.settings.image()) }
            .tag(HomeTab.settings)
        }.onAppear(perform: {
            coordinator.model.loadNews()
        })
        .sheet(item: $coordinator.openedURL) {
            SafariView(url: $0)
                .edgesIgnoringSafeArea(.all)
        }
    }

}

extension URL: Identifiable {

    public var id: String {
        absoluteString
    }

}

//struct HomeCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeCoordinatorView()
//    }
//}
