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
    @State private var newGoalTitle: String? = nil
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()
            ModalHeaderView(title: LocalizedString.SelectGoalPage.selectGoalPageTitle) {
                presentationMode.wrappedValue.dismiss()
            }
           
            List {
                Section {
                    SelectGoalCell(item: viewModel.defaultItem)
                        .padding([.vertical], 10)
                        .background(PublicTheme.background)
                        .onTapGesture {
                            viewModel.selectGoal(goalID: viewModel.defaultItem.id)
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                
                if !viewModel.items.isEmpty {
                    Section(header: Text(LocalizedString.SelectGoalPage.sectionHeader)
                                .applyStyle(style: .sectionHeaderStyle)) {
                        ForEach(viewModel.items, id: \.id) { item in
                            SelectGoalCell(item: item)
                                .padding([.vertical], 10)
                                .background(PublicTheme.background)
                                .onTapGesture {
                                    viewModel.selectGoal(goalID: item.id)
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                }
            }
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
                UITableView.appearance().backgroundColor = .clear
            })
            .background(PublicTheme.background)
            
            PrimarySubmitButton(title: LocalizedString.SelectGoalPage.buttonTitle, action: {
                showingSheet = true
            })
                .sheet(isPresented: $showingSheet) {
                    if let title = newGoalTitle {
                        viewModel.addGoal(title: title)
                    }
                } content: {
                    NewGoalView(goalName: $newGoalTitle, isPresented: $showingSheet)
                }
            Spacer()
            
        }
        .background(PublicTheme.background)
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
