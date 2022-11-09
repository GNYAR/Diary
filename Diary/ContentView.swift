//
//  ContentView.swift
//  Diary
//
//  Created by User20 on 2022/10/26.
//

import SwiftUI



struct ContentView: View {
  @State var selectedDate = Date()
  @State var selectedWeather = Weather.sunny
  @State private var selectedColor = Color.green
  @State private var selectedMood = Mood.good
  @State private var showDatepicker = true
  @State private var title = ""
  @State private var story = ""
  
  var body: some View {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyy-MM-dd"
    
    return VStack(alignment:.leading) {
      DateView(date: $selectedDate, weather: $selectedWeather)
      CardView(color: $selectedColor, mood: $selectedMood, title: $title, story: $story)
    }
    .padding(.horizontal)
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
