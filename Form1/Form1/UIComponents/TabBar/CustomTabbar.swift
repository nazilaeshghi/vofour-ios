//
//  CustomTabbar.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @State private var showingSheet = false

    var body: some View  {
        VStack(spacing: .zero) {
            Spacer()
                .frame(height: PublicTheme.textsSpacing)
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    tabView(tab: tab)
                        .onTapGesture {
                            if tab.tag != 2 {
                                switchTabTo(tab: tab)
                            }
                            else {
                                showingSheet = true
                            }
                        }
                }
            }
            .frame(height: 45)
        }
        .background(Color.background.ignoresSafeArea(edges: .bottom))
        .shadow(
            color: Color.gray.opacity(0.2),
            radius: 6,
            x: 0,
            y: 0
        )
        .fullScreenCover(isPresented: $showingSheet) {
            
        } content: {
            AppCoordinator.shared.makeSelectContextView()
        }


    }
}

struct CustomTabBarView_Preview: PreviewProvider {
    static let tabs: [TabBarItem] = [ .home, .booklet, .add, .activities,.report ]
    
    static var previews: some View {
        VStack {
            CustomTabBarView(tabs: tabs,
                             selection: .constant(.home))
        }
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack(spacing: .zero) {
            if tab.tag == 2 {
                Image(tab.iconName)
                    .offset(y: -16)
            } else {
                Image(selection.tag == tab.tag ? tab.selectedIconName : tab.iconName)
                Text(tab.title)
                    .applyStyle(style: .primaryRegularBody)
            }
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
    }
    
    private func switchTabTo(tab: TabBarItem) {
        selection = tab
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

