//
//  NewsView.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI


struct NewsView: View {

//struct NewsView<RatingModifier: ViewModifier>: View {

    // MARK: Stored Properties

    @ObservedObject var viewModel: NewsViewModel
    //let ratingModifier: RatingModifier

    // MARK: Views

    var body: some View {
        List {
            if viewModel.newsItem.imageURL() != nil {
                AsyncImage(url: viewModel.newsItem.imageURL())
                    .frame(maxHeight: UIScreen.main.bounds.height / 3)
                    .clipped()
                    .listRowInsets(.init())
                    //.overlay(sourceOverlay, alignment: .bottom)
            }

//            Section(header: Text("Ingredients")) {
//                ForEach(viewModel.device.ingredients, id: \.self) { ingredient in
//                    Text(ingredient)
//                }
//            }
//
//            Section(header: Text("Directions")) {
//                ForEach(viewModel.device.steps, id: \.self) { step in
//                    Text(step)
//                }
//            }
        }
        .navigationBarItems(trailing: ratingsButton)
        .navigationTitle(Text(viewModel.newsItem.title ?? ""))
    }

    @ViewBuilder
    private var ratingsButton: some View {
        Button(action: viewModel.openRatings) {
            Image(systemName: "person.3.fill")
        }
        //.modifier(ratingModifier)
    }

//    @ViewBuilder
//    private var sourceOverlay: some View {
//        if let source = viewModel.device.source {
//            HStack {
//                Image(systemName: "safari")
//                Text("Source")
//                Spacer()
//            }
//            .font(.headline)
//            .padding(.horizontal, 20)
//            .padding(.vertical, 8)
//            .background(Color(.systemBackground).opacity(0.75))
//            .onTapGesture { viewModel.open(source) }
//        }
//    }

}
