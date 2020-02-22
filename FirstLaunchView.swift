//
//  FirstLaunchView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 11.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

// content base
struct DetailsView: View {
    var title: String = "title"
    var subTitle: String = "subtitle"
    var imageName: String = "car.fill"
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(Color.green)
                .padding()
                .accessibility(hidden: true)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

// content container
struct DetailsContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            DetailsView(title: "Concise",
                        subTitle: "Everything you need is just a tap away.",
                        imageName: "exclamationmark.bubble.fill")
            DetailsView(title: "Informative",
                        subTitle: "Need to know a professor's E-Mail?\nOr perhaps the way to V2-221?\nNo problem!",
                        imageName: "magnifyingglass.circle.fill")
            DetailsView(title: "Made in Germany",
                        subTitle: "This application is entirely open-source and was made right here at the Bielefeld University.",
                        imageName: "heart.fill")
        }
        .padding(.horizontal)
    }
}

// Header
struct HeaderView: View {
    var body: some View {
        VStack {
            Text("My")
                .customTitleText()
            
            Text("UniBi")
                .customTitleText()
                .foregroundColor(Color.green)
        }
    }
}

struct FirstLaunchView: View {
    var body: some View {
        NavigationView{
            ScrollView {
                    VStack(alignment: .center) {
                        Spacer()
                        HeaderView()
                        DetailsContainerView()
                        Spacer(minLength: 30)
                        NavigationLink(destination: HomeView()) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.green))
                            .padding(.bottom)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}

// ext
extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}
