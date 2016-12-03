//
//  TaskSuggestionPresenter.swift
//  Jirassic
//
//  Created by Cristian Baluta on 30/11/2016.
//  Copyright © 2016 Imagin soft. All rights reserved.
//

import Foundation

protocol TaskSuggestionPresenterInput: class {
    func setup (startSleepDate: Date?, endSleepDate: Date?)
    func selectSegment (atIndex index: Int)
    func save (selectedSegment: Int, notes: String, startSleepDate: Date?, endSleepDate: Date?)
}

protocol TaskSuggestionPresenterOutput: class {
    func setTaskType (_ taskType: TaskSubtype)
    func setTime (_ notes: String)
    func setNotes (_ notes: String)
    func hideTaskTypes()
}

class TaskSuggestionPresenter {
    
    weak var userInterface: TaskSuggestionPresenterOutput?
    
    fileprivate func taskSubtype (forIndex index: Int) -> TaskSubtype {
        
        switch index {
            case 0: return .scrumEnd
            case 1: return .meetingEnd
            case 2: return .lunchEnd
            case 3: return .napEnd
            case 4: return .learningEnd
            default: return .issueEnd
        }
    }
    
    fileprivate func selectedSegment (forTaskType taskType: TaskType) -> Int {
        
        switch taskType {
        case .scrum: return 0
        case .meeting: return 1
        case .lunch: return 2
        case .nap: return 3
        case .learning: return 4
        default: return -1
        }
    }
}

extension TaskSuggestionPresenter: TaskSuggestionPresenterInput {
    
    func setup (startSleepDate: Date?, endSleepDate: Date?) {
        
        var time = ""
        if let startDate = startSleepDate {
            time += startDate.HHmm() + " - "
        }
        time += endSleepDate!.HHmm()
        userInterface!.setTime(time)
        
        if let startDate = startSleepDate {
            let interactor = ComputerWakeUpInteractor(repository: localRepository)
            if let type = interactor.estimationForDate(startDate) {
                if type == .startDay {
                    userInterface!.setNotes("Start working day")
                    userInterface!.hideTaskTypes()
                } else {
                    let index = selectedSegment(forTaskType: type)
                    selectSegment(atIndex: index)
                }
            }
        } else {
            userInterface!.setNotes("Start working day")
            userInterface!.hideTaskTypes()
        }
    }
    
    func selectSegment (atIndex index: Int) {
        
        let type = taskSubtype(forIndex: index)
        userInterface!.setNotes(type.defaultNotes)
    }
    
    func save (selectedSegment: Int, notes: String, startSleepDate: Date?, endSleepDate: Date?) {
        
        let type = taskSubtype(forIndex: selectedSegment)
        
        var task = Task(subtype: type)
        task.notes = notes
        task.taskNumber = type.defaultTaskNumber
        task.startDate = startSleepDate
        task.endDate = endSleepDate!
        
        let saveInteractor = TaskInteractor(repository: localRepository)
        saveInteractor.saveTask(task)
    }
}