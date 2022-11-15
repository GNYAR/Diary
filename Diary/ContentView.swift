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
  var color: Color = moodToColor(x: Mood.good)
  var title: String = "Title"
  var story: String = "I feel good."
  var hasWork: Bool = false
  var workHours: Float = 0
}

struct ContentView: View {
  @State var selectedDiary = Diary()
  @State var showAdDetail = false
  @State var quote = quotes.randomElement()!
  @State var view = views.randomElement()!
  @State private var showEditCard = false
  
  var body: some View {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyy-MM-dd"
    
    return VStack(alignment:.leading) {
      DateView(diary: $selectedDiary, showAdDetail: $showAdDetail, quote: $quote, view: $view)
        .fullScreenCover(isPresented: $showAdDetail, content: {
          AdInfo(isFullScreen: $showAdDetail , img: $view, str: quote)
        })
      
      Spacer()
    }
    .padding(.horizontal)
    .overlay(
      PreviewCard(diary: $selectedDiary, showSheet: $showEditCard)
        .offset(y: 60)
        .sheet(isPresented: $showEditCard) {
          EditCard(diary: $selectedDiary)
        },
      alignment: .bottom
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
