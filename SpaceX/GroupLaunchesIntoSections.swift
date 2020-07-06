func groupLaunchesIntoSectionsByName(_ launches: [Launch]) -> [SectionSource<Launch>] {
    return launches
        .sorted { $0.name < $1.name }
        .reduce([SectionSource<Launch>]()) { acc, current in
            // TODO: it would be good to ensure a nonempty string...
            let title = current.name.first?.uppercased() ?? ""

            guard let lastSection = acc.last else {
                return [SectionSource(title: title, items: [current])]
            }

            guard lastSection.title != title else {
                return
                    Array(acc[0 ..< acc.count - 1])
                    +
                    [SectionSource<Launch>(
                        title: title,
                        items: lastSection.items + [current]
                    )]
            }

            return acc + [SectionSource<Launch>(title: title, items: [current])]
        }
}
