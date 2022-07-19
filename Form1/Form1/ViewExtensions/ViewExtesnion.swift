//
//  ViewExtesnion.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/29/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func applyToolbarStyle(with title: String, action: @escaping () -> Void) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text(title)
                            .applyStyle(style: LabelStyle.number)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        action()
                    } label: {
                        Image("close")
                    }
                }
            }
    }
    
    func applyToolbarWithBackStyle(with title: String, backAction: DismissAction, closeAction: @escaping () -> Void) -> some View {
        return self
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text(title)
                            .applyStyle(style: LabelStyle.number)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        backAction()
                    } label: {
                        Image("backButton")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        closeAction()
                    } label: {
                        Image("close")
                    }
                }
            }
        
    }
}
