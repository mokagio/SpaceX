func groupLaunchesIntoSectionsByName(_ launches: [Launch]) -> [SectionSource<Launch>] {
    return Dictionary(
        grouping: launches,
        by: { "\($0.date.year)" }
    )
    .map { key, value in SectionSource(title: key, items: value) }
    .sorted { $0.title < $1.title }

}
