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
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .textCase(.none)
    }
}
