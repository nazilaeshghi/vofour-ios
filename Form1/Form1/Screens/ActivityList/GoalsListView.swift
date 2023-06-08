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
    @State var currentWeekIsOn: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: PublicTheme.vHeaderSpace) {
            VerticalSpaceView(space: .title)
            ScrollSegmentControl(segments: viewModel.segments,
                                 spacing: 20,
                                 activeSegment: $viewModel.selectedGoalIndex,
                                 style: PublicTheme.segmentStyle ) { segment in
                viewModel.reloadData()
            }
            
            HStack {
                Toggle("", isOn: $currentWeekIsOn)
                .tint(Color.primaryColor)
                .onChange(of: currentWeekIsOn) { newValue in
                    viewModel.currentWeek.toggle()
                    viewModel.reloadData()
                }
                .toggleStyle(ColoredToggleStyle())
                .frame(width: 36)
                .frame(height: 20)
                .padding(.trailing, 8)
                
                Text(LocalizedString.GoalList.currentWeekTitle)
                    .applyStyle(style: .regularSubtitle)

            }

            
            if !viewModel.items.isEmpty {
                List {
                    ForEach(viewModel.items, id: \.id) { sectionItem in
                        Section {
                            ForEach(sectionItem.items, id: \.id) { item in
                                ActivityListCellView(item: item, hideProgress: !currentWeekIsOn)
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
            else {
                Spacer()
            }
        }
        .applyBasicViewStyle()
        .sheet(item: $taskID, content: { taskId in
            AppCoordinator.shared.makeTaskDetailsView(taskId: taskId, selectedDate: Date())
                .environment(\.layoutDirection, .rightToLeft)
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
        GoalsListView(viewModel: GoalsListViewModel(dataManager: ActivityListDataMock()), currentWeekIsOn: false)
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
