//
//  DatePickerInputView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-17.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CalendarSheet: ViewModifier {
    @Binding var presented: Bool
    @Binding var dateStr: String?
    
    @State var calendarDate: Date = Date()
    
    init(presented: Binding<Bool>, dateString: Binding<String?>) {
        _presented = presented
        _dateStr = dateString
        calendarDate = Globals.dateFormatter.optionalDate(from: dateString.wrappedValue) ?? Date()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            //content
            
            VStack {
                Spacer()
                VStack {
                    HStack{
                        Button {
                            presented = false
                            dateStr = Globals.dateFormatter.string(from: calendarDate)
                        } label: {
                            Text(LocalizedString.Buttons.saveTitle)
                                .applyStyle(style: .buttonTitleStyleSecondary)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    DatePicker("", selection: $calendarDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .environment(\.calendar, .init(identifier: .persian))
                        .environment(\.locale, Locale.init(identifier: "fa"))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .offset(y: presented ? 0 : 550)
            }
        }
        .animation(.default, value: presented)
    }
}

struct DurationSheet: ViewModifier {
    @Binding var presented: Bool
    @Binding var duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                VStack {
                    HStack{
                        Button {
                            presented = false
                        } label: {
                            Text(LocalizedString.Buttons.saveTitle)
                                .applyStyle(style: .buttonTitleStyleSecondary)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                   DurationPicker(duration: $duration)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .offset(y: presented ? 0 : 550)
            }
        }
        .animation(.default, value: presented)
    }
}

extension View {
    func calendarSheet(presented: Binding<Bool>, dateStr: Binding<String?>) -> some View {
        modifier(CalendarSheet(presented: presented, dateString: dateStr))
    }
}

extension View {
    func durationSheet(presented: Binding<Bool>, duration: Binding<TimeInterval>) -> some View {
        modifier(DurationSheet(presented: presented, duration: duration))
    }
}

struct Globals {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}

extension DateFormatter {
    func optionalDate(from date: String?) -> Date? {
        guard let newDate = date else { return nil }
        return self.date(from: newDate)
    }
}

extension TimeInterval{
    func getHourAndMin() -> (hour: Int, min: Int) {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        print("min \(minutes)")
        return (hours, minutes)
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




private struct Distances {
    static let hidden: CGFloat = 500
    static let maxUp: CGFloat = -100
    static let dismiss: CGFloat = 200
}
//
//struct BottomSheet<Content: View>: View {
//    @Binding var isPresented: Bool
//    @ViewBuilder let content: Content
//
//    @State private var translation = Distances.hidden
//
//    var body: some View {
//        ZStack {
//            Color.gray
//                .opacity(0.5)
//
//            VStack {
//                Spacer()
//                contentView
//                    .offset(y: translation)
//                    .animation(.interactiveSpring(), value: isPresented)
//                    .animation(.interactiveSpring(), value: translation)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { value in
//                                guard translation > Distances.maxUp else { return }
//                                translation = value.translation.height
//                            }
//                            .onEnded { value in
//                                if value.translation.height > Distances.dismiss {
//                                    translation = Distances.hidden
//                                    isPresented = false
//                                } else {
//                                    translation = 0
//                                }
//                            }
//                    )
//            }
//            .background(
//                VStack {
//                    Spacer()
//                    Color.clear
//                        .frame(height: abs(Distances.maxUp) * 2)
//                }
//            )
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            withAnimation {
//                translation = 0
//            }
//        }
//    }
//
//    private var contentView: some View {
//        VStack(spacing: 0) {
//            handle
//                .padding(.top, 6)
//            content
//                .padding(20)
//                .padding(.bottom, 30)
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .cornerRadius(24)
//        .shadow(color: Color.gray, radius: 2, x: 0, y: -2)
//    }
//
//    private var handle: some View {
//        RoundedRectangle(cornerRadius: 3)
//            .fill(Color.gray)
//            .frame(width: 48, height: 5)
//    }
//}
//
//
//extension View {
//    func bottomSheet<Content: View>(
//        isPresented: Binding<Bool>,
//        @ViewBuilder content: @escaping () -> Content
//    ) -> some View {
//        self
//            .overlay(
//                Group {
//                    if isPresented.wrappedValue {
//                        BottomSheet(
//                            isPresented: isPresented,
//                            content: content
//                        )
//                    }
//                }
//            )
//    }
//}
