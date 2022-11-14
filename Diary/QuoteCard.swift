//
//  QuoteCard.swift
//  Diary
//
//  Created by User20 on 2022/11/14.
//

import SwiftUI

struct QuoteCard: View {
  var body: some View {
    let view = views.randomElement()!
    
    VStack(alignment: .leading){
      Text(quotes.randomElement()!)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.top, 8)
      
      Image(view)
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
          Label(view, systemImage: "mappin.circle.fill")
            .foregroundColor(.white)
            .font(.caption)
            .padding(8)
            .background(Color(.darkGray))
          ,alignment: .topTrailing
        )
    }
    .background(Color(.secondarySystemBackground).padding(.horizontal, -20))
  }
}

struct QuoteCard_Previews: PreviewProvider {
  static var previews: some View {
    QuoteCard()
  }
}
