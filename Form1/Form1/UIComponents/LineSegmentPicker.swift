//
//  LineSegmentPicker.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct LineSegmentPicker: View {
    private static let activeSegmentColor: Color = .primaryTextColor
    private static let unselectedSegmentColor: Color = .unSelectedSegmentColor
    private static let selectedTextColor: Color = .primaryTextColor
    
    private static let cornerRadius: CGFloat = PublicTheme.inputTextCornerRadius
    private static let xPadding: CGFloat = 16
    private static let yPadding: CGFloat = 8
    private static let pickerPadding: CGFloat = 4
    private static let animationDuration: Double = 0.1
    
    @State private var segmentSize: CGSize = .zero
    
    private var activeSegmentView: AnyView {
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        
        return RoundedRectangle(cornerRadius: LineSegmentPicker.cornerRadius)
            .foregroundColor(LineSegmentPicker.activeSegmentColor)
            .frame(width: self.segmentSize.width, height: 2)
            .animation(Animation.linear(duration: LineSegmentPicker.animationDuration))
            .eraseToAnyView()
    }
    
    private var segmentLibeBackgroundView: AnyView {
        return VStack {
            Spacer()
            RoundedRectangle(cornerRadius: LineSegmentPicker.cornerRadius)
                .foregroundColor(LineSegmentPicker.unselectedSegmentColor)
                .frame(height: 2)
                .eraseToAnyView()
        }
        .eraseToAnyView()
    }
    
    @Binding private var selection: Int
    private let items: [String]
    
    init(items: [String], selection: Binding<Int>) {
        self._selection = selection
        self.items = items
    }
    
    var body: some View {
       
        ZStack {
            segmentLibeBackgroundView
            
            VStack(alignment: .leading) {
                HStack {
                    ForEach(0..<self.items.count, id: \.self) { index in
                        getSegmentView(for: index)
                    }
                }
                activeSegmentView
            }
            .clipShape(RoundedRectangle(cornerRadius: LineSegmentPicker.cornerRadius))
        }
        .frame(height: self.segmentSize.height)
    }
    
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.segmentSize.width + LineSegmentPicker.xPadding / 2)
    }
    
    private func getSegmentView(for index: Int) -> some View {
        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }
        
        let isSelected = (selection == index)
        let textColor = isSelected ? LineSegmentPicker.selectedTextColor : LineSegmentPicker.unselectedSegmentColor
        
        return Text(self.items[index])
            .scaledFont(family: .regular, style: .subtitle)
            .foregroundColor(textColor)
            .lineLimit(1)
            .padding(.vertical, LineSegmentPicker.yPadding)
            .padding(.horizontal, LineSegmentPicker.xPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
            .onTapGesture { self.onItemTap(index: index) }
            .eraseToAnyView()
    }
    
    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
    }
}


struct LineSegmentPicker_Previews: PreviewProvider {
    static var previews: some View {
        LineSegmentPicker(items: ["اهداف", " زمینه‌ها"], selection: .constant(0))
    }
}

