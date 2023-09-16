//
//  UserProfile.swift
//  iOS Meta Capstone Project
//
//  Created by Cristina on 2023-09-15.
//

import SwiftUI

struct UserProfile: View {
    
    // MARK : PROPERTIES
    // Constants to hold user data from UserDefaults
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""

    @Environment(\.presentationMode) var presentation
    
    // MARK: BODY
    var body: some View {
        VStack {
            Text("Personal information")
                .foregroundColor(Color("black"))
                .font(.custom("MarkaziText-Regular", size: 25))
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
                .clipShape(Circle())
                .padding(.vertical, 30)
            
            // Display user data
            Form {
                Text("First Name:  \(firstName)")
                    .font(.custom("MarkaziText-Regular", size: 16))
                Text("Last Name:  \(lastName)")
                    .font(.custom("MarkaziText-Regular", size: 16))
                Text("Email:  \(email)")
                    .font(.custom("MarkaziText-Regular", size: 16))
            }
            .frame(height: 200)
            
            Spacer()
            
            HStack {
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss() // Go back to the previous screen (Onboarding)
                }
                .foregroundColor(Color("black"))
                .padding([.bottom, .top],8)
                .padding([.leading, .trailing],8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("yellow"))
            )
            }
            .padding()
            
            Spacer() // To make items start from the top
        }
    }
}

// MARK: PREVIEW
struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
