//
//  ActivityListView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct GoalsListView: View {
    @StateObject var viewModel: GoalsListViewModel
    @State private var taskID: String?
    @State private var selectedSegmentIndex = 0
    
    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace) {
            ScrollSegmentControl(segments: viewModel.segments,
                                 spacing: 20,
                                 activeSegment: $selectedSegmentIndex,
                                 style: PublicTheme.segmentStyle ) { segment in
                
            }
            
            List {
                ForEach(viewModel.items, id: \.id) { sectionItem in
                    Section {
                        ForEach(sectionItem.items, id: \.id) { item in
                            ActivityListCellView(item: item)
                                .onTapGesture {
                                    taskID = item.id
                                }
                                .applyBasicCellStyle()
                        }
                    }
                }
                .applyBasicCellStyle()
            }
            .applyListBasicStyle()
        }
        .applyBasicViewStyle()
        .sheet(item: $taskID, content: { taskId in
            AppCoordinator.shared.makeSelectContextView(taskId: taskId)
        })
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
            viewModel.reloadData()
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsListView(viewModel: GoalsListViewModel(dataManager: ActivityListDataMock()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

struct ActivityListFilterView: View {
    @Binding var selectedDuration: Durationtype
    
    var body: some View {
        HStack (spacing: PublicTheme.hPadding) {
            Button {
                selectedDuration = .week
            } label: {
                Text(LocalizedString.ActicityList.currentWeek)
                    .applyStyle(style: selectedDuration == .week ? .brightRegularSubtitle : .primaryRegularSubtitle)
            }
            .applyStyle(style: selectedDuration == .week ? .regularSelected : .regularUnSelected)
            
            
            Button {
                selectedDuration = .all
            } label: {
                Text(LocalizedString.ActicityList.allActivities)
                    .applyStyle(style: selectedDuration == .all ? .brightRegularSubtitle : .primaryRegularSubtitle)
            }
            .applyStyle(style: selectedDuration == .all ? .regularSelected : .regularUnSelected)
            
            Spacer()
        }
    }
}

enum Durationtype: Hashable {
    case week, all
}
