//
//  SegmentedPicker.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct BackgroundGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color
                .clear
                .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}

struct SizeAwareViewModifier: ViewModifier {
    @Binding private var viewSize: CGSize
    
    init(viewSize: Binding<CGSize>) {
        self._viewSize = viewSize
    }
    
    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: {
                if self.viewSize != $0 { self.viewSize = $0 }
            })
    }
}

struct SegmentedPicker: View {
    private static let ActiveSegmentColor: Color = .primaryColor
    private static let BackgroundColor: Color = .segmentBG
    private static let TextColor: Color = .primaryColor
    private static let SelectedTextColor: Color = .white
    
    private static let SegmentCornerRadius: CGFloat = PublicTheme.inputTextCornerRadius
    private static let xPadding: CGFloat = 16
    private static let yPadding: CGFloat = 8
    private static let pickerPadding: CGFloat = 4
    private static let AnimationDuration: Double = 0.1
    
    // Stores the size of a segment, used to create the active segment rect
    @State private var segmentSize: CGSize = .zero
    
    // Rounded rectangle to denote active segment
    private var activeSegmentView: AnyView {
        // Don't show the active segment until we have initialized the view
        // This is required for `.animation()` to display properly, otherwise the animation will fire on init
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        
        return RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius)
            .foregroundColor(SegmentedPicker.ActiveSegmentColor)
            .frame(width: self.segmentSize.width, height: self.segmentSize.height)
            .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
            .animation(Animation.linear(duration: SegmentedPicker.AnimationDuration))
            .eraseToAnyView()
    }
    
    @Binding private var selection: Int
    private let items: [String]
    
    init(items: [String], selection: Binding<Int>) {
        self._selection = selection
        self.items = items
    }
    
    var body: some View {
        // Align the ZStack to the leading edge to make calculating offset on activeSegmentView easier
        ZStack(alignment: .leading) {
            activeSegmentView // current selection view
            HStack {
                ForEach(0..<self.items.count, id: \.self) { index in
                    getSegmentView(for: index)
                }
            }
        }
        .padding(SegmentedPicker.pickerPadding)
        .background(SegmentedPicker.BackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius))
    }
    
    // Helper method to compute the offset based on the selected index
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.segmentSize.width + SegmentedPicker.xPadding / 2)
    }
    
    // Gets text view for the segment
    private func getSegmentView(for index: Int) -> some View {
        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }
        
        let isSelected = (selection == index)
        let textColor = isSelected ? SegmentedPicker.SelectedTextColor : SegmentedPicker.TextColor
        
        return Text(self.items[index])
        // Dark test for selected segment
            .scaledFont(family: .regular, style: .subtitle)
            .foregroundColor(textColor)
            .lineLimit(1)
            .padding(.vertical, SegmentedPicker.yPadding)
            .padding(.horizontal, SegmentedPicker.xPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
            .onTapGesture { self.onItemTap(index: index) }
            .eraseToAnyView()
    }
    
    // On tap to change the selection
    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
    }
}
