//
//  ContentView.swift
//  PreferencedKey
//
//  Created by Skorobogatow, Christian on 8/8/22.
//

import SwiftUI

struct PreferenceKeyView: View {
    
    @State private var text: String = "Hello, world!"
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyView()
    }
}



struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDataBase)
            .customTitle(newValue)
    }
    
    func getDataFromDataBase() {
        //download fake data
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
    }
}


struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
