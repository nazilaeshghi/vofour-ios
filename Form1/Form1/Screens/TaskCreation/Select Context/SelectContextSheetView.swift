//
//  SelectContextSheetView.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-05.
//  Copyright © 2023 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContextSheetView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: SelectContextViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace) {
            Spacer()
            ModalHeaderView(title: LocalizedString.ContextPage.selectContexts) {
                presentationMode.wrappedValue.dismiss()
            }
            Group {
                SelectContextHeaderView(searchText: $searchText)
                    .onChange(of: searchText) { newValue in
                        viewModel.filterContextas(with: searchText)
                    }
                
                List($viewModel.items, id: \.id) { item in
                    SelectContextCell(item: item)
                        .onTapGesture {
                            viewModel.selectContext(id: item.contextID.wrappedValue)
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .applyListBasicStyle()
            }
            .applyBasicViewStyle()
        }
        .applyBackgroundColor()
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SelectContextSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = SelectContextDataManagableMock()
        let viewModel = SelectContextViewModel(dataManager: dataManager)
        SelectContextSheetView(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
