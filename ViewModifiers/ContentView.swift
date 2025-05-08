import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("Black")
                .ignoresSafeArea()
            
            TabView {
                icon
                ablum
            }
            #if os(iOS)
            .tabViewStyle(.page)
            #endif
            .padding(.vertical)
        }
    }
    
    var icon: some View {
        LinearGradient(colors: [Color("Red"), Color("Gold"), Color("Light")],
                       startPoint: .top, endPoint: .bottom)
        .aspectRatio(1.0, contentMode: .fit)
        .frame(width: 120)
        .clipShape(.rect(cornerRadius: 26))
        .padding(32)
        .background(Color("Black"))
        .blur(radius: 32, offset: 0.3, distance: 0.5)
    }
    
    var ablum: some View {
        Image("sanjin")
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: 256)
            .blur(radius: 8.0, offset: 0.7, distance: 0.2)
            .overlay {
                LinearGradient(stops: [.init(color: .clear, location: 0.5), .init(color: .black.opacity(0.6), location: 0.8)], startPoint: .top, endPoint: .bottom)
            }
            .clipShape(.rect(cornerRadius: 12.0))
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("Shu Mii")
                        .font(.headline)
                    Text("Dominic Fike")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
    }
}

#Preview {
    ContentView()
}
