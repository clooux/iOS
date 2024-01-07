//
//  ContentView.swift
//  Week2
//
//  Created by user249775 on 12/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var tasks: [Task] = [
        Task(id:1, name: "Task1", completed: false, image: "potato"),
        Task(id:2, name: "Task2", completed: false),
        Task(id:3, name: "Task3", completed: false),
    ]
    
    var body: some View {
        NavigationStack{
            List($tasks) { $task in
                HStack{
                    Button(action: {
                        if let index = tasks.firstIndex(where: {$0.id == task.id}){
                            tasks[index].completed = !tasks[index].completed
                            print(tasks[index].completed)
                        }
                    }) {
                        Image(systemName: task.completed ? "checkmark.circle" : "circle").foregroundColor(task.completed ? .green : .gray)
                    }
                    HStack{
                        NavigationLink(destination: TaskView(task: $task)){
                            Text(task.name)
                        }
                    }
                }
                .swipeActions(edge: .leading){
                    Button(role: .destructive, action: {
                        if let index = tasks.firstIndex(where: {$0.id == task.id}){
                            tasks.remove(at: index)
                        }
                    })
                    {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            
            .padding()
            .navigationTitle("Task List")
        }
    }
}

#Preview {
    ContentView()
}
