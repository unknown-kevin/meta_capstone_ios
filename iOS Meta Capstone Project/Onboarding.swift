import SwiftUI

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    // MARK: PROPERTIES
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    @State private var showAlert = false

    @Environment(\.presentationMode) var presentation

    // MARK: BODY
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .frame(height: 100)
                
                VStack {
                    HStack {
                        VStack {
                            Text("Little Lemon")
                                .foregroundColor(Color("yellow"))
                                .font(.custom("Karla-Regular", size: 40))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Chicago")
                                .foregroundColor(Color("grey"))
                                .font(.custom("Karla-Regular", size: 30))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 0.5)
                        
                           
                            Text("""
                             We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                             """)
                            .foregroundColor(Color("grey"))
                            .font(.custom("MarkaziText-Regular", size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineSpacing(0.15)
                        }
                        .padding(10)
                        
                        Image("Hero image")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(maxWidth: 120, maxHeight: 140)
                            .clipShape(Rectangle())
                            .cornerRadius(16)
                            .padding(10)
                    }
                    .background(Color("green"))
                }
              
                VStack {
                    NavigationLink(destination: Home(),  isActive: $isLoggedIn) { EmptyView()}
                    
                    Text("First Name *")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color("black"))
                    
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color.black)

                    Text("Last Name *")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color("black"))
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color.black)

                    Text("Email * ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color("black"))
                    
                    TextField("Email",text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Karla-Regular", size: 14))
                        .foregroundColor(Color.black)
                        .keyboardType(.emailAddress)
                    
                    Button(action:{
                        if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            isLoggedIn = true
                            UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                            
                            // Navigate to UserProfile view
                            self.isLoggedIn = true
                        }
                        else {
                            showAlert = true
                        }
                    }) {
                        Text("Register")
                    }
                    .foregroundColor(Color("black"))
                    .padding([.bottom, .top],8)
                    .padding([.leading, .trailing],8)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("yellow"))
                    )
                    .padding(.top, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Validation Error"),
                            message: Text("Please fill in all fields."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Spacer()
                    
                }.padding(10)

            }.onAppear{if ( UserDefaults.standard.bool(forKey: "kIsLoggedIn")) {
                isLoggedIn=true
                
            }
                
            }
        }
        
    }
}

// MARK: PREVIEWS
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
