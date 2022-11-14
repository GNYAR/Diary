//
//  DateView.swift
//  Diary
//
//  Created by User20 on 2022/11/9.
//

import SwiftUI

enum Weather: String, CaseIterable, Identifiable {
  var id: Weather { self }
  
  case sunny = "sun.max"
  case cloudy = "smoke"
  case windy = "wind"
  case rainy = "cloud.rain"
  
  var diplayName: String {
    get {
      switch self {
      case .sunny:
        return "Sunny"
      case .cloudy:
        return "Cloudy"
      case .windy:
        return "Windy"
      case .rainy:
        return "Rainy"
      }
    }
  }
}

struct DateView: View {
  @Binding var diary: Diary
  
  var body: some View {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyy-MM-dd"
    
    return VStack(alignment:.leading) {
      DatePicker(
        "Pick a date",
        selection: $diary.date,
        in: ...Date(),
        displayedComponents: .date
      )
      .datePickerStyle(GraphicalDatePickerStyle())
      
      HStack {
        Label(dateformatter.string(from: diary.date), systemImage: "calendar")
        
        Spacer()
        
        Button("Today", action: {diary.date = Date()})
      }
      
      DisclosureGroup {
        Picker("Weather", selection: $diary.weather) {
          ForEach(Weather.allCases) { x in
            Image(systemName: x.rawValue)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      } label: {
        Label(diary.weather.diplayName, systemImage: diary.weather.rawValue)
      }
    }
  }
}
