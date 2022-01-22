//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 22/01/22.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppErrorModel> {
       return remote.fetchUser()
    }
    
    func updateUser(userId: Int, profileRequest: ProfileRequest ) -> Future<ProfileResponse, AppErrorModel> {
        return remote.updateUser(userId: userId, request: profileRequest)
    }
}

