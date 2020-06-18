//
//  InspectorView.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/16/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import SwiftUI

struct InspectorView: View {
    @ObservedObject var config: PassConfiguration

    var editorPadding: EdgeInsets = {
        EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                Text(LocalizedStrings.Event)
                    .font(.appFont(size: 12))
                    .padding(.top, 15)
                TextField(LocalizedStrings.EventPlaceHolder, text: $config.eventName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
                    .padding(editorPadding)
                Text(LocalizedStrings.EventAttendee)
                    .font(.appFont(size: 12))
                TextField(LocalizedStrings.EventAttendeePlaceHolder, text: $config.attendee)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(editorPadding)
                Text(LocalizedStrings.EventDates)
                    .font(.appFont(size: 12))
                TextField(LocalizedStrings.EventDatesPlaceHolder, text: $config.dates)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(editorPadding)
                Text(LocalizedStrings.EventLocation)
                    .font(.appFont(size: 12))
                TextField(LocalizedStrings.EventLocationPlaceHolder, text: $config.location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(editorPadding)
            }

            Group {
                Text(LocalizedStrings.Color1)
                    .font(.appFont(size: 12))
                EmbeddedColorWell(selectedColor: $config.color1)
                    .frame(width: 100, height: 20, alignment: .topLeading)
                    .padding(editorPadding)

                Text(LocalizedStrings.Color2)
                    .font(.appFont(size: 12))
                EmbeddedColorWell(selectedColor: $config.color2)
                    .frame(width: 100, height: 20, alignment: .topLeading)
                    .padding(editorPadding)
            }

            Divider()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))

            Group {
                HStack(alignment: .firstTextBaseline) {
                    Text(LocalizedStrings.PassTypeID)
                        .font(.appFont(size: 12))
                    TextField(LocalizedStrings.PassTypeIDPlaceHolder, text: $config.passTypeID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(editorPadding)
                }
                HStack(alignment: .firstTextBaseline) {
                    Text(LocalizedStrings.TeamID)
                        .font(.appFont(size: 12))
                    TextField(LocalizedStrings.TeamIDPlaceHolder, text: $config.teamID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(editorPadding)
                }
                DatePicker(LocalizedStrings.ExpireDate, selection: $config.expiryDate)
                    .padding(editorPadding)
            }

            Spacer()
        }
    }
}


struct InspectorView_Previews: PreviewProvider {
    @ObservedObject static var passConfiguration = PassConfiguration()
    
    static var previews: some View {
        InspectorView(config: passConfiguration)
    }
}
