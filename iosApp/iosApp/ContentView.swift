import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject var model = NewsListModel()
	let greet = Greeting().greeting()

	var body: some View {
        //Text(greet)
        Text(greet).onAppear {
            self.model.loadNews()
        }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
