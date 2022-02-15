import Foundation

import Swinject

public extension Container {

    func registerServiceDependencies() {
        registerRepositories()
        registerUseCases()
    }

    private func registerRepositories() {
        self.register(AuthRepository.self) { _ in DefaultAuthRepository() }
        self.register(ExercisesRepository.self) { _ in DefaultExercisesRepository() }
    }

    private func registerUseCases() {
        self.register(SinginUseCase.self) { resolver in
            return SinginUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(SingupUseCase.self) { resolver in
            return SingupUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(VerificationPhoneUseCase.self) { resolver in
            return VerificationPhoneUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(SynchronizeDailyExerciseRecordUseCase.self) { resolver in
            return SynchronizeDailyExerciseRecordUseCase(
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
    }

}
