//
//  TaskCreationStep1ViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import Combine

class TaskCreationStep1ViewModel: ObservableObject {
    private let dataManager: TaskCreationStep1DataManagable
    
    @Published private(set) var selectedGoalTitle: String?
    @Published private(set) var selectedContextTitle: String?
    @Published var selectedType: Int = 0
    @Published var titleInputText: String = ""
    @Published var contextInputText: String = ""
    @Published var preventionInputText: String = ""
    @Published var reasonInputText: String = ""
    @Published var for100InputText: String = ""
    let editMode: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: TaskCreationStep1DataManagable, editMode: Bool) {
        self.dataManager = dataManager
        selectedGoalTitle = dataManager.getSelectedGoalTitle()
        selectedContextTitle = dataManager.getContextName(editMode: editMode)
        selectedType = dataManager.getIsActivity() == true ? 0 : 1
        titleInputText = dataManager.getActivityTitle()
        preventionInputText = dataManager.getPrevention()
        reasonInputText = dataManager.getReason()
        for100InputText = dataManager.getFor100()
        self.editMode = editMode
     }
    
    func header() -> String {
        if editMode {
            return LocalizedString.TaskCreationStep1.editHeader
        } else {
            return LocalizedString.TaskCreationStep1.createHeader
        }
    }
    
    func initBinders() {
        $titleInputText
            .sink { [dataManager] newValue in
                dataManager.updateActivityTitle(with: newValue)
            }
            .store(in: &cancellables)
        
        $preventionInputText
            .sink { [dataManager] newValue in
                dataManager.updatePrevention(with: newValue)
            }
            .store(in: &cancellables)
        
        $reasonInputText
            .sink { [dataManager] newValue in
                dataManager.updateReason(with: newValue)
            }
            .store(in: &cancellables)
        
        $for100InputText
            .sink { [dataManager] newValue in
                dataManager.updateFor100(with: newValue)
            }
            .store(in: &cancellables)
        
        $selectedType
            .sink { [dataManager] newValue in
                dataManager.updateIsActivity(with: newValue == 0)
            }
            .store(in: &cancellables)
    }
    
    func getSelectedGoalID() -> String? {
        return dataManager.getSelectedGoalID()
    }
    
    func refreshGoalTitle() {
        selectedGoalTitle = dataManager.getSelectedGoalTitle()
    }
    
    func refreshContextTitle() {
        selectedContextTitle = dataManager.getContextName(editMode: editMode)
    }
    
    func reset() {
        dataManager.resetDataEntry()
    }
}
