How to integrate Apple signIn iOS 13 (Swift) in your iOS app

With iOS13, Apple introduced "Sign In with Apple", an authentication method for users to create account in your app with their Apple account.


Why and When you need to use "Sign in with Apple"? 

If you application use 3rd party authentication like Google, Facebook, Twitter, AWS etc, Apple need to have its authentication method as well, otherwise you will face app store rejection. 
App store rejection for not having Apple Sign in in appYou can have "Sign in with Apple" anyway in your app if you don't have any such 3rd party login.
Steps of integration:

Step 1: Configure your Identifier in Apple developer portal to add "Sign In with Apple" and regenerate your provisioning profile. 

Step 2: In xCode > Project> Signing & Capabilities> Add Capability! Search for the "Sign in with Apple" and add. 
-> Search for the "Sign in with Apple"
After you add "Sign in with Apple" you will see it under the Signing.

Step 3: Import AuthenticationServices Framework
import AuthenticationServices

Step 4: Create Apple SignIn Button

@objc private func signInButtonAction() {
            if #available(iOS 13.0, *) {
                let authorizationProvider = ASAuthorizationAppleIDProvider()
                let request = authorizationProvider.createRequest()
                request.requestedScopes = [.email, .fullName]
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                authorizationController.delegate = self
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
            } else {
                // Fallback on earlier versions
            
            }
            
        }

Step 5: Implement ASAuthorizationControllerDelegate (Copy and paste from the attached demo) AppleUser is a custom model class that store user information.
We only get user Name and Email first time in the app and when we authenticate it another time we only get identifier. To preserve the user data we are saving it in the Keychain so that we can use this data even later to save on server or access it later. 
 @available(iOS 13.0, *)
    extension AppleSignIn: ASAuthorizationControllerDelegate {
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
                guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                    return
                }
                 print("AppleID Credential Authorization: userId: \(appleIDCredential.user), email: \(String(describing: appleIDCredential.email)),  name: \(String(describing: appleIDCredential.fullName))")
            
            
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            complitionHandler?(nil, error.localizedDescription)
            print("AppleID Credential failed with error: \(error.localizedDescription)")
            
        }
    }

    @available(iOS 13.0, *)
    extension AppleSignIn: ASAuthorizationControllerPresentationContextProviding {
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.window!
        }
    }

Thanks for reading :) 

