//
//  View+Navigation.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

import SwiftUI

extension View {

    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }

    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }

    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }

}

extension NavigationLink {

    init<T: Identifiable, D: View>(item: Binding<T?>,
                                   @ViewBuilder destination: (T) -> D,
                                   @ViewBuilder label: () -> Label) where Destination == D? {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        self.init(
            destination: item.wrappedValue.map(destination),
            isActive: isActive,
            label: label
        )
    }

}
