//
//  AdCard.swift
//  Diary
//
//  Created by User20 on 2022/11/14.
//

import SwiftUI

struct AdCard: View {
  @Binding var isFullScreen: Bool
  @Binding var str: String
  @Binding var img: String
  
  var body: some View {
    return VStack(alignment: .leading){
      Text(str)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.top, 8)
      
      Image(img)
        .resizable()
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
          Label(img, systemImage: "mappin.circle.fill")
            .foregroundColor(.white)
            .font(.caption)
            .padding(8)
            .background(Color(.darkGray))
          ,alignment: .topTrailing
        )
    }
    .background(Color(.secondarySystemBackground).padding(.horizontal, -20))
    .onTapGesture(perform: { isFullScreen = true })
  }
}

struct AdInfo: View {
  @Binding var isFullScreen: Bool
  @Binding var img: String
  let str: String
  
  var body: some View {
    VStack(alignment: .leading){
      HStack{
        Spacer()
        
        Button(action: { isFullScreen = false }, label: {
          Image(systemName: "x.circle")
            .resizable()
            .frame(width: 24, height: 24)
        })
      }
      
      Text(str)
      
      Divider()
      
      VStack(alignment: .leading) {
        Image(img)
          .resizable()
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 10))
        
        HStack{
          Label(img, systemImage: "mappin.circle.fill")
            .foregroundColor(.white)
          
          Spacer()
          
          Menu("Let's trip") {
            Link("Airbnb", destination: URL(string: "https://www.airbnb.com/s/\(img)/homes")!)
            Link("booking.com", destination: URL(string: "https://www.booking.com/searchresults.html?ss=\(img)")!)
          }
          .padding(.horizontal, 8)
          .background(Capsule().foregroundColor(.white))
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
      }.background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray))
      
      Button(action: { img = views.randomElement()! }, label: {
        Label("Change a place", systemImage: "arrow.triangle.2.circlepath.circle")
      })
      
      Spacer()
    }
    .padding(.horizontal)
  }
}
