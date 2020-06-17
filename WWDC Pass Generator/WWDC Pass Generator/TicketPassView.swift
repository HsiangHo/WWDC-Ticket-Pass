//
//  TicketPassView.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/16/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import SwiftUI

struct TicketPassView: View {
    @ObservedObject var config: PassConfiguration

    let viewSize = NSSize(width: 282, height: 367)
    let viewPadding: CGFloat = 15
    var viewShape: Path {
        let rectView = NSRect(x: 0, y: 0, width: viewSize.width + viewPadding * 2, height: viewSize.height + viewPadding * 2)
        var shape = Rectangle().path(in: rectView)
        let radius: CGFloat = 75
        let circle = Circle().size(width: radius, height: radius)
        shape.addPath(circle.path(in: rectView).offsetBy(dx: (rectView.width - radius) / 2, dy: -(radius * 0.78)))
        return shape
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2) {
                Image("apple-logo")
                Text(config.eventName)
                    .bold()
                    .foregroundColor(.white)
                    .font(.appFont(size: 23))
                    .baselineOffset(-8)
                    .tracking(1)
            }.padding(.bottom, 22)

            VStack(alignment: .leading, spacing: 6) {
                Text("ATTENDEE")
                    .foregroundColor(.white)
                    .font(.appFont(size: 10))
                    .bold()
                    .tracking(1)
                Text(config.attendee)
                    .foregroundColor(.white)
                    .font(.appFont(size: 17))
            }.padding(.bottom, 30)

            VStack(alignment: .leading, spacing: 5) {
                Text("DATES")
                    .foregroundColor(.white)
                    .font(.appFont(size: 10))
                    .bold()
                    .tracking(1)
                Text(config.dates)
                    .foregroundColor(.white)
                    .font(.appFont(size: 12))
                    .fontWeight(.light)
            }.padding(.bottom, 23)

            VStack(alignment: .leading, spacing: 4) {
                Text("LOCATION")
                    .foregroundColor(.white)
                    .font(.appFont(size: 10))
                    .bold()
                    .tracking(1)
                Text(config.location)
                    .foregroundColor(.white)
                    .font(.appFont(size: 12))
                    .fontWeight(.light)
            }

            Spacer()

            HStack(alignment: .center) {
                Spacer()
                Image("barcode")
                Spacer()
            }
            .padding(.bottom, 2)
        }
        .frame(width: viewSize.width, height: viewSize.height, alignment: .topLeading)
        .padding(.all, viewPadding)
        .background(LinearGradient(gradient: Gradient(colors: [.init(hex: "8b8b8b"), .init(hex: "111111")]), startPoint: .top, endPoint: .bottom))
        .mask(viewShape.fill(style: FillStyle(eoFill: true)))
        .shadow(radius: 2)
    }
}

struct TicketPassView_Previews: PreviewProvider {
    @ObservedObject static var passConfiguration = PassConfiguration()

    static var previews: some View {
        TicketPassView(config: passConfiguration)
    }
}
