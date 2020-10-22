import Combine
import Foundation

// I'd normally write "fetcher" instead of "fetching", but I'm trying to be more in line with the
// Swift API Guidelines:
//
// > - Protocols that describe what something is should read as nouns (e.g. Collection).
// > - Protocols that describe a capability should be named using the suffixes able, ible, or ing
// >   (e.g. Equatable, ProgressReporting).
//
// I think fetching data from the network is indeed more of an ability a type has rather than
// something a type is.
protocol NetworkFetching {

    // I was tempted to use generics, like:
    //
    // ```
    // func load<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error>
    // ```
    //
    // But, I can't find a way to write a test double that allows me to control the return value
    // of a generic function.
    //
    // Using `Data` is also neat because it creates a boundary between the raw result from the
    // network and what the application can decide to do with it.
    //
    // This could be refined further by adding a version with the `(Data, URLResponse)` tuple.
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}

// This extension defines utilities on top of the basic networking that types conforming to
// `NetworkFetching` have to provide.
//
// From the testing point of view, this means that we'll only have to define a test double for the
// methods defined in the protocol, and we'll get all the rest of this functionality for free.
// In turn, that means that we can test this extension is isolation and in the tests we can simply
// provide raw `Data` as the input to our test doubles.
extension NetworkFetching {

    func load(_ url: URL) -> AnyPublisher<Data, URLError> {
        return load(URLRequest(url: url))
    }

    func load<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        return load(URLRequest(url: url))
    }

    func load<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return load(request)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
