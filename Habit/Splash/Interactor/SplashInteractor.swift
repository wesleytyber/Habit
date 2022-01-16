//
//  SplashInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}


extension SplashInteractor {

    func fecthAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequestModel) -> Future<SignInResponse, AppErrorModel> {
       return remote.refreshToken(request: request)
    }
}

