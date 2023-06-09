//
//  SelectGoalView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/21/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectGoalView: View {
    @StateObject var viewModel: SelectGoalViewModel
    
    @State private var showingSheet = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(spacing: .zero) {
            Spacer()
            ModalHeaderView(title: LocalizedString.SelectGoalPage.selectGoalPageTitle) {
                presentationMode.wrappedValue.dismiss()
            }

            List {
                Section {
                    SelectGoalCell(item: viewModel.defaultItem)
                        .onTapGesture {
                            viewModel.selectGoal(goalID: viewModel.defaultItem.id)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .applyBasicCellStyle()
                }
                
                if !viewModel.items.isEmpty {
                    Section(header: Text(LocalizedString.SelectGoalPage.sectionHeader)
                                .applyStyle(style: .mediumSubtitle)) {
                        ForEach(viewModel.items, id: \.id) { item in
                            SelectGoalCell(item: item)
                                .onTapGesture {
                                    viewModel.selectGoal(goalID: item.id)
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .applyBasicCellStyle()
                        }
                    }
                }
            }
            .applyListBasicStyle()
            .applyBasicViewStyle()
            .applyScrollViewPadding()
            
            Spacer()

            PrimarySubmitButton(title: LocalizedString.SelectGoalPage.buttonTitle, action: {
                showingSheet = true
            })
                .frame(height: PublicTheme.buttonHeight)
            .applyBasicViewStyle()
        }
        .background(Color.background)
        .sheet(isPresented: $showingSheet) {
            showingSheet = false
            viewModel.getGoals()
        } content: {
            AppCoordinator.shared.makeCreateGoalView(isPresented: $showingSheet)
        }
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = .clear
        })
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SelectGoalView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = SelectGoalDataManagableMock()
        let viewModel = SelectGoalViewModel(dataManager: dataManager)
        SelectGoalView(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
