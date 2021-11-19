//
//  NewsList.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import shared
import SwiftUI

struct NewsList: View {

    // MARK: Stored Properties

    @ObservedObject var viewModel: NewsListModel

    // MARK: Views

    var body: some View {
        List(viewModel.newsItems) { newsItem in
            HStack {
                AsyncImage(url: newsItem.imageURL())
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                Text(newsItem.title ?? "")
                    .font(.headline)
                Spacer()
            }
            .onNavigation { viewModel.open(newsItem) }
        }
        .navigationTitle("Список новостей")
    }

}


extension NewsItem {
    func imageURL() -> URL? {
        if let url = urlToImage {
            return URL(string: url)
        }
        return nil
    }
}

//struct NewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsList()
//    }
//}

extension NewsItem: Identifiable {

    public var id: String {
        urlToImage ?? ""
    }

}
