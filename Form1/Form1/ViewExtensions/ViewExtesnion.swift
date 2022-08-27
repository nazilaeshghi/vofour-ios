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
                    VStack(spacing: .zero) {
                        Text(title)
                            .applyStyle(style: .regularTitle)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        action()
                    } label: {
                        Image.closeIcon
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func applyToolbarBackStyle(with title: String, backAction: DismissAction) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: .zero) {
                        Text(title)
                            .applyStyle(style: .regularTitle)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        backAction()
                    } label: {
                        Image.backArrow
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func applyToolbarWithBackStyle(with title: String, hideBakcButton: Bool = false, backAction: DismissAction, closeAction: @escaping () -> Void) -> some View {
        if hideBakcButton {
            self
                .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: .zero) {
                        Text(title)
                            .applyStyle(style: .regularTitle)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        closeAction()
                    } label: {
                        Image.closeIcon
                    }
                }
            }
                .navigationBarTitleDisplayMode(.inline)
        } else {
            self
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: .zero) {
                            Text(title)
                                .applyStyle(style: .regularTitle)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            backAction()
                        } label: {
                            Image.backArrow
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            closeAction()
                        } label: {
                            Image.closeIcon
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func applyBasicCellStyle() -> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
    }
    
    func applyBasicViewStyle() -> some View {
        self
            .padding(.horizontal, PublicTheme.hPadding)
            .applyBackgroundColor()
    }
    
    func applyBackgroundColor() -> some View {
        self
            .background(Color.background.ignoresSafeArea())
    }
    
    func applyScrollViewPadding(top: Bool = true, bottom: Bool = true ) -> some View {
        self
            .if(top) { view in
                view.safeAreaInset(edge: .top, spacing: .zero) {
                    Spacer().frame(height: PublicTheme.scrollViewPadding)
                }
            }
            .if(bottom) { view in
                view.safeAreaInset(edge: .bottom, spacing: .zero) {
                    Spacer().frame(height: PublicTheme.scrollViewPadding)
                }
            }
    }
    
    func applyHScrollViewPadding(left: Bool = true, right: Bool = true ) -> some View {
        self
            .if(left) { view in
                view.safeAreaInset(edge: .leading, spacing: PublicTheme.scrollViewPadding) {
                    Spacer().frame(height: PublicTheme.scrollViewPadding)
                }
            }
            .if(right) { view in
                view.safeAreaInset(edge: .trailing, spacing: PublicTheme.scrollViewPadding) {
                    Spacer().frame(height: PublicTheme.scrollViewPadding)
                }
            }
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
