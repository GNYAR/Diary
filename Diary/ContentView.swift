//
//  ContentView.swift
//  Diary
//
//  Created by User20 on 2022/10/26.
//

import SwiftUI

struct Diary: Identifiable {
  let id = UUID()
  
  var date: Date = Date()
  var weather: Weather = Weather.sunny
  var mood: Mood = Mood.good
  var color: Color = Color.green
  var title: String = "ttt"
  var story: String = "sss"
}

struct ContentView: View {
  @State var selectedDiary = Diary()
  @State private var showEditCard = false
  
  
  var body: some View {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyy-MM-dd"
    
    return VStack(alignment:.leading) {
      DateView(diary: $selectedDiary)
      
      Spacer()
    }
    .padding(.horizontal)
    .overlay(
      PreviewCard(diary: $selectedDiary, showSheet: $showEditCard)
        .offset(y: 60),
      alignment: .bottom
    )
    .sheet(isPresented: $showEditCard) {
      EditCard(diary: $selectedDiary)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct DatePickerSection: View {
  @State private var selectedDate = Date()
  @State private var showAlert = false
  
  var body: some View {
    Section(header: Button("DatePicker", action: {
      showAlert = true
    })) {
      DatePicker("Pick a date", selection: $selectedDate)
        .labelsHidden()
      
      HStack {
        Text("Date:")
        DatePicker(
          "Pick a date",
          selection: $selectedDate,
          displayedComponents: .date
        )
        .labelsHidden()
      }
      
      HStack {
        Text("Time:")
        DatePicker(
          "Pick a time",
          selection: $selectedDate,
          displayedComponents: .hourAndMinute
        )
        .labelsHidden()
      }
    }
    .alert(isPresented: $showAlert, content: {
      let dateFormatter = DateFormatter()
      
      return Alert(
        title: Text("DateTime"),
        message: Text(dateFormatter.string(from: selectedDate)),
        dismissButton: .cancel()
      )
    })
  }
}
