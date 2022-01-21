//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation

import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    
    private let remoteSignIn: SignInRemoteDataSource = .shared
    
    private let local: LocalDataSource = .shared
}


extension SignUpInteractor {
    
    func postUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppErrorModel> {
       return remoteSignUp.postUser(request: request)
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppErrorModel> {
       return remoteSignIn.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
