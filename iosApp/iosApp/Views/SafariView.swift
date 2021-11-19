//
//  SafariView.swift
//  iosApp
//
//  Created by Ilya Nechoysa on 19.11.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    // MARK: Stored Properties

    let url: URL

    // MARK: Methods

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        return SFSafariViewController(url: url, configuration: configuration)
    }

    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {

    }

}
