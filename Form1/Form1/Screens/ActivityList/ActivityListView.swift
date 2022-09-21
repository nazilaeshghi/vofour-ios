//
//  ActivityListView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ActivityListView: View {
    @StateObject var viewModel: ActivityListViewModel

    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace) {
            Text(LocalizedString.ActicityList.title)
                .applyStyle(style: .mediumTitle)
            
            LineSegmentPicker(items: viewModel.segmentItems,
                              selection: $viewModel.selectedType)
            
            VStack(alignment: .leading , spacing: PublicTheme.vHeaderSpace) {
                ActivityListFilterView(selectedDuration: $viewModel.selectedDuration)
                Text("۲۰ شهریور" + " - " + " ۲۶ شهریور ۱۴۰۰")
                    .applyStyle(style: .secondaryRegularBody)
            }
            .applyBasicViewStyle()
            
            List {
                ForEach(viewModel.items, id: \.id) { sectionItem in
                    Section {
                        VStack(spacing: PublicTheme.collectionSpace) {
                            HStack() {
                                if sectionItem.iconName != nil {
                                    Image(sectionItem.iconName ?? "").frame(width: 24, height: 24)
                                }
                                Text(sectionItem.title.plainText)
                                    .applyStyle(style: sectionItem.title.labelStyle)
                                Spacer()
                            }
                           
                            
                            ForEach(sectionItem.items, id: \.id) { item in
                                ActivityListCellView(item: item)
                                    .applyBasicCellStyle()
                            }
                        }
                    }
                }
                .applyBasicCellStyle()
            }
            .applyListBasicStyle()
            .applyBasicViewStyle()
        }
        .applyBackgroundColor()
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
        ActivityListView(viewModel: ActivityListViewModel(dataManager: ActivityListDataMock()))
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
