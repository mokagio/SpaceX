// Cheap version of https://github.com/mokagio/RemoteData
enum RemoteData<Resource, Error: Swift.Error> {
    case notAsked
    case loading
    case failure(Error)
    case success(Resource)
}
