//
//  SwiftUIView.swift
//  CoordinatorSwiftUIKit
//
//  Created by Cary Zhou on 2/25/21.
//

import SwiftUI
import Combine

struct SwiftUIView: View {
    @EnvironmentObject var coordinator: MyCoordinator

    let text: String
    let color: Color

    var body: some View {
        VStack {
            Text("Simon says: \n\(text)")
            Button("Push UIKit View") {
                coordinator.navigate(to: .uikit)
            }
            Button("Push SwiftUI View") {
                coordinator.navigate(to: .swiftui)
            }
            Button("Add Count: \(coordinator.myCount)") {
                coordinator.myCount += 1
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color)
        // We can change the UIKit navigation title
        .navigationTitle("SwiftUI View")

        // We can subscribe to changes on published objects via SwiftUI
        .onChange(of: coordinator.myCount) { (value) in
            print("Value Changed SwiftUI: \(value)")
        }

        // We can subscribe to changes on published objects via Combine
        .onAppear {
            coordinator.$myCount.sink { (value) in
                print("Value Changed SwiftUI with Combine: \(value)")
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(text: "What's up, dog?", color: .clear)
            .environmentObject(MyCoordinator(UINavigationController()))

    }
}
