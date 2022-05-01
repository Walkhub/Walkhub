// swiftlint:disable function_body_length
import Foundation

import Swinject

public extension Container {

    func registerServiceDependencies() {
        registerRepositories()
        registerUseCases()
    }

    private func registerRepositories() {
        self.register(AuthRepository.self) { _ in DefaultAuthRepository() }
        self.register(BadgeRepository.self) { _ in DefaultBadgeRepository() }
        self.register(ExercisesRepository.self) { _ in DefaultExercisesRepository() }
        self.register(ImageRepository.self) { _ in DefaultImageRepository() }
        self.register(LevelRepository.self) { _ in DefaultLevelRepository() }
        self.register(NoticeRepository.self) { _ in DefaultNoticeRepository() }
        self.register(NotificationRepository.self) { _ in DefaultNotificationRepository() }
        self.register(RankRepository.self) { _ in DefaultRankRepository() }
        self.register(SchoolRepository.self) { _ in DefaultSchoolRepository() }
        self.register(UserRepository.self) { _ in DefaultUserRepository() }
    }

    private func registerUseCases() {

        self.register(CheckIsSigninedUseCase.self) { resolver in
            return CheckIsSigninedUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(SigninUseCase.self) { resolver in
            return SigninUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(SignupUseCase.self) { resolver in
            return SignupUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }
        self.register(VerificationPhoneUseCase.self) { resolver in
            return VerificationPhoneUseCase(authRepository: resolver.resolve(AuthRepository.self)!)
        }

        self.register(FetchExerciseAnalysisUseCase.self) { resolver in
            return FetchExerciseAnalysisUseCase(
                exerciseRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchLiveDailyExerciseRecordUseCase.self) { resolver in
            return FetchLiveDailyExerciseRecordUseCase(
                exerciseRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(SynchronizeDailyExerciseRecordUseCase.self) { resolver in
            return SynchronizeDailyExerciseRecordUseCase(
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }

        self.register(FetchCalroiesLevelUseCase.self) { resolver in
            return FetchCalroiesLevelUseCase(
                levelRepository: resolver.resolve(LevelRepository.self)!,
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }

        self.register(FetchNotificationListUseCase.self) { resolver in
            return FetchNotificationListUseCase(
                notificationRepository: resolver.resolve(NotificationRepository.self)!
            )
        }
        self.register(ReadNotificationUseCase.self) { resolver in
            return ReadNotificationUseCase(
                notificationRepository: resolver.resolve(NotificationRepository.self)!
            )
        }
        self.register(SearchSchoolUseCase.self) { resolver in
            return SearchSchoolUseCase(
                schoolRepository: resolver.resolve(SchoolRepository.self)!
            )
        }
        self.register(FetchRankPreviewUseCase.self) { resolver in
            return FetchRankPreviewUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(FetchSchoolDetailsUseCase.self) { resolver in
            return FetchSchoolDetailsUseCase(
                schoolRepository: resolver.resolve(SchoolRepository.self)!
            )
        }
        self.register(FetchSchoolRankUseCase.self) { resolver in
            return FetchSchoolRankUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(FetchUserRankUseCase.self) { resolver in
            return FetchUserRankUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(FetchUserSchoolRankUseCase.self) { resolver in
            return FetchUserSchoolRankUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(SearchSchoolRankUseCase.self) { resolver in
            return SearchSchoolRankUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(SearchUserUseCase.self) { resolver in
            return SearchUserUseCase(
                rankRepository: resolver.resolve(RankRepository.self)!
            )
        }
        self.register(FetchWeekStepCountChartsUseCase.self) { resolver in
            return FetchWeekStepCountChartsUseCase(
                exerisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchMonthStepCountChartsUseCase.self) { resolver in
            return FetchMonthStepCountChartsUseCase(
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchExercisesListUseCase.self) { resolver in
            return FetchExercisesListUseCase(
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(StartExerciseUseCase.self) { resolver in
            return StartExerciseUseCase(
                exercisesRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchMeasuringExerciseUseCase.self) { resolver in
            return FetchMeasuringExerciseUseCase(
                exerciseRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchRecordExerciseUseCase.self) { resolver in
            return FetchRecordExerciseUseCase(
                exerciseRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(EndExerciseUseCase.self) { resolver in
            return EndExerciseUseCase(
                exerciseRepository: resolver.resolve(ExercisesRepository.self)!
            )
        }
        self.register(FetchProfileUseCase.self) { resolver in
            return FetchProfileUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        self.register(FetchHealthInformationUseCase.self) { resolver in
            return FetchHealthInformationUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        self.register(EditHealthInformationUseCase.self) { resolver in
            return EditHealthInformationUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        self.register(EditProfileUseCase.self) { resolver in
            return EditProfileUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        self.register(PostImageUseCase.self) { resolver in
            return PostImageUseCase(
                imageRepository: resolver.resolve(ImageRepository.self)!
            )
        }
        self.register(NotificationOnUseCase.self) { resolver in
            return NotificationOnUseCase(
                notificationRepository: resolver.resolve(NotificationRepository.self)!
            )
        }
        self.register(NotificationOffUseCase.self) { resolver in
            return NotificationOffUseCase(
                notificationRepository: resolver.resolve(NotificationRepository.self)!
            )
        }
        self.register(CheckVerificationCodeUseCase.self) { resolver in
            return CheckVerificationCodeUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        self.register(CheckAccountIdUseCase.self) { resolver in
            return CheckAccountIdUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        self.register(SetHealthInformationUseCase.self) { resolver in
            return SetHealthInformationUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
    }
}
