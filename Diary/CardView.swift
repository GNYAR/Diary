//
//  CardView.swift
//  Diary
//
//  Created by User20 on 2022/11/9.
//

import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
  var id: Mood { self }
  
  case excellent = "😃"
  case good = "🙂"
  case bad = "☹️"
  case terrible = "😵"
}

struct CardView: View {
  @Binding var color: Color
  @Binding var mood: Mood
  @Binding var title: String
  @Binding var story: String
  
  var body: some View {
    List {
      VStack(alignment: .leading) {
        Text("How are you?")
        
        Picker("Mood", selection: $mood) {
          ForEach(Mood.allCases) { x in
            Text(x.rawValue)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      ColorPicker("color", selection: $color)
      
      TextField("Title", text: $title)
      
      TextEditor(text: $story)
        .lineLimit(10)
        .padding(.leading, -4)
        .opacity(story.isEmpty ? 0.25 : 1)
        .background(
          Text("Write something...")
            .opacity(0.25)
            .padding(.top, 8),
          alignment: .topLeading)
      
    }
    
  }
}
