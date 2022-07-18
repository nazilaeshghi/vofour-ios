//
//  DurationPicker.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct DurationSheetView: View {
    @Binding var presented: Bool
    @Binding var selectredDuration: DurationObject?
    
    @State private var selectedDurationID = 0
    let durations = Globals.makeDurations()
    
    init(presented: Binding<Bool>, selectredDuration: Binding<DurationObject?>) {
        _presented = presented
        _selectredDuration = selectredDuration
        _selectedDurationID = State(initialValue: selectredDuration.wrappedValue?.tag ?? 0)
    }
        
    var body: some View {
        VStack {
            ModalHeaderView(title: LocalizedString.Input.durationSelectoreTitle) {
                presented = false
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            
            Picker("Color Scheme", selection: $selectedDurationID) {
                ForEach(durations, id: \.id) { durationItem in
                    Text(durationItem.amount.timeStr ?? "")
                        .applyStyle(style: .deselectedButtonTitleStyle)
                        .tag(durationItem.tag)
                }
            }
            .pickerStyle(.wheel)
            
            Button {
                presented = false
                selectredDuration = durations[safe: selectedDurationID]
            } label: {
                Spacer()
                Text(LocalizedString.Buttons.saveTitle)
                    .applyStyle(style: .buttonTitleStyle)
                Spacer()
            }
            .applyStyle(style: .multiplePrimary)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
            
            Spacer()
        }
    }
}

struct DurationPicker: UIViewRepresentable {
    @Binding var duration: TimeInterval

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.countDownDuration = duration
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: DurationPicker

        init(_ parent: DurationPicker) {
            self.parent = parent
        }

        @objc func updateDuration(datePicker: UIDatePicker) {
            parent.duration = datePicker.countDownDuration
        }
    }
}
