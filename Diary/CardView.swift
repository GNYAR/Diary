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

func moodToColor(x: Mood) -> Color {
  switch x {
  case .excellent:
    return Color(.systemPink)
  case .good:
    return Color(.systemGreen)
  case .bad:
    return Color(.systemBlue)
  case .terrible:
    return Color(.systemGray)
  }
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
  @State var showAlert = false
  
  var body: some View {
    VStack {
      CardHeader(diary: $diary, showAlert: $showAlert)
      
      Divider().padding(.bottom, 8)
      
      Form {
        Toggle("Did you work today?", isOn: $diary.hasWork)
        
        if(diary.hasWork) {
          VStack(alignment: .leading) {
            Text("How long have you worked?")
            
            Stepper("\(diary.workHours, specifier: "%.2f")", value: $diary.workHours, in: 0...24)
            
            Slider(value: $diary.workHours, in: 0...24)
          }
        }
        
        Section(header: Text("Write something...").textCase(.none)) {
          TextField("Title", text: $diary.title)
            .font(.title3)
          
          TextEditor(text: $diary.story)
            .frame(height: 200)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .animation(.linear)
    }
    .padding()
    .background(diary.color.padding(.vertical, -50))
    .alert(isPresented: $showAlert, content: {
      Alert(
        title: Text("Apply to the color?"),
        primaryButton: .default(Text("OK"), action: { diary.color = moodToColor(x: diary.mood) }),
        secondaryButton: .cancel()
      )
    })
  }
}

struct CardHeader: View {
  @Binding var diary: Diary
  @Binding var showAlert: Bool
  @State var showMoodPicker = false
  
  var body: some View {
    DisclosureGroup(
      isExpanded: $showMoodPicker,
      content: {
        Picker("Mood", selection: $diary.mood) {
          ForEach(Mood.allCases) { x in
            Text(x.rawValue)
          }
        }
        .onChange(of: diary.mood, perform: { value in
          showAlert = true
        })
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
  }
}
