//
//  NewsListCoordinatorView.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

struct NewsListCoordinatorView: View {

        // MARK: Stored Properties

        @ObservedObject var coordinator: NewsListCoordinator

        // MARK: Views

        var body: some View {
            NavigationView {
                VStack {
                NewsList(viewModel: coordinator.viewModel)
                    .navigation(item: $coordinator.newsViewModel) { viewModel in
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            phoneRecipeView(viewModel)
                        } else {
                            padRecipeView(viewModel)
                        }
                    }
            }
            }
        }

        @ViewBuilder
        private func phoneRecipeView(_ viewModel: NewsViewModel) -> some View {
            NewsView(
                viewModel: viewModel//,
//                ratingModifier: SheetModifier(item: $coordinator.ratingViewModel) { viewModel in
//                    NavigationView {
//                        RatingView(viewModel: viewModel)
//                    }
//                }
            )
        }

        @ViewBuilder
        private func padRecipeView(_ viewModel: NewsViewModel) -> some View {
            NewsView(
                viewModel: viewModel //,
//                ratingModifier: PopoverModifier(item: $coordinator.ratingViewModel) {
//                    RatingView(viewModel: $0)
//                        .frame(width: 500, height: 500)
//                }
            )
        }

    }
