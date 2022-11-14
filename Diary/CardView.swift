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

struct PreviewCard: View {
  @Binding var diary: Diary
  @Binding var showSheet: Bool
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(diary.mood.rawValue)
        
        Text(diary.title)
        
        Spacer()
        
        Image(systemName: "chevron.up.circle")
          .foregroundColor(.accentColor)
          .background(Circle().foregroundColor(.white))
          .onTapGesture(perform: { showSheet = true })
      }.font(.title)
      
      Spacer()
    }
    .frame(height: 100)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(diary.color)
    )
  }
}

struct EditCard: View {
  @Binding var diary: Diary
  @State var showMoodPicker = false
  
  var body: some View {
    VStack {
      DisclosureGroup(
        isExpanded: $showMoodPicker,
        content: {
          Picker("Mood", selection: $diary.mood) {
            ForEach(Mood.allCases) { x in
              Text(x.rawValue)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white))
        },
        label: {
          HStack {
            Text(diary.date, style: .date)
            
            Spacer()
            
            HStack {
              ColorPicker("Color", selection: $diary.color)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .labelsHidden()
              
              Divider().frame(height: 20)
              
              Text(diary.mood.rawValue)
            }
            .background(
              Capsule()
                .foregroundColor(.white)
                .padding(.trailing, -28)
            )
            
            
          }
        }
      ).labelStyle(TitleOnlyLabelStyle())
      
      Divider().padding(.bottom, 8)
      
      TextField("Title", text: $diary.title)
        .font(.title3)
        .padding(.horizontal)
        .padding(.vertical, 4)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .foregroundColor(.white)
        )
      
      VStack(alignment: .leading) {
        Text("Write something...")
          .padding(.top, 8)
          .padding(.bottom, -4)
        
        TextEditor(text: $diary.story)
          .frame(height: 400)
          .clipShape(RoundedRectangle(cornerRadius: 5))
      }
      
      Spacer()
    }
    .padding()
    .background(diary.color.padding(.vertical, -50))
  }
}
