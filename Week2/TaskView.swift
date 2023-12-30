//
//  TaskView.swift
//  Week2
//
//  Created by user249775 on 12/6/23.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Task
    
    var body: some View {
        VStack {
            Text(task.name)
                .font(.title)
                .padding()
            Image(task.image ?? "task")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
        .navigationTitle(task.name)
    }
}

//#Preview {
//    TaskView(task: tasks[0])
//}
