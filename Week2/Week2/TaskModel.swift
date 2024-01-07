//
//  TaskModel.swift
//  Week2
//
//  Created by user249775 on 12/6/23.
//

import Foundation

struct Task: Identifiable {
    let id: Int
    let name: String
    var completed: Bool
    var image: String?
}
