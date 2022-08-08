//
//  GeometryPreferenceKeyView.swift
//  PreferencedKey
//
//  Created by Skorobogatow, Christian on 8/8/22.
//

import SwiftUI

struct GeometryPreferenceKeyView: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(.blue)
            
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)

                }
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeomtrySizePreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct GeometryPreferenceKeyView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyView()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeomtrySizePreferenceKey.self, value: size)
    }
}


struct RectangleGeomtrySizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
