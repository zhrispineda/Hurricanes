//
//  ViewExtensions.swift
//  Hurricanes
//

import SwiftUI

extension View {
    func sectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }
}

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .listRowInsets(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
            .textCase(.none)
    }
}
