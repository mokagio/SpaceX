import Foundation

// Cheap version of https://github.com/mokagio/RemoteData
enum RemoteData<Resource: Equatable, Error: Swift.Error>: Equatable {
    case notAsked
    case loading
    case failure(Error)
    case success(Resource)

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.notAsked, .notAsked):
            return true
        case (.loading, .loading):
            return true
        case (.failure(let lhsError), .failure(let rhsError)):
            return (lhsError as NSError) == (rhsError as NSError)
        case (.success(let lhsResource), .success(let rhsResource)):
            return lhsResource == rhsResource
        default:
            return false
        }
    }
}
