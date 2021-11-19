import SwiftUI

@main
struct iOSApp: App {

    @StateObject var coordinator = HomeCoordinator()
    //let store: ObservableNewsStore

	var body: some Scene {
		WindowGroup {
            HomeCoordinatorView(coordinator: coordinator)
		}
	}
}
