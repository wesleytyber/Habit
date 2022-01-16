//
//  SignInInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}


extension SignInInteractor {
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppErrorModel> {
       return  remote.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
