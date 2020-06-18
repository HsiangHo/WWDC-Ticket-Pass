//
//  ContentView.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/16/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var passConfiguration = PassConfiguration()

    var ticketPassView: TicketPassView {
        TicketPassView(config: passConfiguration)
    }
    
    var inspectorView: InspectorView {
        InspectorView(config: passConfiguration)
    }

    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(LocalizedStrings.WWDCTicket)
                    .font(.appFont(size: 12))
                    .fontWeight(.medium)
                    .padding(.bottom, 5)
                    .padding(.top, 15)
                    .foregroundColor(.init(hex: "444444"))
                    .frame(maxWidth: .infinity, alignment: .center)
                ticketPassView
                    .padding(EdgeInsets(top: 0, leading: 50, bottom: 20, trailing: 50))
                Text(LocalizedStrings.LivePreview)
                    .font(.appFont(size: 10))
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
            }
            Divider()
            VStack(alignment: .leading) {
                Text(LocalizedStrings.AttributesInspector)
                    .font(.appFont(size: 10))
                    .fontWeight(.medium)
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
                inspectorView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 10, trailing: 15))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
