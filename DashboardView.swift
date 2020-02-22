//
//  DashboardView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 11.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

// construct a Card
struct CardViewBase: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var category: String = "Category"
    var subTitle: String = "This is a subtitle"
    var author: String = "Author"
    var articleURL: String = ""
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    Text(subTitle)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .lineLimit(3)
                    Text(author.uppercased())
                        .font(.caption)
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
                .layoutPriority(100)
                Spacer()
                Spacer()
            }
        .padding()
        .onTapGesture {
            let url = URL(string: self.articleURL)
            UIApplication.shared.open(url!)
            }
        Spacer()
        }
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .foregroundColor(colorScheme == .light ? Color.white : Color.init(red: 40/255, green: 40/255, blue: 40/255))
            .shadow(radius: 5)
        )
        .padding([.top, .horizontal])
    }
}

// View
struct DashboardView: View {
    // data
    @ObservedObject var rssList = unibiRSSList()
    
    var body: some View {
        if (self.rssList.contentList.count != 0) {
            return AnyView(ScrollView {
                ForEach(rssList.contentList, id: \.id) { i in
                    CardViewBase(category: i.category, subTitle: i.title, author: i.publishedDate, articleURL: i.link)
                }
            })
        } else {
            return AnyView(Text("Loading..."))
        }
    }
}

// debugView
struct debugView : View {
    var body: some View {
        CardViewBase()
    }
}

// Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        debugView()
    }
}
